from fastapi import APIRouter
from api_v1.course.views import router as course_router
from api_v1.group.views import router as group_router

router_for_course = APIRouter()
router_for_group = APIRouter()
router_for_course.include_router(router=course_router, prefix="/schedules")
router_for_group.include_router(router=group_router, prefix="/groups")
