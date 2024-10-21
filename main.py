from contextlib import asynccontextmanager
from fastapi import FastAPI
from core.models import Base, db_helper
from api_v1 import router_for_course as router_v1
from api_v1 import router_for_group as router_v2
from api_v1 import router_for_status as router_v3
from core.config import settings
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

origins = [
    "https://schedule.arsgreg.com",
    "https://schedule.arsgreg.com:1",
    "http://localhost",
    "http://localhost:8080",
    "http://localhost:3000",
]

@asynccontextmanager
async def lifespan(app: FastAPI):
    async with db_helper.engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield

app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router=router_v1, prefix=settings.api_v1_prefix)
app.include_router(router=router_v2, prefix=settings.api_v1_prefix)
app.include_router(router=router_v3, prefix=settings.api_v1_prefix)


if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
