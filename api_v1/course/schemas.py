import uuid
from pydantic import BaseModel, ConfigDict


class CourseBase(BaseModel):
    name: str
    is_odd: bool
    start_time: str
    end_time: str


class Course(CourseBase):
    model_config = ConfigDict(from_attributes=True)


class GroupBase(BaseModel):
    name: str


class Group(GroupBase):
    model_config = ConfigDict(from_attributes=True)
