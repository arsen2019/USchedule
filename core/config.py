from sqlalchemy.engine import URL
from pydantic_settings import BaseSettings
from dotenv import load_dotenv
import os

load_dotenv()

class Settings(BaseSettings):
    api_v1_prefix: str = ""
    db_url: str = "postgresql+asyncpg://postgres:Postgresql123!@db:5432/postgres"
    db_echo: bool = True


settings = Settings()
