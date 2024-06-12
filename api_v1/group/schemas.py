import uuid
from pydantic import BaseModel, ConfigDict


class GroupBase(BaseModel):
    name: str


class Group(GroupBase):
    uuid: uuid.UUID
    model_config = ConfigDict(from_attributes=True)
