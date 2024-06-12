import uuid
from pydantic import BaseModel, ConfigDict


class CourseBase(BaseModel):
    name: str
    day_of_week: str
    start_time: str
    end_time: str


class Course(CourseBase):
    model_config = ConfigDict(from_attributes=True)
