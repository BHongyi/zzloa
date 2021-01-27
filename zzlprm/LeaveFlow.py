from django.shortcuts import render
from zzlprm.models import TbLeave
from zzlprm.models import TbAudit
from zzlprm.Common import dictfetchall

from django.http import HttpResponse,JsonResponse
from django.core import serializers
import datetime
from django.db import connection

from django.http import HttpResponseRedirect  
import json
from rest_framework.decorators import api_view

# Create your views here.
@api_view(['GET','POST'])
def get_leaves(request):
    cursor=connection.cursor()
    sql = "select * from tb_leave order by updatetime desc"
    cursor.execute(sql)
    leaves = dictfetchall(cursor)
    return JsonResponse(leaves, safe=False)

@api_view(['GET','POST'])
def get_leavetypes(request):
    cursor=connection.cursor()
    sql = "select * from tb_dict "\
          "where type=7"
    cursor.execute(sql)
    leavetypes = dictfetchall(cursor)
    return JsonResponse(leavetypes, safe=False)

@api_view(['GET','POST'])
def get_flowuserlists(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    me = dictfetchall(cursor)
    userid = me[0]["id"]
    name = me[0]["name"]

    result = get_flowuserlists_byid(userid,name)
    return JsonResponse(result, safe=False)

@api_view(['GET','POST'])
def create_leave(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    flowuserlists = json_data.get("flowuserlists")

    l = TbLeave.objects.create(
        userid = flowuserlists[0].get("userid"),
        leavetype = json_data.get("leavetype"),
        leavereason = json_data.get("leavereason"),
        starttime = json_data.get("timerange")[0],
        finishtime = json_data.get("timerange")[1],
        flowno = 1,
        currentnode = flowuserlists[1].get("flownodeid"),
        createtime = datetime.datetime.now(),
        updatetime = datetime.datetime.now()
        )
    for i in range(0,len(flowuserlists)):
        if i == 0:
            TbAudit.objects.create(
                leaveid = l.pk,
                flownodeid = flowuserlists[i].get("flownodeid"),
                userid = flowuserlists[i].get("userid"),
                audittime = datetime.datetime.now()
                )
        else:
            TbAudit.objects.create(
                leaveid = l.pk,
                flownodeid = flowuserlists[i].get("flownodeid"),
                userid = flowuserlists[i].get("userid"),
                )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_leave_byid(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    me = dictfetchall(cursor)
    
    leaveid = request.POST.get("leaveid")
    sql = "select tb_leave.*,auth_user.name as uname from tb_leave "\
    "LEFT JOIN auth_user "\
    "on tb_leave.userid = auth_user.id "\
    "where leaveid = %s "
    cursor.execute(sql,[leaveid])
    leave = dictfetchall(cursor)
    flowuserlists = get_flowuserlists_byid(leave[0].get("userid"),leave[0].get("uname"))
    leave[0]["flowuserlists"] = flowuserlists

    for i in range(0,len(flowuserlists)):
        if flowuserlists[i].get("userid") == me[0]["id"]:
            leave[0]["active"] = i
    return JsonResponse(leave, safe=False)

def get_flowuserlists_byid (userid,name):
    cursor=connection.cursor()
    sql_line = "SELECT * from tb_flowline where flowno = 1 "
    cursor.execute(sql_line)
    flowlines = dictfetchall(cursor)
    sql_node = "SELECT * from tb_flownode where flowno = 1 "
    cursor.execute(sql_node)
    flownodes = dictfetchall(cursor)

    result = []
    for i in range(0,len(flownodes)):
        if flownodes[i].get("flownodetype") == 0:
            result.append(flownodes[i])
            sortnode(flownodes[i],flowlines,flownodes,result)
    for i in range(0,len(result)):
        uid = None
        uname = None
        # 部门经理
        if result[i].get("flownodetype") == 1:
            manager = getdeptmanager(userid)
            uid = manager[0].get("userid")
            uname = manager[0].get("name")
        # 起草
        elif result[i].get("flownodetype") == 0:
            uid = userid
            uname = name
        # 其他角色
        else:
            roleuser = getroleuser(result[i].get("flownodename"))
            uid = roleuser[0].get("userid")
            uname = roleuser[0].get("name")
        result[i]["userid"] = uid
        result[i]["uname"] = uname
    return result

def sortnode(node,flowlines,flownodes,result):
    for i in range(0,len(flowlines)):
        if node.get("flownodeid") == flowlines[i].get("prevnodeid"):
            for j in range(0,len(flownodes)):
                if flowlines[i].get("nextnodeid") == flownodes[j].get("flownodeid"):
                    result.append(flownodes[j])
                    sortnode(flownodes[j],flowlines,flownodes,result)

def getdeptmanager(userid):
    cursor=connection.cursor()
    sql_manager = "select a.*,auth_user.name from ( "\
    "select userid from tb_group_user "\
    "where ismanager = 1 and groupid = "\
    "(SELECT groupid from tb_group_user "\
    "where userid = %s "\
    "LIMIT 1)) a "\
    "LEFT JOIN auth_user "\
    "on a.userid = auth_user.id "
    cursor.execute(sql_manager,[userid])
    return dictfetchall(cursor)

def getroleuser(flownodename):
    cursor=connection.cursor()
    sql_roleuserid = "select tb_flownodeuser.userid,auth_user.name from tb_flownodeuser "\
    "LEFT JOIN auth_user "\
    "on tb_flownodeuser.userid = auth_user.id "\
    "where tb_flownodeuser.flownodename = %s "
    cursor.execute(sql_roleuserid,[flownodename])
    return dictfetchall(cursor)