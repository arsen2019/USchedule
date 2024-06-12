from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud

from .schemas import Course
from core.models import db_helper

router = APIRouter(tags=["Courses"])


@router.get("/", response_model=list[Course])
async def get_courses(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_courses(session=session)


@router.get("/GroupCourses", response_model=list[Course])
async def get_courses(
    group_name: str,
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_courses_by_group_number(group_name, session=session)
