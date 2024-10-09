import uuid
from pydantic import BaseModel, ConfigDict
class LabBase(BaseModel):
    name:str

class Lab(LabBase):
        uuid: uuid.UUID
        model_config = ConfigDict(from_attributes=True)

class GroupBase(BaseModel):
    name: str


class Group(GroupBase):
    uuid: uuid.UUID
    model_config = ConfigDict(from_attributes=True)
