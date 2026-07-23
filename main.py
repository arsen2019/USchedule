import asyncio
import logging
from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException, Request, status
from core.models import Base, db_helper
from api_v1 import router_for_course as router_v1
from api_v1 import router_for_group as router_v2
from api_v1 import router_for_status as router_v3
from api_v1 import router_for_tracker as router_v4
from core.config import settings
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import sentry_sdk
from sentry_sdk.integrations.asgi import SentryAsgiMiddleware
from starlette.exceptions import HTTPException as StarletteHTTPException
from fastapi.responses import JSONResponse
from sqlalchemy import text

sentry_sdk.init(
    dsn="https://29a0a60f5d2603e9da0f377a61234d81@o4508167457603584.ingest.de.sentry.io/4508167628652624",
    traces_sample_rate=0.1,
)

logger = logging.getLogger("uschedule")

origins = [
    "https://schedule.arsgreg.com",
    "https://schedule.arsgreg.com:1",
    "http://localhost",
    "http://localhost:8080",
    "http://localhost:3000",
    "https://www.uptimerobot.com/",
]

@asynccontextmanager
async def lifespan(app: FastAPI):
    for attempt in range(1, 16):
        try:
            async with db_helper.engine.begin() as conn:
                await conn.run_sync(Base.metadata.create_all)
                # create_all does not alter tables created by an earlier local version.
                await conn.execute(text("ALTER TABLE tracker_user ADD COLUMN IF NOT EXISTS username VARCHAR(64)"))
                await conn.execute(text("CREATE UNIQUE INDEX IF NOT EXISTS uq_tracker_user_username ON tracker_user (username) WHERE username IS NOT NULL"))
                await conn.execute(text("ALTER TABLE tracker_user ALTER COLUMN token_hash DROP NOT NULL"))
                await conn.execute(text("ALTER TABLE glucose_record ALTER COLUMN value DROP NOT NULL"))
            break
        except Exception:
            if attempt == 15:
                logger.exception("Database remained unavailable during application startup")
                raise
            logger.warning("Database is not ready (attempt %s/15); retrying in 4 seconds", attempt)
            await asyncio.sleep(4)
    try:
        yield
    finally:
        await db_helper.engine.dispose()

app = FastAPI(lifespan=lifespan)

app.add_middleware(SentryAsgiMiddleware)


@app.get("/health", include_in_schema=False)
async def health():
    return {"status": "ok"}


@app.get("/ready", include_in_schema=False)
async def ready():
    try:
        async with db_helper.engine.connect() as connection:
            await connection.execute(text("SELECT 1"))
    except Exception as error:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Database is unavailable",
        ) from error
    return {"status": "ready"}

@app.exception_handler(StarletteHTTPException)
async def custom_http_exception_handler(request: Request, exc: StarletteHTTPException):
    # Capture only 404 and 405 errors, you can add more status codes here
    if exc.status_code in [404, 405]:
        # Manually report the error to Sentry
        sentry_sdk.capture_exception(exc)

    # Return the original response as usual
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail}
    )


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
app.include_router(router=router_v4, prefix=settings.api_v1_prefix)


if __name__ == "__main__":
    uvicorn.run("main:app", reload=True)
