from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from Models.models import Base
url = URL.create(
    drivername="postgresql",
    username="postgres",
    password="Postgresql123!",
    host="localhost",
    database="postgres"
)

engine = create_engine(url, echo=True)
connection = engine.connect()
Base.metadata.create_all(bind=engine)