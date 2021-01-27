from django.shortcuts import render
from zzlprm.models import AuthUser
from rest_framework_jwt.settings import api_settings

from django.http import HttpResponse,JsonResponse
from django.core import serializers
import datetime
from django.db import connection
from django.contrib.auth.hashers import make_password,check_password

from rest_framework.authtoken.models import Token
from django.contrib import auth

from django.http import HttpResponseRedirect  
import json
import datetime

# Create your views here.testbranch

def login(request):
    """获取用户"""
    username = request.POST.get("username")
    password = request.POST.get("password")

    cursor=connection.cursor()
    sql = "select password,positiontype,name,id from auth_user "\
        "where username=%s and is_active=1"
    cursor.execute(sql,[username])
    result = dictfetchall(cursor)

    if len(result) == 0:
        return HttpResponse("账号密码不正确")

    passwordtmp = result[0]["password"]
    ispass = check_password(password, passwordtmp)

    user = AuthUser()
    user.username = username
    user.positiontype = result[0]["positiontype"]
    uname = result[0]["name"]
    uid = result[0]["id"]

    if ispass:
        jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
        jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER

        payload = jwt_payload_handler(user)
        # payload = {'email': '', 'exp': datetime.datetime.now() + api_settings.JWT_EXPIRATION_DELTA, 'identifier': '', 'user_id': None, 'username': username}
        token = jwt_encode_handler(payload)

        sql1 = "SELECT DISTINCT(tb_permission.code) FROM tb_user_role "\
            "LEFT JOIN auth_user "\
            "on tb_user_role.userid = auth_user.id "\
            "LEFT JOIN tb_role_permission "\
            "on tb_user_role.roleid = tb_role_permission.roleid "\
            "LEFT JOIN tb_permission "\
            "on tb_role_permission.permissionid = tb_permission.permissionid "\
            "where auth_user.username=%s"
        cursor.execute(sql1,[username])
        permissions = dictfetchall(cursor)

        AuthUser.objects.filter(id=uid).update(
            last_login = datetime.datetime.now()
            )
        
        returnjson = {
            'uname':uname,
            'token':token,
            'permissions':permissions,
            'positiontype':user.positiontype
            }
        return JsonResponse(returnjson, safe=False)
    else:
        return HttpResponse("账号密码不正确")

def dictfetchall(cursor):
    "Return all rows from a cursor as a dict"
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]