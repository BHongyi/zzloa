from django.shortcuts import render
from zzlprm.models import TbAudit
from zzlprm.models import TbLeave
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
def get_audits(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    me = dictfetchall(cursor)
    userid = me[0]["id"]

    sql = "select a.*,IF(ISNULL(tb_audit.audittime),1,2) as status "\
",tb_dict.typename "\
",auth_user.name as uname,if(tb_audit.userid = %s,1,2) as isme from ( "\
"select * from tb_leave "\
"where leaveid in ( "\
"select leaveid from tb_audit "\
"where userid = %s)) a "\
"LEFT JOIN tb_audit "\
"on a.leaveid = tb_audit.leaveid "\
"LEFT JOIN auth_user "\
"on a.userid = auth_user.id "\
"LEFT JOIN tb_dict "\
"on tb_dict.typeid = a.leavetype "\
"where a.currentnode = tb_audit.flownodeid "\
"and tb_dict.type = 7 "
    cursor.execute(sql,[userid,userid])
    audits = dictfetchall(cursor)
    return JsonResponse(audits, safe=False)

@api_view(['GET','POST'])
def approve_leave(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    cursor=connection.cursor()
    leaveid = json_data.get("leaveid")
    sqlaudit = "SELECT flowno,currentnode,auditid from tb_audit "\
    "LEFT JOIN tb_leave "\
    "on tb_audit.leaveid = tb_leave.leaveid "\
    "where tb_audit.flownodeid = tb_leave.currentnode "\
    "and tb_leave.leaveid = %s"
    cursor.execute(sqlaudit,[leaveid])
    leave = dictfetchall(cursor)
    auditid = leave[0].get("auditid")
    flowno = leave[0].get("flowno")
    currentnode = leave[0].get("currentnode")

    sqlflowline = "select nextnodeid from tb_flowline "\
    "where flowno = %s "\
    "and prevnodeid = %s"
    cursor.execute(sqlflowline,[flowno,currentnode])
    nextnodeid = dictfetchall(cursor)[0].get("nextnodeid")

    TbLeave.objects.filter(leaveid=leaveid).update(
        currentnode = nextnodeid
        )
    
    TbAudit.objects.filter(auditid=auditid).update(
        auditinfo = json_data.get("auditinfo"),
        audittime = datetime.datetime.now()
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def reject_leave(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    cursor=connection.cursor()
    leaveid = json_data.get("leaveid")
    sqlaudit = "SELECT flowno,currentnode,auditid from tb_audit "\
    "LEFT JOIN tb_leave "\
    "on tb_audit.leaveid = tb_leave.leaveid "\
    "where tb_audit.flownodeid = tb_leave.currentnode "\
    "and tb_leave.leaveid = %s"
    cursor.execute(sqlaudit,[leaveid])
    leave = dictfetchall(cursor)
    auditid = leave[0].get("auditid")
    flowno = leave[0].get("flowno")
    currentnode = leave[0].get("currentnode")

    sqlflowline = "select flownodeid from tb_flownode "\
    "where flowno = %s "\
    "and flownodetype = 0"
    cursor.execute(sqlflowline,[flowno])
    firstnodeid = dictfetchall(cursor)[0].get("flownodeid")

    TbLeave.objects.filter(leaveid=leaveid).update(
        currentnode = firstnodeid
        )
    
    TbAudit.objects.filter(auditid=auditid).update(
        auditinfo = json_data.get("auditinfo"),
        audittime = datetime.datetime.now()
        )
    return HttpResponse("OK")
