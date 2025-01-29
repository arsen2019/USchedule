from fastapi import HTTPException
from sqlalchemy import select
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Group, Lab


async def get_group(session: AsyncSession):
    stmt = select(Group)
    group_result: Result = await session.execute(stmt)
    group = group_result.scalars()
    print("Davo is the best!!!")
    if not group:
        raise HTTPException(status_code=404, detail="group not found")
    return group

async def get_lab(session: AsyncSession):
    stmt = select(Lab)
    lab_result: Result = await session.execute(stmt)
    lab = lab_result.scalars()

    if not lab:
        raise HTTPException(status_code=404, detail="group not found")

    return lab
