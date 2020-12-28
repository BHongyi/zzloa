from django.shortcuts import render
from zzlprm.models import TbPermission
from zzlprm.Common import dictfetchall

from django.http import HttpResponse,JsonResponse
from django.core import serializers
import datetime
from django.db import connection
from django.contrib.auth.hashers import make_password

from django.http import HttpResponseRedirect  
import datetime
import json
from rest_framework.decorators import api_view

@api_view(['GET','POST'])
def get_permissions(request):
    """获取权限"""
    cursor=connection.cursor()
    sql = "select permissionid,parentid,CONCAT(name,'(',code,')') as label,code,name from tb_permission "
    cursor.execute(sql)
    groups = dictfetchall(cursor)

    grouptree = list_to_tree(groups)
    return JsonResponse(grouptree, safe=False)

@api_view(['GET','POST'])
def edit_permission(request):
    permissionid = request.POST.get("permissionid")
    name = request.POST.get("name")
    parentid = request.POST.get("parentid")
    code = request.POST.get("code")

    if permissionid == "undefined":
        TbPermission.objects.create(
            name = name,
            parentid = parentid,
            code = code
        )
    else:
        TbPermission.objects.filter(permissionid=permissionid).update(
            name = name,
            parentid=parentid,
            code = code
            )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_permission(request):
    TbPermission.objects.filter(permissionid=request.POST.get("permissionid")).delete()
    return HttpResponse("OK")

def list_to_tree(data):
    out = { 
        0: { 'permissionid': 0, 'parentid': 0, 'label': "Root node",'code':"",'name':"", 'children': [] }
    }

    for p in data:
        out.setdefault(p['parentid'], { 'children': [] })
        out.setdefault(p['permissionid'], { 'children': [] })
        out[p['permissionid']].update(p)
        out[p['parentid']]['children'].append(out[p['permissionid']])

    return out[0]
