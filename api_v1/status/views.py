from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from . import crud
from .schemas import Status
from core.models import db_helper

router = APIRouter(tags=["Status"])

@router.get("/", response_model=Status)
async def status(
    session: AsyncSession = Depends(db_helper.scoped_session_dependency),
):
    return await crud.status(session=session)