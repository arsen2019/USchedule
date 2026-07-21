from datetime import date
from hmac import compare_digest
from uuid import UUID

from fastapi import APIRouter, Depends, Header, HTTPException, Query, Response, status
from sqlalchemy.ext.asyncio import AsyncSession

from core.config import settings
from core.models import db_helper
from . import crud
from .schemas import AdminTrackerUser, DayRecord, DayValues, SyncRequest, SyncResponse

router = APIRouter(tags=["Glucose tracker"])


def verify_admin_token(x_admin_token: str = Header(default="")):
    configured_token = settings.tracker_admin_token
    if not configured_token:
        raise HTTPException(status_code=503, detail="Tracker admin access is not configured")
    if not compare_digest(x_admin_token, configured_token):
        raise HTTPException(status_code=401, detail="Invalid admin token")


@router.get("/admin/users", response_model=list[AdminTrackerUser], dependencies=[Depends(verify_admin_token)])
async def get_admin_users(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.list_admin_users(session)


@router.get(
    "/admin/users/{username}/records",
    response_model=list[DayRecord],
    dependencies=[Depends(verify_admin_token)],
)
async def get_admin_user_records(
    username: str,
    date_from: date = Query(...),
    date_to: date = Query(...),
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    if date_from > date_to:
        raise HTTPException(status_code=422, detail="date_from must not be after date_to")
    return await crud.get_admin_records(session, username, date_from, date_to)


@router.patch(
    "/admin/users/{username}/records/{day}",
    response_model=DayRecord,
    dependencies=[Depends(verify_admin_token)],
)
async def patch_admin_user_record(
    username: str,
    day: date,
    values: DayValues,
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.admin_upsert_day(session, username, day, values)


@router.delete(
    "/admin/users/{username}/records/{day}",
    status_code=status.HTTP_204_NO_CONTENT,
    dependencies=[Depends(verify_admin_token)],
)
async def delete_admin_user_record(
    username: str,
    day: date,
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    await crud.admin_delete_day(session, username, day)
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.get("/by-username/{username}/records", response_model=list[DayRecord])
async def get_tracker_records(
    username: str,
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    user = await crud.get_or_create_by_username(session, username)
    await session.commit()
    return await crud.records_for_user(session, user)


@router.put("/by-username/{username}/sync", response_model=SyncResponse)
async def sync_tracker_by_username(
    username: str,
    payload: SyncRequest,
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.sync_by_username(session, username, payload)


@router.put("/{tracker_id}/sync", response_model=SyncResponse)
async def sync_tracker(
    tracker_id: UUID,
    payload: SyncRequest,
    x_tracker_token: str = Header(...),
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.sync(session, tracker_id, x_tracker_token, payload)
