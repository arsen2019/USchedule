from sqlalchemy.engine import URL
from pydantic_settings import BaseSettings
from dotenv import load_dotenv
import os

load_dotenv()

class Settings(BaseSettings):
    api_v1_prefix: str = ""
    db_url: str = os.getenv("DB_URL")
    db_echo: bool = True


settings = Settings()
