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
            {"city": "Yerevan", "street": "Teryan 52", "name": "2"},
            {"city": "Yerevan", "street": "Teryan 52", "name": "5"},
            {"city": "Yerevan", "street": "Koryun 9", "name": "12"},
            {"city": "Yerevan", "street": "Koryun 11", "name": "9"},
        ]

        buildings = [
            Building(building["city"], building["street"], building["name"])
            for building in buildings_data
        ]

        await commit_changes(session, buildings)

        rooms_data = [
            {"name": "208", "building_name": "12"},
            {"name": "106", "building_name": "5"},
            {"name": "119", "building_name": "5"},
            {"name": "105", "building_name": "5"},
            {"name": "105", "building_name": "12"},
            {"name": "103", "building_name": "12"},
            {"name": "102", "building_name": "12"},
            {"name": "101", "building_name": "12"},
            {"name": "120", "building_name": "5"},
            {"name": "305", "building_name": "12"},
            {"name": "205", "building_name": "9"},
            {"name": "112", "building_name": "9"},
            {"name": "108", "building_name": "9"},
            {"name": "201", "building_name": "12"},
            {"name": "401", "building_name": "2"},
            {"name": "108", "building_name": "5"},
            {"name": "209", "building_name": "12"},
            {"name": "206", "building_name": "12"},
            {"name": "905", "building_name": "5"},
        ]

        rooms = []
        for room in rooms_data:
            building = next(b for b in buildings if b.name == room["building_name"])
            new_room = Room(name=room["name"], building_uuid=building.uuid)
            rooms.append(new_room)

        await commit_changes(session, rooms)

        # Departments data
        department_data = [
            {"name": "Informatics", "room_name": "108", "building_name": "5"},
            {"name": "Mathematics", "room_name": "209", "building_name": "12"},
            {
                "name": "Programming and Algorithms",
                "room_name": "905",
                "building_name": "5",
            },
            {"name": "Philosophy", "room_name": "401", "building_name": "2"},
            {"name": "Mechanics", "room_name": "112", "building_name": "9"},
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
                "first_name_en": "S",
                "last_name_en": "Episkoposyan",
                "first_name_hy": "Ս",
                "last_name_hy": "Եպիսկոպոսյան",
                "first_name_ru": "С",
                "last_name_ru": "Епископосян",
                "department": "Mathematics",
            },
            {
                "first_name_en": "N",
                "last_name_en": "Sahakyan",
                "first_name_hy": "Ն",
                "last_name_hy": "Սահակյան",
                "first_name_ru": "Н",
                "last_name_ru": "Саакян",
                "department": "Informatics"
            },
            {
                "first_name_en": "S",
                "last_name_en": "Hayrapetyan",
                "first_name_hy": "Ս",
                "last_name_hy": "Հայրապետյան",
                "first_name_ru": "С",
                "last_name_ru": "Гайрапетян",
                "department": "Mathematics",
            },
            {
                "first_name_en": "N",
                "last_name_en": "Badalyan",
                "first_name_hy": "Ն",
                "last_name_hy": "Բադալան",
                "first_name_ru": "Н",
                "last_name_ru": "Бадалян",
                "department": "Mathematics"
            },
            {
                "first_name_en": "V",
                "last_name_en": "Saroyan",
                "first_name_hy": "Վ",
                "last_name_hy": "Սարոյան",
                "first_name_ru": "В",
                "last_name_ru": "Сароян",
                "department": "Mechanics"
            },
            {
                "first_name_en": "P",
                "last_name_en": "Hakobyan",
                "first_name_hy": "Պ",
                "last_name_hy": "Հակոբյան",
                "first_name_ru": "П",
                "last_name_ru": "Хакопян",
                "department": "Mathematics"
            },
            {
                "first_name_en": "J",
                "last_name_en": "Srapionyan",
                "first_name_hy": "Ջ",
                "last_name_hy": "Սրապիոնյան",
                "first_name_ru": "Д",
                "last_name_ru": "Срапионян",
                "department": "Mathematics"
            },
            {
                "first_name_en": "G",
                "last_name_en": "Zaprosyan",
                "first_name_hy": "Գ",
                "last_name_hy": "Զապրոսյան",
                "first_name_ru": "Г",
                "last_name_ru": "Запросян",
                "department": "Programming and Algorithms",
            },
            {
                "first_name_en": "S",
                "last_name_en": "Meliqyan",
                "first_name_hy": "Ս",
                "last_name_hy": "Մելիքյան",
                "first_name_ru": "С",
                "last_name_ru": "Меликян",
                "department": "Programming and Algorithms",

            },
            {
                "first_name_en": "I",
                "last_name_en": "Saghatelyan",
                "first_name_hy": "Ի",
                "last_name_hy": "Սաղաթելայան",
                "first_name_ru": "И",
                "last_name_ru": "Сахателян",
                "department": "Programming and Algorithms",
            },
            {
                "first_name_en": "N",
                "last_name_en": "Baxdasaryan",
                "first_name_hy": "Ն",
                "last_name_hy": "Բաղդասարյան",
                "first_name_ru": "Н",
                "last_name_ru": "Бахдасарян",
                "department": "Philosophy"
            },
            {
                "last_name_en": "Khachatryan",
                "first_name_en": "S",
                "last_name_hy": "Խաչատրյան",
                "first_name_hy": "Ս",
                "last_name_ru": "Хачатрян",
                "first_name_ru": "С",
                "department": "Mathematics",
            },
            {
                "last_name_en": "Haykazyan",
                "first_name_en": "M",
                "last_name_hy": "Հայկազյան",
                "first_name_hy": "Մ",
                "last_name_ru": "Хайказян",
                "first_name_ru": "М",
                "department": "Mathematics",
            },
            {
                "last_name_en": "Hovhannisyan",
                "first_name_en": "I",
                "last_name_hy": "Հովհաննիսյան",
                "first_name_hy": "Ի",
                "last_name_ru": "Оганисян",
                "first_name_ru": "И",
                "department": "Mathematics",
            },
        ]

        teachers = []
        for teacher in teacher_data:
            department = next(d for d in departments if d.name == teacher["department"])
            new_teacher = Teacher(
                first_name_en=teacher["first_name_en"],
                last_name_en=teacher["last_name_en"],
                first_name_hy=teacher["first_name_hy"],
                last_name_hy=teacher["last_name_hy"],
                first_name_ru=teacher["first_name_ru"],
                last_name_ru=teacher["last_name_ru"],
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

        lab_data = [
            {"name": "Lab-1", "major": "Applied Mathematics and Informatics"},
            {"name": "Lab-2", "major": "Applied Mathematics and Informatics"},
            {"name": "Lab-3", "major": "Applied Mathematics and Informatics"},
            {"name": "Lab-4", "major": "Applied Mathematics and Informatics"},
        ]

        labs = []
        for lab in lab_data:
            major = next(m for m in majors if m.name == lab["major"])
            labs.append(Lab(name=lab["name"], major_uuid=major.uuid))

        await commit_changes(session, labs)

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
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-1",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-3",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Math-Physics Equations",
                "name_hy": "Մաթ-Ֆիզիկական Հավասարումներ",
                "name_ru": "Математико-физические уравнения",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-2",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "208",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Coding Theory - Course Work",
                "name_hy": "Կոդավորման Տեսություն - Կուրսային",
                "name_ru": "Теория кодирования - Курсовая",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240",
                "day_of_week": "Monday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Coding Theory - Course Work",
                "name_hy": "Կոդավորման Տեսություն - Կուրսային",
                "name_ru": "Теория кодирования - Курсовая",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-1",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-3",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "208",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240",
                "day_of_week": "Monday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Programming Theory",
                "name_hy": "Ծրագրավորման Տեսություն",
                "name_ru": "Теория Программирования",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240",
                "day_of_week": "Tuesday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Programming Theory",
                "name_hy": "Ծրագրավորման Տեսություն",
                "name_ru": "Теория Программирования",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Zaprosyan",
                "group_name": "240",
                "day_of_week": "Tuesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Math Programming",
                "name_hy": "Մաթ․ Ծրագրավորում",
                "name_ru": "Математическое программирование",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Hovhannisyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Math Programming",
                "name_hy": "Մաթ․ Ծրագրավորում",
                "name_ru": "Математическое программирование",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Hovhannisyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Discrete Mathematics",
                "name_hy": "Դիսկրետ Մաթեմատիկա",
                "name_ru": "Дискретная математика",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Badalyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name_en": "Discrete Mathematics",
                "name_hy": "Դիսկրետ Մաթեմատիկա",
                "name_ru": "Дискретная математика",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Badalyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name_en": "Math-Physics Equations",
                "name_hy": "Մաթ-Ֆիզիկական Հավասարումներ",
                "name_ru": "Математико-физические уравнения",
                "room_name": "305",
                "building_name": "12",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Math-Physics Equations",
                "name_hy": "Մաթ-Ֆիզիկական Հավասարումներ",
                "name_ru": "Математико-физические уравнения",
                "room_name": "305",
                "building_name": "12",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240",
                "day_of_week": "Wednesday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "101",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "101",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Probability Theory",
                "name_hy": "Հավանականության Տեսություն",
                "name_ru": "Теория Вероятностей",
                "room_name": "105",
                "building_name": "12",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Probability Theory",
                "name_hy": "Հավանականության Տեսություն",
                "name_ru": "Теория Вероятностей",
                "room_name": "105",
                "building_name": "12",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Computer Architecture - Course Work",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն - Կուրսային",
                "name_ru": "ЭВМ Архитектура - Курсовая",
                "room_name": "101",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Computer Architecture - Course Work",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն - Կուրսային",
                "name_ru": "ЭВМ Архитектура - Курсовая",
                "room_name": "101",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": True,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Math-Physics Equations",
                "name_hy": "Մաթ-Ֆիզիկական Հավասարումներ",
                "name_ru": "Математико-физические уравнения",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-3",
                "day_of_week": "Thursday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Coding Theory",
                "name_hy": "Կոդավորման Տեսություն",
                "name_ru": "Теория кодирования",
                "room_name": "206",
                "building_name": "12",
                "teacher_last_name": "Khachatryan",
                "group_name": "240-2",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Math-Physics Equations",
                "name_hy": "Մաթ-Ֆիզիկական Հավասարումներ",
                "name_ru": "Математико-физические уравнения",
                "room_name": "103",
                "building_name": "12",
                "teacher_last_name": "Hayrapetyan",
                "group_name": "240-1",
                "day_of_week": "Thursday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "14:20",
                "end_time": "15:40",
            },
            {
                "name_en": "Probability Theory",
                "name_hy": "Հավանականության Տեսություն",
                "name_ru": "Теория Вероятностей",
                "room_name": "208",
                "building_name": "12",
                "teacher_last_name": "Hakobyan",
                "group_name": "240",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": True,
                "start_time": "9:30",
                "end_time": "10:50",
            },
            {
                "name_en": "Probability Theory",
                "name_hy": "Հավանականության Տեսություն",
                "name_ru": "Теория Вероятностей",
                "room_name": "105",
                "building_name": "12",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Probability Theory",
                "name_hy": "Հավանականության Տեսություն",
                "name_ru": "Теория Вероятностей",
                "room_name": "105",
                "building_name": "12",
                "teacher_last_name": "Hakobyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "11:00",
                "end_time": "12:20",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-2",
                "day_of_week": "Friday",
                "is_odd": True,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-1",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },
            {
                "name_en": "Computer Architecture",
                "name_hy": "ԷՀՄ  Ճարտարագիտություն",
                "name_ru": "ЭВМ Архитектура",
                "room_name": "102",
                "building_name": "12",
                "teacher_last_name": "Haykazyan",
                "group_name": "240-2",
                "day_of_week": "Friday",
                "is_odd": False,
                "is_lecture": False,
                "start_time": "12:50",
                "end_time": "14:10",
            },

        ]

        courses = []
        count = 1
        for course in course_data:
            print(count)
            count += 1
            room = next(r for r in rooms if r.name == course["room_name"])
            building = next(b for b in buildings if b.name == course["building_name"])
            teacher = next(
                t for t in teachers if t.last_name_en == course["teacher_last_name"]
            )
            if "-" in course["group_name"]:
                group = next(g for g in groups if g.name == course["group_name"])
            courses.append(
                Course(
                    name_en=course["name_en"],
                    name_hy=course["name_hy"],
                    name_ru=course["name_ru"],
                    room_uuid=room.uuid,
                    building_uuid=building.uuid,
                    teacher_uuid=teacher.uuid,
                    group_uuid=group.uuid if group else None,
                    day_of_week=course["day_of_week"],
                    is_odd=course["is_odd"],
                    is_lecture=course["is_lecture"],
                    start_time=course["start_time"],
                    end_time=course["end_time"],
                )
            )

        await commit_changes(session, courses)

for table_name, table in Base.metadata.tables.items():
    print(f"Table Name: {table_name}")
    for column in table.columns:
        print(f" - Column: {column.name}, Type: {column.type}")

asyncio.run(add_initial_data())
