from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud
import uuid
from datetime import datetime
from .schemas import Course
from core.models import db_helper

router = APIRouter(tags=["Courses"])


@router.get("/{group_uuid}", response_model=list[Course])
async def get_courses(
    group_uuid: uuid.UUID,
    current_week: datetime = datetime.now(),
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_courses(
        group_uuid=group_uuid,
        session=session,
        current_week=current_week,
    )
