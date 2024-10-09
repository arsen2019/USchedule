from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud
import uuid
from datetime import datetime
from .schemas import Course
from core.models import db_helper
from typing import Optional
router = APIRouter(tags=["Courses"])


@router.get("/{group_uuid}", response_model=list[Course])
async def get_courses(
    group_uuid: uuid.UUID,
    lab_uuid: Optional[uuid.UUID] = None,
    request: Request = Request,
    current_week: datetime = datetime.now(),
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),

):
    return await crud.get_courses(
        group_uuid=group_uuid,
        lab_uuid=lab_uuid,
        session=session,
        current_week=current_week,
        request=request,
    )
