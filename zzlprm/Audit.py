from django.shortcuts import render
from zzlprm.models import AuthUser
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

    sql = "select tb_leave.leaveid,tb_dict.typename as leavetype, "\
"auth_user.name as applicant,tb_leave.leavereason, "\
"tb_leave.starttime,tb_leave.finishtime, "\
"tb_leave.createtime,tb_leave.updatetime from tb_audit "\
"LEFT JOIN tb_leave "\
"on tb_audit.leaveid = tb_leave.leaveid "\
"LEFT JOIN tb_dict "\
"on tb_leave.leavetype = tb_dict.typeid "\
"LEFT JOIN auth_user "\
"on tb_leave.userid = auth_user.id "\
"where tb_audit.flownodeid = tb_leave.currentnode "\
"and tb_audit.userid "\
"and tb_dict.type = 7 "\
"and tb_audit.userid = %s "
    cursor.execute(sql,[userid])
    audits = dictfetchall(cursor)
    return JsonResponse(audits, safe=False)
