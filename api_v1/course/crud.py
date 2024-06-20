from fastapi import HTTPException
from sqlalchemy import select, or_
from sqlalchemy.orm import selectinload
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Course, Teacher, Room
from datetime import datetime


async def get_courses(
    group_uuid, session: AsyncSession, current_week: datetime = datetime.now()
) -> list[Course]:
    stmt = (
        select(Course)
        .options(
            selectinload(Course.teacher),
            selectinload(Course.room),
            selectinload(Course.building),
        )
        .filter((Course.group_uuid == group_uuid) | Course.is_lecture)
    )

    result = await session.execute(stmt)
    courses = result.scalars().all()
    courses
    if not courses:
        raise HTTPException(
            status_code=404, detail="No courses found for the specified group"
        )
    day_order = {
        "Monday": 1,
        "Tuesday": 2,
        "Wednesday": 3,
        "Thursday": 4,
        "Friday": 5,
    }

    current_week_number = current_week.isocalendar()[1]
    is_current_week_odd = current_week_number % 2 == 0

    filtered_courses = [
        course for course in courses if course.is_odd == is_current_week_odd
    ]

    sorted_courses = sorted(
        filtered_courses,
        key=lambda course: (
            day_order[course.day_of_week],
            datetime.strptime(course.start_time, "%H:%M"),
        ),
    )
    return sorted_courses
