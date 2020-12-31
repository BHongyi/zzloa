from django.shortcuts import render
from zzlprm.models import TbGroup
from zzlprm.models import TbGroupUser
from django.db.models import Q
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

# Create your views here.
@api_view(['GET','POST'])
def get_groups(request):
    """获取部门"""
    cursor=connection.cursor()
    sql = "select tb_group.groupid,tb_group.parentid "\
",CONCAT(tb_group.name,IFNULL(CONCAT('(',a.name,')'),'')) "\
"as label from tb_group "\
"LEFT JOIN ( "\
"select tb_group_user.groupid,auth_user.name from tb_group_user "\
"LEFT JOIN auth_user "\
"on tb_group_user.userid = auth_user.id "\
"where tb_group_user.ismanager = 1) a "\
"on tb_group.groupid = a.groupid "
    cursor.execute(sql)
    groups = dictfetchall(cursor)

    grouptree = list_to_tree(groups)
    return JsonResponse(grouptree, safe=False)

@api_view(['GET','POST'])
def get_group_user(request):
    """获取部门用户关联"""
    groupid = request.POST.get("groupid")
    cursor=connection.cursor()
    sql = "select auth_user.id,auth_user.name from tb_group_user "\
        "LEFT JOIN auth_user "\
        "ON tb_group_user.userid = auth_user.id "\
        "where tb_group_user.groupid=%s"
    cursor.execute(sql,[groupid])
    groups = dictfetchall(cursor)
    return JsonResponse(groups, safe=False)

@api_view(['GET','POST'])
def group_add_user(request):
    groupid = request.POST.get("groupid")
    userids = request.POST.get("movedKeys").split(',')
    for userid in userids:
        TbGroupUser.objects.create(
            groupid = int(groupid),
            userid = int(userid)
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def group_delete_user(request):
    groupid = request.POST.get("groupid")
    userids = request.POST.get("movedKeys").split(',')

    for userid in userids:
        TbGroupUser.objects.filter(Q(groupid=int(groupid)) & Q(userid=int(userid))).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def edit_group(request):
    groupid = request.POST.get("groupid")
    name = request.POST.get("name")
    parentid = request.POST.get("parentid")
    updatetime = datetime.datetime.now()

    if groupid == "undefined":
        createtime = datetime.datetime.now()
        TbGroup.objects.create(
            name = name,
            parentid = parentid,
            createtime = createtime,
            updatetime = updatetime
        )
    else:
        TbGroup.objects.filter(groupid=groupid).update(
            name = name,
            parentid=parentid,
            updatetime = updatetime
            )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def setmanager(request):
    groupid = request.POST.get("groupid")
    userid = request.POST.get("userid")

    TbGroupUser.objects.filter(groupid=groupid).update(
            ismanager = 0
            )
    
    TbGroupUser.objects.filter(Q(groupid=int(groupid)) & Q(userid=int(userid))).update(
            ismanager = 1
            )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_group(request):
    TbGroup.objects.filter(groupid=request.POST.get("groupid")).delete()
    return HttpResponse("OK")

def list_to_tree(data):
    out = { 
        0: { 'groupid': 0, 'parentid': 0, 'label': "Root node", 'children': [] }
    }

    for p in data:
        out.setdefault(p['parentid'], { 'children': [] })
        out.setdefault(p['groupid'], { 'children': [] })
        out[p['groupid']].update(p)
        out[p['parentid']]['children'].append(out[p['groupid']])

    return out[0]
