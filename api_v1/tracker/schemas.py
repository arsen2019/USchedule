from datetime import date, datetime
from typing import Literal
from pydantic import BaseModel, Field, field_validator

TimeSlot = Literal["09:00", "14:00", "19:00", "22:00"]


class DayValues(BaseModel):
    morning: float | None = Field(None, alias="09:00", gt=0)
    afternoon: float | None = Field(None, alias="14:00", gt=0)
    evening: float | None = Field(None, alias="19:00", gt=0)
    night: float | None = Field(None, alias="22:00", gt=0)

    model_config = {"populate_by_name": True}

    def by_slot(self):
        return self.model_dump(by_alias=True)


class DayRecord(BaseModel):
    day: date
    values: DayValues


class SyncRequest(BaseModel):
    username: str = Field(min_length=2, max_length=64)
    records: list[DayRecord] = Field(default_factory=list, max_length=10000)
    initial_import: bool = False

    @field_validator("username")
    @classmethod
    def normalize_username(cls, username):
        normalized = username.strip().casefold()
        if not normalized or any(character.isspace() for character in normalized):
            raise ValueError("username cannot be empty or contain spaces")
        return normalized

    @field_validator("records")
    @classmethod
    def unique_days(cls, records):
        days = [record.day for record in records]
        if len(days) != len(set(days)):
            raise ValueError("records must contain at most one row per day")
        return records


class SyncResponse(BaseModel):
    records: list[DayRecord]
    initial_import_completed: bool
    imported_count: int


class AdminTrackerUser(BaseModel):
    username: str
    first_recorded_day: date | None = None
    last_recorded_day: date | None = None
    total_recorded_days: int = 0
    completed_days: int = 0
    latest_record_update: datetime | None = None
