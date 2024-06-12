from fastapi import HTTPException
from sqlalchemy import select
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Course, Group


async def get_courses(session: AsyncSession) -> list[Course]:
    stmt = select(Course).order_by(Course.uuid)
    result: Result = await session.execute(stmt)
    courses = result.scalars().all()
    if courses is None:
        return []
    return list(courses)


async def get_courses_by_group_number(group_name: str, session: AsyncSession):
    stmt = select(Group).where(Group.name == group_name)
    group_result: Result = await session.execute(stmt)
    group = group_result.scalars().first()

    if not group:
        raise HTTPException(status_code=404, detail="Group not found")

    stmt = select(Course).where(Course.group_uuid == group.uuid)
    result: Result = await session.execute(stmt)
    courses = result.scalars().all()

    if not courses:
        raise HTTPException(
            status_code=404, detail="No courses found for the specified group"
        )

    return courses
