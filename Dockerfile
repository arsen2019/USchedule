FROM python:3.10-slim

WORKDIR /app


COPY pyproject.toml poetry.lock ./
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
RUN pip install asyncpg

COPY . .

RUN apt-get update && apt-get install -y postgresql-client

COPY backup.sql /docker-entrypoint-initdb.d/


RUN apt-get update && apt-get install -y postgresql-client
CMD ["sh", "-c", "PGPASSWORD=Postgresql123! psql -U postgres -h db -d postgres  /docker-entrypoint-initdb.d/backup.sql && uvicorn main:app --host 0.0.0.0 --port 8000"]
