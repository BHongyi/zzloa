from django.shortcuts import render
from zzlprm.models import TbRole
from zzlprm.models import TbRolePermission
from zzlprm.models import TbUserRole
from zzlprm.Common import dictfetchall

from django.http import HttpResponse, JsonResponse
from django.core import serializers
import datetime
from django.db import connection
from django.contrib.auth.hashers import make_password

from django.http import HttpResponseRedirect
import json
from rest_framework.decorators import api_view

# Create your views here.

@api_view(['GET','POST'])
def get_roles(request):
    cursor = connection.cursor()
    sql = "select * from tb_role order by updatetime desc"
    cursor.execute(sql)
    roles = dictfetchall(cursor)
    return JsonResponse(roles, safe=False)

@api_view(['GET','POST'])
def get_role_byid(request):
    roleid = request.POST.get("roleid")

    cursor = connection.cursor()
    sql = "select * from tb_role "\
          "where roleid=%s"
    cursor.execute(sql, [roleid])
    role = dictfetchall(cursor)
    return JsonResponse(role, safe=False)

@api_view(['GET','POST'])
def create_role(request):
    rolename = request.POST.get("rolename")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    TbRole.objects.create(
            rolename=rolename,
            createtime=createtime,
            updatetime=updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_role(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0, len(delete_ids_list)):
        TbRole.objects.filter(roleid=int(delete_ids_list[i])).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def edit_role(request):
    roleid = request.POST.get("roleid")
    rolename = request.POST.get("rolename")
    updatetime = datetime.datetime.now()

    TbRole.objects.filter(roleid=roleid).update(
        rolename=rolename,
        updatetime=updatetime
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_role_permission(request):
    roleid = request.POST.get("roleid")
    cursor = connection.cursor()
    sql = "select * from tb_role_permission "\
          "where roleid=%s"
    cursor.execute(sql, [roleid])
    roles = dictfetchall(cursor)
    return JsonResponse(roles, safe=False)

@api_view(['GET','POST'])
def edit_role_permission(request):
    roleid = request.POST.get("roleid")
    permissionid = request.POST.get("permissionid")
    permissionid_list = permissionid.split(',')

    TbRolePermission.objects.filter(roleid=int(roleid)).delete()
    for i in range(0, len(permissionid_list)):
        TbRolePermission.objects.create(
            roleid=int(roleid),
            permissionid=int(permissionid_list[i]),
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_user_role(request):
    roleid = request.POST.get("roleid")

    cursor = connection.cursor()
    sql = "SELECT auth_user.id FROM tb_user_role "\
        "LEFT JOIN auth_user "\
        "on tb_user_role.userid = auth_user.id "\
        "where tb_user_role.roleid=%s"
    cursor.execute(sql, [roleid])
    users = dictfetchall(cursor)

    return JsonResponse(users, safe=False)

@api_view(['GET','POST'])
def edit_role_user(request):
    roleid = request.POST.get("roleid")
    userid = request.POST.get("userid")
    userid_list = userid.split(',')

    TbUserRole.objects.filter(roleid=int(roleid)).delete()
    for i in range(0, len(userid_list)):
        TbUserRole.objects.create(
            roleid=int(roleid),
            userid=int(userid_list[i]),
        )

    return HttpResponse("OK")
