from sqlalchemy.ext.asyncio import AsyncSession
async def status(session:AsyncSession):
    return {"status": "ok"}