from django.urls import path

from zzlprm import UserManage
from zzlprm import GroupManage
from zzlprm import PermissionManage
from zzlprm import RoleManage
from zzlprm import Login
from zzlprm import ProjectManage
from zzlprm import DailyPaper
from zzlprm import PersonalPage

urlpatterns = [
    path('login/login/', Login.login),

    path('usermanage/get_users/', UserManage.get_users),
    path('usermanage/create_user/', UserManage.create_user),
    path('usermanage/delete_user/', UserManage.delete_user),
    path('usermanage/get_user_byid/', UserManage.get_user_byid),
    path('usermanage/edit_user/', UserManage.edit_user),
    path('usermanage/get_positiontypes/', UserManage.get_positiontypes),

    path('groupmanage/get_groups/', GroupManage.get_groups),
    path('groupmanage/edit_group/', GroupManage.edit_group),
    path('groupmanage/delete_group/', GroupManage.delete_group),
    path('groupmanage/get_group_user/', GroupManage.get_group_user),
    path('groupmanage/group_add_user/', GroupManage.group_add_user),
    path('groupmanage/group_delete_user/', GroupManage.group_delete_user),
    path('groupmanage/setmanager/', GroupManage.setmanager),

    path('permissionmanage/get_permissions/', PermissionManage.get_permissions),
    path('permissionmanage/edit_permission/', PermissionManage.edit_permission),
    path('permissionmanage/delete_permission/', PermissionManage.delete_permission),

    path('rolemanage/get_roles/', RoleManage.get_roles),
    path('rolemanage/get_role_byid/', RoleManage.get_role_byid),
    path('rolemanage/create_role/', RoleManage.create_role),
    path('rolemanage/delete_role/', RoleManage.delete_role),
    path('rolemanage/edit_role/', RoleManage.edit_role),
    path('rolemanage/get_role_permission/', RoleManage.get_role_permission),
    path('rolemanage/edit_role_permission/', RoleManage.edit_role_permission),
    path('rolemanage/get_user_role/', RoleManage.get_user_role),
    path('rolemanage/edit_role_user/', RoleManage.edit_role_user),

    path('projectmanage/get_projects/', ProjectManage.get_projects),
    path('projectmanage/get_project_types/', ProjectManage.get_project_types),
    path('projectmanage/create_project/', ProjectManage.create_project),
    path('projectmanage/delete_project/', ProjectManage.delete_project),
    path('projectmanage/get_project_byid/', ProjectManage.get_project_byid),
    path('projectmanage/edit_project/', ProjectManage.edit_project),
    path('projectmanage/get_project_schedule/', ProjectManage.get_project_schedule),
    path('projectmanage/create_project_schedule/', ProjectManage.create_project_schedule),
    path('projectmanage/edit_project_schedule/', ProjectManage.edit_project_schedule),
    path('projectmanage/delete_project_schedule/', ProjectManage.delete_project_schedule),
    path('projectmanage/get_project_schedule_byid/', ProjectManage.get_project_schedule_byid),

    path('dailypaper/get_projects/', DailyPaper.get_projects),
    path('dailypaper/get_receptionists/', DailyPaper.get_receptionists),
    path('dailypaper/create_dailypaper/', DailyPaper.create_dailypaper),
    path('dailypaper/get_dailypapers/', DailyPaper.get_dailypapers),
    path('dailypaper/get_organization/', DailyPaper.get_organization),
    path('dailypaper/load_userdailypaper/', DailyPaper.load_userdailypaper),
    path('dailypaper/read_dailypaperdetail/', DailyPaper.read_dailypaperdetail),

    path('personalpage/edit_password/', PersonalPage.edit_password),
]