from sqlalchemy.ext.asyncio import AsyncSession
async def status(session:AsyncSession):
    return {"status": "Everything is fine, I forgot that CI/CD triggers with tags"}