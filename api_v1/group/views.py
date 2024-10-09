import uuid
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud

from .schemas import Group, Lab
from core.models import db_helper

router = APIRouter(tags=["Group-Labs"])


@router.get("/", response_model=list[Group])
async def get_groups(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_group(session=session)

@router.get("/labs", response_model=list[Lab])
async def get_labs(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.get_lab(session=session)
