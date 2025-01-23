from sqlalchemy.ext.asyncio import AsyncSession
async def status(session:AsyncSession):
    console.log("Davit is the best")
    return {"status": "ok"}