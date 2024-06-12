import uuid
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud

from .schemas import Group
from core.models import db_helper

router = APIRouter(tags=["Group"])


@router.get("/", response_model=list[Group])
async def get_courses(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_group(session=session)
