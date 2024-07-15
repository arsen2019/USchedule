# Use the official Python image from the Docker Hub
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install dependencies
COPY pyproject.toml poetry.lock ./
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
RUN pip install asyncpg

# Copy the application code
COPY . .

# Install PostgreSQL client for loading the dump
RUN apt-get update && apt-get install -y postgresql-client

# Copy the database dump
COPY backup.sql /docker-entrypoint-initdb.d/

# Command to run the database dump
RUN apt-get update && apt-get install -y postgresql-client
CMD ["sh", "-c", "PGPASSWORD=Postgresql123! psql -U postgres -h db -d postgres /docker-entrypoint-initdb.d/backup.sql && uvicorn main:app --host 0.0.0.0 --port 8000"]
