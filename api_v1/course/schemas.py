import uuid
from pydantic import BaseModel, ConfigDict
from typing import Optional


class Teacher(BaseModel):
    first_name: str
    last_name: str

    class Config:
        orm_mode = True


class Room(BaseModel):
    name: str

    class Config:
        orm_mode = True


class Building(BaseModel):
    name: str


class CourseBase(BaseModel):
    name: str
    day_of_week: str
    start_time: str
    end_time: str


class Course(CourseBase):
    teacher: Optional[Teacher]
    room: Optional[Room]
    building: Optional[Building]
    model_config = ConfigDict(from_attributes=True)
