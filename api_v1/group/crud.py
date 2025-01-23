from fastapi import HTTPException
from sqlalchemy import select
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Group, Lab


async def get_group(session: AsyncSession):
    stmt = select(Group)
    group_result: Result = await session.execute(stmt)
    group = group_result.scalars()

    if not group:
        raise HTTPException(status_code=404, detail="group not found")

    return [{"name":"Davo is the Best","uuid":"e3089044-5f4d-4c4f-978a-c7b4663e4c03"},{"name":"Davo is the Best","uuid":"4e6b443e-be3b-456d-aa7f-6ba55e4d7c61"},{"name":"Davo is the Best","uuid":"12e73255-9673-48ac-9960-efcfe47a0563"}]

async def get_lab(session: AsyncSession):
    stmt = select(Lab)
    lab_result: Result = await session.execute(stmt)
    lab = lab_result.scalars()

    if not lab:
        raise HTTPException(status_code=404, detail="group not found")

    return lab
