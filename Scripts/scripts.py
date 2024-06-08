from sqlalchemy.orm import sessionmaker
from Models.models import Base, Teacher, Building, Room, Department, Major, Group, Student, Course
from app import engine

Session = sessionmaker(bind=engine)
session = Session()

buildings_data = [
    {"city":"Yerevan", "street":"Teryan 52", "name": "2 corpus"},
    {"city":"Yerevan", "street":"Teryan 52", "name": "5 corpus"},
    {"city":"Yerevan", "street":"Koryun 9", "name": "12 corpus"},
    {"city":"Yerevan", "street":"Koryun 11", "name": "9 corpus"},
]

buildings = [Building(building["city"], building["street"], building["name"]) for building in buildings_data]

session.add_all(buildings)
session.commit()

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
    new_room = Room(room["name"], building.uuid)
    rooms.append(new_room)

session.add_all(rooms)
session.commit()

department_data = [
    {"name": "Informatics", "room_name":"108", "building_name": "5 corpus"},
    {"name": "Mathematics", "room_name":"209", "building_name": "12 corpus"},
    {"name": "Programming and Algorithms", "room_name": "905", "building_name": "5 corpus"},
    {"name": "Philosophy", "room_name": "401", "building_name": "2 corpus"},
    {"name": "Mechanics", "room_name": "112", "building_name": "9 corpus"}

]

departments = []
for department in department_data:
    building = next(b for b in buildings if b.name == department["building_name"])
    room = next(r for r in rooms if r.name == department["room_name"])
    new_department = Department(department["name"], room.uuid, building.uuid)
    departments.append(new_department)

session.add_all(departments)
session.commit()


teacher_data = [
    {"first_name": "S", "last_name": "Episkoposyan", "department":"Mathematics"},
    {"first_name": "N", "last_name": "Sahakyan", "department":"Informatics"},
    {"first_name": "S", "last_name": "Hayrapetyan", "department":"Mathematics"},
    {"first_name": "N", "last_name": "Badalyan", "department":"Mathematics"},
    {"first_name": "V", "last_name": "Saroyan", "department":"Mechanics"},
    {"first_name": "P", "last_name": "Hakobyan", "department":"Mathematics"},
    {"first_name": "J", "last_name": "Srapionyan", "department":"Mathematics"},
    {"first_name": "G", "last_name": "Zaprosyan", "department":"Programming and Algorithms"},
    {"first_name": "S", "last_name": "Meliqyan", "department":"Programming and Algorithms"},
    {"first_name": "I", "last_name": "Saghatelyan", "department":"Programming and Algorithms"},
    {"first_name": "N", "last_name": "Baxdasaryan", "department":"Philosophy"},
]
teachers = []
for teacher in teacher_data:
    department = next(d for d in departments if d.name == teacher["department"])
    new_teacher = Teacher(teacher["first_name"], teacher["last_name"], department.uuid)
    teachers.append(new_teacher)

session.add_all(teachers)
session.commit()


major_data = ["Applied Mathematics and Informatics", "Cyber Security", "Artificial Inteligence", "Programming Architecture"]
majors = [Major(major) for major in major_data]
session.add_all(majors)
session.commit()


group_data =[
    {"name":"240-1", "major":"Applied Mathematics and Informatics"},
    {"name":"240-2", "major":"Applied Mathematics and Informatics"},
    {"name":"240-3", "major":"Applied Mathematics and Informatics"}
]

groups = []
for group in group_data:
    major = next(m for m in majors if m.name == group["major"])
    groups.append(Group(group["name"], major.uuid))

session.add_all(groups)
session.commit()

student_data = [
    {"first_name":"Arsen", "last_name":"Grigoryan", "email":"arsen.grigoryan555@gmail.com", "group":"240-2"},
    {"first_name":"Niko", "last_name":"Isaxanyan", "email":"niko.isaxanyan@gmail.com", "group":"240-3"}
]

students = []
for student in student_data:
    group = next(g for g in groups if g.name == student["group"])
    students.append(Student(student["first_name"], student["last_name"], student["email"], group.uuid))

session.add_all(students)
session.commit()

course_data = [
    {"name":"Complex Analysis", "room_name": "201", "building_name": "12 corpus", "teacher_last_name": "Episkoposyan", "group_name":"240-2", "day_of_week":"Wednesday", "is_odd": True, "start_time":"11:00", "end_time":"12:20"},
    {"name":"Programming", "room_name": "106", "building_name": "5 corpus", "teacher_last_name": "Sahakyan", "group_name":"240-2", "day_of_week":"Monday", "is_odd": True, "start_time":"9:30", "end_time":"10:50"},
    {"name":"Web Development", "room_name": "101", "building_name": "12 corpus", "teacher_last_name": "Zaprosyan", "group_name":"240-2", "day_of_week":"Thusrday", "is_odd": True, "start_time":"12:50", "end_time":"14:10"},
    {"name":"Mathematical Logic", "room_name": "305", "building_name": "12 corpus", "teacher_last_name": "Badalyan", "group_name":"240-2", "day_of_week":"Wednesday", "is_odd": True, "start_time":"11:00", "end_time":"12:20"},
    {"name":"Philosophy", "room_name": "102", "building_name": "12 corpus", "teacher_last_name": "Baxdasaryan", "group_name":"240-2", "day_of_week":"Friday", "is_odd": False, "start_time":"12:50", "end_time":"14:10"},
    {"name":"Mechanics", "room_name": "108", "building_name": "9 corpus", "teacher_last_name": "Saroyan", "group_name":"240-2", "day_of_week":"Thursday", "is_odd": False, "start_time":"11:00", "end_time":"12:20"},
    {"name":"Mathematical Equations", "room_name": "105", "building_name": "12 corpus", "teacher_last_name": "Hayrapetyan", "group_name":"240-3", "day_of_week":"Monday", "is_odd": True, "start_time":"14:20", "end_time":"15:40"},
    {"name":"Probability Theory", "room_name": "201", "building_name": "12 corpus", "teacher_last_name": "Hakobyan", "group_name":"240-3", "day_of_week":"Wednesday", "is_odd": False, "start_time":"9:30", "end_time":"11:00"}
]

courses =[]

for course in course_data:
    room = next(r for r in rooms if r.name == course["room_name"])
    building = next(b for b in buildings if b.name == course["building_name"])
    teacher = next(t for t in teachers if t.last_name == course["teacher_last_name"])
    group = next(g for g in groups if g.name == course["group_name"])
    courses.append(Course(course["name"], room.uuid, building.uuid, teacher.uuid, group.uuid, course["day_of_week"], course["is_odd"], course["start_time"], course["end_time"]))

session.add_all(courses)
session.commit()