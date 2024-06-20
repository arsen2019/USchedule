from uuid import uuid4
from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Time,
    Boolean,
    Double,
    UUID,
    func,
)
from sqlalchemy.orm import relationship, sessionmaker, declarative_base
from core.models.base import Base


class Student(Base):

    # __tablename__ = "student"
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    email = Column(String, nullable=False)
    group_uuid = Column(UUID(as_uuid=True), ForeignKey("group.uuid"))

    def __init__(self, first_name, last_name, email, group_uuid):
        self.uuid = uuid4()
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.group_uuid = group_uuid


class Group(Base):
    # __tablename__ = "group"
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    name = Column(String, nullable=False)
    major_uuid = Column(UUID(as_uuid=True), ForeignKey("major.uuid"))

    # major = relationship("major", backref="group")
    # student = relationship("student", backref="group")

    def __init__(self, name, major_uuid):
        self.uuid = uuid4()
        self.name = name
        self.major_uuid = major_uuid


class Course(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    name = Column(String, nullable=False)
    room_uuid = Column(UUID(as_uuid=True), ForeignKey("room.uuid"))
    building_uuid = Column(UUID(as_uuid=True), ForeignKey("building.uuid"))
    teacher_uuid = Column(UUID(as_uuid=True), ForeignKey("teacher.uuid"))
    group_uuid = Column(UUID(as_uuid=True), ForeignKey("group.uuid"))
    day_of_week = Column(String, nullable=False)
    is_odd = Column(Boolean, nullable=False)
    is_lecture = Column(Boolean, nullable=False)
    start_time = Column(String, nullable=False)
    end_time = Column(String, nullable=False)
    #
    teacher = relationship("Teacher")
    room = relationship("Room")
    building = relationship("Building")

    def __init__(
        self,
        name,
        room_uuid,
        building_uuid,
        teacher_uuid,
        group_uuid,
        day_of_week,
        is_odd,
        is_lecture,
        start_time,
        end_time,
    ):
        self.uuid = uuid4()
        self.name = name
        self.room_uuid = room_uuid
        self.building_uuid = building_uuid
        self.teacher_uuid = teacher_uuid
        self.group_uuid = group_uuid
        self.day_of_week = day_of_week
        self.is_odd = is_odd
        self.is_lecture = is_lecture
        self.start_time = start_time
        self.end_time = end_time


class Major(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    name = Column(String, nullable=False)

    def __init__(self, name):
        self.uuid = uuid4()
        self.name = name


class Room(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    building_uuid = Column(UUID(as_uuid=True), ForeignKey("building.uuid"))
    name = Column(String, nullable=False)

    def __init__(self, name, building_uuid):
        self.uuid = uuid4()
        self.building_uuid = building_uuid
        self.name = name


class Teacher(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    department_uuid = Column(UUID(as_uuid=True), ForeignKey("department.uuid"))

    def __init__(self, first_name, last_name, department_uuid):
        self.uuid = uuid4()
        self.first_name = first_name
        self.last_name = last_name
        self.department_uuid = department_uuid


class Building(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    country = Column(String, nullable=False)
    city = Column(String, nullable=False)
    street = Column(String, nullable=False)
    longitude = Column(Double)
    latitude = Column(Double)
    name = Column(String, nullable=False)

    def __init__(self, city, street, name):
        self.uuid = uuid4()
        self.country = "Armenia"
        self.city = city
        self.street = street
        self.name = name


class Department(Base):
    uuid = Column(UUID(as_uuid=True), primary_key=True, default=uuid4())
    room_uuid = Column(UUID(as_uuid=True), ForeignKey("room.uuid"))
    building_uuid = Column(UUID(as_uuid=True), ForeignKey("building.uuid"))
    name = Column(String, nullable=False)

    def __init__(self, name, room_uuid, building_uuid):
        self.uuid = uuid4()
        self.name = name
        self.room_uuid = room_uuid
        self.building_uuid = building_uuid
