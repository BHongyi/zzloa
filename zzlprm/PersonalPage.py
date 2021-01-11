from django.shortcuts import render
from zzlprm.models import AuthUser
from zzlprm.Common import dictfetchall
from django.contrib.auth.hashers import make_password,check_password

from django.http import HttpResponse,JsonResponse
from django.core import serializers
from django.db import connection
from django.contrib.auth.hashers import make_password

from django.http import HttpResponseRedirect  
import json
from rest_framework.decorators import api_view
import datetime

@api_view(['GET','POST'])
def edit_password(request):
    username = request.user.username
    oldpassword = request.POST.get("oldpassword")
    newpassword = make_password(request.POST.get("newpassword"))
    updatetime = datetime.datetime.now()

    cursor=connection.cursor()
    sql = "select * from auth_user where username=%s "
    cursor.execute(sql,username)
    users = dictfetchall(cursor)

    passwordtmp = users[0]["password"]

    ispass = check_password(oldpassword, passwordtmp)

    if ispass:
        AuthUser.objects.filter(username=username).update(
        password = newpassword,
        updatetime = updatetime
        )
        return HttpResponse("OK")
    else:
        return HttpResponse("旧密码不正确")