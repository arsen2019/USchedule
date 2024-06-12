import uuid
from core.models.models import *
from core.models import db_helper
from sqlalchemy.ext.asyncio import async_sessionmaker
import asyncio


async def commit_changes(session, changes):
    session.add_all(changes)
    await session.commit()


engine = db_helper.engine
AsyncSession = async_sessionmaker(bind=engine, expire_on_commit=False)


async def add_initial_data():
    async with AsyncSession() as session:

        buildings_data = [
            {"city": "Yerevan", "street": "Teryan 52", "name": "2 corpus"},
            {"city": "Yerevan", "street": "Teryan 52", "name": "5 corpus"},
            {"city": "Yerevan", "street": "Koryun 9", "name": "12 corpus"},
            {"city": "Yerevan", "street": "Koryun 11", "name": "9 corpus"},
        ]

        buildings = [
            Building(building["city"], building["street"], building["name"])
            for building in buildings_data
        ]

        await commit_changes(session, buildings)

        rooms_data = [
            {"name": "208", "building_name": "12 corpus"},
            {"name": "106", "building_name": "5 corpus"},
            {"name": "119", "building_name": "5 corpus"},
            {"name": "105", "building_name": "5 corpus"},
            {"name": "105", "building_name": "12 corpus"},
            {"name": "103", "building_name": "12 corpus"},
            {"name": "102", "building_name": "12 corpus"},
            {"name": "101", "building_name": "12 corpus"},
            {"name": "120", "building_name": "5 corpus"},
            {"name": "305", "building_name": "12 corpus"},
            {"name": "205", "building_name": "9 corpus"},
            {"name": "112", "building_name": "9 corpus"},
            {"name": "108", "building_name": "9 corpus"},
            {"name": "208", "building_name": "12 corpus"},
            {"name": "201", "building_name": "12 corpus"},
            {"name": "401", "building_name": "2 corpus"},
            {"name": "108", "building_name": "5 corpus"},
            {"name": "209", "building_name": "12 corpus"},
            {"name": "905", "building_name": "5 corpus"},
        ]

        rooms = []
        for room in rooms_data:
            building = next(b for b in buildings if b.name == room["building_name"])
            new_room = Room(name=room["name"], building_uuid=building.uuid)
            rooms.append(new_room)

        await commit_changes(session, rooms)

        # Departments data
        department_data = [
            {"name": "Informatics", "room_name": "108", "building_name": "5 corpus"},
            {"name": "Mathematics", "room_name": "209", "building_name": "12 corpus"},
            {
                "name": "Programming and Algorithms",
                "room_name": "905",
                "building_name": "5 corpus",
            },
            {"name": "Philosophy", "room_name": "401", "building_name": "2 corpus"},
            {"name": "Mechanics", "room_name": "112", "building_name": "9 corpus"},
        ]

        departments = []
        for department in department_data:
            building = next(
                b for b in buildings if b.name == department["building_name"]
            )
            room = next(r for r in rooms if r.name == department["room_name"])
            new_department = Department(
                name=department["name"],
                room_uuid=room.uuid,
                building_uuid=building.uuid,
            )
            departments.append(new_department)

        await commit_changes(session, departments)

        teacher_data = [
            {
                "first_name": "S",
                "last_name": "Episkoposyan",
                "department": "Mathematics",
            },
            {"first_name": "N", "last_name": "Sahakyan", "department": "Informatics"},
            {
                "first_name": "S",
                "last_name": "Hayrapetyan",
                "department": "Mathematics",
            },
            {"first_name": "N", "last_name": "Badalyan", "department": "Mathematics"},
            {"first_name": "V", "last_name": "Saroyan", "department": "Mechanics"},
            {"first_name": "P", "last_name": "Hakobyan", "department": "Mathematics"},
            {"first_name": "J", "last_name": "Srapionyan", "department": "Mathematics"},
            {
                "first_name": "G",
                "last_name": "Zaprosyan",
                "department": "Programming and Algorithms",
            },
            {
                "first_name": "S",
                "last_name": "Meliqyan",
                "department": "Programming and Algorithms",
            },
            {
                "first_name": "I",
                "last_name": "Saghatelyan",
                "department": "Programming and Algorithms",
            },
            {"first_name": "N", "last_name": "Baxdasaryan", "department": "Philosophy"},
        ]

        teachers = []
        for teacher in teacher_data:
            department = next(d for d in departments if d.name == teacher["department"])
            new_teacher = Teacher(
                first_name=teacher["first_name"],
                last_name=teacher["last_name"],
                department_uuid=department.uuid,
            )
            teachers.append(new_teacher)

        await commit_changes(session, teachers)

        major_data = [
            "Applied Mathematics and Informatics",
            "Cyber Security",
            "Artificial Inteligence",
            "Programming Architecture",
        ]

        majors = [Major(name=major) for major in major_data]
        await commit_changes(session, majors)

        group_data = [
            {"name": "240-1", "major": "Applied Mathematics and Informatics"},
            {"name": "240-2", "major": "Applied Mathematics and Informatics"},
            {"name": "240-3", "major": "Applied Mathematics and Informatics"},
        ]

        groups = []
        for group in group_data:
            major = next(m for m in majors if m.name == group["major"])
            groups.append(Group(name=group["name"], major_uuid=major.uuid))

        await commit_changes(session, groups)

        # Students data
        student_data = [
            {
                "first_name": "Arsen",
                "last_name": "Grigoryan",
                "email": "arsen.grigoryan555@gmail.com",
                "group": "240-2",
            },
            {
                "first_name": "Niko",
                "last_name": "Isaxanyan",
                "email": "niko.isaxanyan@gmail.com",
                "group": "240-3",
            },
        ]

        students = []
        for student in student_data:
            group = next(g for g in groups if g.name == student["group"])
            students.append(
                Student(
                    first_name=student["first_name"],
                    last_name=student["last_name"],
                    email=student["email"],
                    group_uuid=group.uuid,
                )
            )

        await commit_changes(session, students)

        course_data = [
            {
                "name": "Complex Analysis",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-2",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Programming",
                "room_name": "106",
                "building_name": "5 corpus",
                "teacher_last_name": "Sahakyan",
                "group_name": "240-1",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Programming",
                "room_name": "119",
                "building_name": "5 corpus",
                "teacher_last_name": "Meliqyan",
                "group_name": "240-2",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Programming",
                "room_name": "105",
                "building_name": "5 corpus",
                "teacher_last_name": "Saghatelyan",
                "group_name": "240-3",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "208",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-2",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Web Development",
                "room_name": "101",
                "building_name": "12 corpus",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240-2",
                "day_of_week": "Thusrday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-2",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Philosophy",
                "room_name": "102",
                "building_name": "12 corpus",
                "teacher_last_name": "Baxdasaryan",
                "group_name": "240-2",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Mechanics",
                "room_name": "205",
                "building_name": "9 corpus",
                "teacher_last_name": "Saroyan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mechanics",
                "room_name": "205",
                "building_name": "9 corpus",
                "teacher_last_name": "Saroyan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "105",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-3",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Probability Theory",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Programming",
                "room_name": "208",
                "building_name": "12 corpus",
                "teacher_last_name": "Sahakyan",
                "group_name": "240-1",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "105",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-2",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Programming",
                "room_name": "120",
                "building_name": "5 corpus",
                "teacher_last_name": "Saghatelyan",
                "group_name": "240-3",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Web Development",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240-1",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-2",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-3",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Web Development",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240-2",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Programming",
                "room_name": "120",
                "building_name": "5 corpus",
                "teacher_last_name": "Saghatelyan",
                "group_name": "240-1",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Mechanics",
                "room_name": "112",
                "building_name": "9 corpus",
                "teacher_last_name": "Saroyan",
                "group_name": "240-1",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Mechanics",
                "room_name": "112",
                "building_name": "9 corpus",
                "teacher_last_name": "Saroyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Mechanics",
                "room_name": "112",
                "building_name": "9 corpus",
                "teacher_last_name": "Saroyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Probability Theory",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-1",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Probability Theory",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-1",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Complex Analysis",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-3",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-2",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Mathematical Logic",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Badalyan",
                "group_name": "240-1",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Philosophy",
                "room_name": "305",
                "building_name": "12 corpus",
                "teacher_last_name": "Baxdasaryan",
                "group_name": "240-2",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Mathematical Equtions",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-1",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Probability Theory",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-1",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Probability Theory",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Complex Analysis",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-1",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "102",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-1",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "102",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Probability Theory",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "9:30",
                "end_time": "11:00",
            },
            {
                "name": "Philosophy",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Baxdasaryan",
                "group_name": "240-3",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Philosophy",
                "room_name": "102",
                "building_name": "12 corpus",
                "teacher_last_name": "Baxdasaryan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Web Development",
                "room_name": "101",
                "building_name": "12 corpus",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240-3",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Web Development",
                "room_name": "101",
                "building_name": "12 corpus",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240-3",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-2",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name": "Complex Analysis",
                "room_name": "103",
                "building_name": "12 corpus",
                "teacher_last_name": "Episkoposyan",
                "group_name": "240-3",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name": "Mathematical Equations",
                "room_name": "201",
                "building_name": "12 corpus",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
        ]

        courses = []
        for course in course_data:
            room = next(r for r in rooms if r.name == course["room_name"])
            building = next(b for b in buildings if b.name == course["building_name"])
            teacher = next(
                t for t in teachers if t.last_name == course["teacher_last_name"]
            )
            group = next(g for g in groups if g.name == course["group_name"])
            courses.append(
                Course(
                    name=course["name"],
                    room_uuid=room.uuid,
                    building_uuid=building.uuid,
                    teacher_uuid=teacher.uuid,
                    group_uuid=group.uuid,
                    day_of_week=course["day_of_week"],
                    is_odd=course["is_odd"],
                    is_lecture=course["is_lecture"],
                    start_time=course["start_time"],
                    end_time=course["end_time"],
                )
            )

        await commit_changes(session, courses)


asyncio.run(add_initial_data())
