from django.shortcuts import render
from zzlprm.models import AuthUser
from zzlprm.Common import dictfetchall

from django.http import HttpResponse,JsonResponse
from django.core import serializers
import datetime
from django.db import connection
from django.contrib.auth.hashers import make_password

from django.http import HttpResponseRedirect  
import json
from rest_framework.decorators import api_view

# Create your views here.
@api_view(['GET','POST'])
def get_users(request):
    """获取用户"""
    cursor=connection.cursor()
    sql = "select * from auth_user order by updatetime desc"
    cursor.execute(sql)
    users = dictfetchall(cursor)
    return JsonResponse(users, safe=False)

@api_view(['GET','POST'])
def create_user(request):
    name = request.POST.get("name")
    username = request.POST.get("username")
    phone = request.POST.get("phone")
    email = request.POST.get("email")
    password = make_password("123456")
    issuperuser = 0
    isactive = 1
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    AuthUser.objects.create(
            password = password,
            is_superuser = issuperuser,
            username = username,
            name = name,
            email = email,
            phone = phone,
            is_active = isactive,
            createtime = createtime,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_user(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
        AuthUser.objects.filter(id=delete_ids_list[i]).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_user_byid(request):
    id = request.POST.get("id")

    cursor=connection.cursor()
    sql = "select * from auth_user "\
          "where id=%s"
    cursor.execute(sql,[id])
    users = dictfetchall(cursor)
    return JsonResponse(users, safe=False)

@api_view(['GET','POST'])
def edit_user(request):
    id = request.POST.get("id")
    name = request.POST.get("name")
    phone = request.POST.get("phone")
    email = request.POST.get("email")
    is_active = request.POST.get("isactive")
    updatetime = datetime.datetime.now()

    AuthUser.objects.filter(id=id).update(
        name = name,
        phone=phone,
        email = email,
        is_active = is_active,
        updatetime = updatetime
        )
    return HttpResponse("OK")
