from sqlalchemy.engine import URL
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    api_v1_prefix: str = ""
    db_url: str = (
        f"postgresql+asyncpg://postgres:Postgresql123!@localhost:5432/postgres"
    )
    db_echo: bool = True


settings = Settings()
