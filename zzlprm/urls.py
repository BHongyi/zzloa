from django.urls import path

from zzlprm import UserManage
from zzlprm import GroupManage
from zzlprm import PermissionManage
from zzlprm import RoleManage
from zzlprm import Login
from zzlprm import ProjectManage

urlpatterns = [
    path('login/login/', Login.login),

    path('usermanage/get_users/', UserManage.get_users),
    path('usermanage/create_user/', UserManage.create_user),
    path('usermanage/delete_user/', UserManage.delete_user),
    path('usermanage/get_user_byid/', UserManage.get_user_byid),
    path('usermanage/edit_user/', UserManage.edit_user),

    path('groupmanage/get_groups/', GroupManage.get_groups),
    path('groupmanage/edit_group/', GroupManage.edit_group),
    path('groupmanage/delete_group/', GroupManage.delete_group),
    path('groupmanage/get_group_user/', GroupManage.get_group_user),
    path('groupmanage/group_add_user/', GroupManage.group_add_user),
    path('groupmanage/group_delete_user/', GroupManage.group_delete_user),

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

]