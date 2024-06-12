from fastapi import HTTPException
from sqlalchemy import select
from sqlalchemy.engine import Result
from sqlalchemy.ext.asyncio import AsyncSession
from core.models import Group


async def get_group(session: AsyncSession):
    stmt = select(Group)
    group_result: Result = await session.execute(stmt)
    group = group_result.scalars()

    if not group:
        raise HTTPException(status_code=404, detail="group not found")

    return group
