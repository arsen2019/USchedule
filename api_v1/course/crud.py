from fastapi import HTTPException, Request
from sqlalchemy import select, or_
from sqlalchemy.orm import selectinload
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Course, Teacher, Room, Building
from .schemas import Course as CourseSchema
from datetime import datetime



async def get_courses(
        group_uuid, request: Request, session: AsyncSession, current_week: datetime = datetime.now()
) -> list[Course]:
    language = request.headers.get('Accept-Language', 'en')
    print(language)
    if language not in ['en', 'hy', 'ru']:
        language = 'en'

    first_name_col = f"first_name_{language}"
    last_name_col = f"last_name_{language}"
    course_name_col = f"name_{language}"

    current_week_number = current_week.isocalendar()[1]
    is_current_week_odd = current_week_number % 2 == 0

    stmt = (
        select(
            Course,
        ).with_only_columns(
            getattr(Course, course_name_col).label('name'),
            Course.day_of_week,
            Course.start_time,
            Course.end_time,
            getattr(Teacher, first_name_col).label('first_name'),
            getattr(Teacher, last_name_col).label('last_name'),
            Room.name.label('room_name'),
            Building.name.label('building_name')
        )
        .join(Course.teacher)
        .join(Course.room)
        .join(Course.building)
        .filter((Course.group_uuid == group_uuid) | Course.is_lecture)
        .filter(Course.is_odd == is_current_week_odd)
    )
    print(CourseSchema)
    result = await session.execute(stmt)
    print(result)
    courses = [
        {
            "name": row[0],
            "day_of_week": row[1],
            "start_time": row[2],
            "end_time": row[3],
            "teacher": {
                "first_name": row[4],
                "last_name": row[5],
            },
            "room": {
                "name": row[6]
            },
            "building": {
                "name": row[7]
            }
        }
        for row in result
    ]

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



    sorted_courses = sorted(
        courses,
        key=lambda course: (
            day_order[course.get("day_of_week")],
            datetime.strptime(course.get("start_time"), "%H:%M"),
        ),
    )
    return sorted_courses
