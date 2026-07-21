from datetime import datetime, timezone
from hashlib import sha256
from hmac import compare_digest
from uuid import UUID

from fastapi import HTTPException
from sqlalchemy import case, func, select
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncSession

from core.models import GlucoseRecord, TrackerUser
from .schemas import SyncRequest


def token_digest(token: str) -> str:
    return sha256(token.encode("utf-8")).hexdigest()


async def records_for_user(
    session: AsyncSession,
    user: TrackerUser,
    date_from=None,
    date_to=None,
    ascending: bool = False,
):
    statement = select(GlucoseRecord).where(GlucoseRecord.tracker_user_uuid == user.uuid)
    if date_from is not None:
        statement = statement.where(GlucoseRecord.day >= date_from)
    if date_to is not None:
        statement = statement.where(GlucoseRecord.day <= date_to)
    day_order = GlucoseRecord.day.asc() if ascending else GlucoseRecord.day.desc()
    result = await session.execute(statement.order_by(day_order, GlucoseRecord.time_slot))
    grouped = {}
    for item in result.scalars():
        grouped.setdefault(item.day.isoformat(), {
            "day": item.day,
            "values": {"09:00": None, "14:00": None, "19:00": None, "22:00": None},
        })["values"][item.time_slot] = item.value
    return list(grouped.values())


async def list_admin_users(session: AsyncSession):
    daily = (
        select(
            GlucoseRecord.tracker_user_uuid.label("tracker_user_uuid"),
            GlucoseRecord.day.label("day"),
            func.count(GlucoseRecord.value).label("non_null_values"),
            func.max(GlucoseRecord.updated_at).label("latest_update"),
        )
        .group_by(GlucoseRecord.tracker_user_uuid, GlucoseRecord.day)
        .subquery()
    )
    statement = (
        select(
            TrackerUser.username,
            func.min(daily.c.day),
            func.max(daily.c.day),
            func.count(daily.c.day),
            func.coalesce(func.sum(case((daily.c.non_null_values == 4, 1), else_=0)), 0),
            func.max(daily.c.latest_update),
        )
        .outerjoin(daily, daily.c.tracker_user_uuid == TrackerUser.uuid)
        .where(TrackerUser.username.is_not(None))
        .group_by(TrackerUser.uuid, TrackerUser.username)
        .order_by(TrackerUser.username)
    )
    result = await session.execute(statement)
    return [
        {
            "username": row[0],
            "first_recorded_day": row[1],
            "last_recorded_day": row[2],
            "total_recorded_days": row[3] or 0,
            "completed_days": row[4] or 0,
            "latest_record_update": row[5],
        }
        for row in result
    ]


async def get_admin_records(session: AsyncSession, username: str, date_from, date_to):
    normalized_username = username.strip().casefold()
    result = await session.execute(
        select(TrackerUser).where(TrackerUser.username == normalized_username)
    )
    user = result.scalar_one_or_none()
    if user is None:
        raise HTTPException(status_code=404, detail="Tracker user not found")
    return await records_for_user(session, user, date_from, date_to, ascending=True)


async def get_records_by_username(session: AsyncSession, username: str, token: str):
    normalized_username = username.strip().casefold()
    result = await session.execute(
        select(TrackerUser).where(TrackerUser.username == normalized_username)
    )
    user = result.scalar_one_or_none()
    if user is None:
        raise HTTPException(status_code=404, detail="Tracker user not found")
    if len(token) < 32 or not compare_digest(user.token_hash, token_digest(token)):
        raise HTTPException(status_code=403, detail="Invalid tracker credentials")
    return await records_for_user(session, user)


async def authenticate_or_create(
    session: AsyncSession, tracker_id: UUID, username: str, token: str
) -> TrackerUser:
    if len(token) < 32:
        raise HTTPException(status_code=401, detail="Invalid tracker token")

    digest = token_digest(token)
    result = await session.execute(select(TrackerUser).where(TrackerUser.username == username))
    user = result.scalar_one_or_none()

    if user is not None and not compare_digest(user.token_hash, digest):
        raise HTTPException(status_code=403, detail="This username belongs to another tracker")

    user_by_id = await session.get(TrackerUser, tracker_id)
    if user is None and user_by_id is not None:
        if not compare_digest(user_by_id.token_hash, digest):
            raise HTTPException(status_code=403, detail="Invalid tracker credentials")
        if user_by_id.username not in (None, username):
            raise HTTPException(status_code=409, detail="Tracker is already assigned to another username")
        user = user_by_id
        user.username = username

    if user is None:
        user = TrackerUser(uuid=tracker_id, username=username, token_hash=digest)
        session.add(user)
        await session.flush()
    return user


async def sync(session: AsyncSession, tracker_id: UUID, token: str, payload: SyncRequest):
    user = await authenticate_or_create(session, tracker_id, payload.username, token)
    imported_count = 0

    for record in payload.records:
        for time_slot, value in record.values.by_slot().items():
            statement = insert(GlucoseRecord).values(
                tracker_user_uuid=user.uuid, day=record.day, time_slot=time_slot, value=value
            ).on_conflict_do_update(
                constraint="uq_glucose_user_day_slot",
                set_={"value": value, "updated_at": datetime.now(timezone.utc)},
            )
            await session.execute(statement)
            imported_count += 1

    if payload.initial_import and user.initial_import_completed_at is None:
        user.initial_import_completed_at = datetime.now(timezone.utc)

    await session.commit()

    return {
        "records": await records_for_user(session, user),
        "initial_import_completed": user.initial_import_completed_at is not None,
        "imported_count": imported_count,
    }
