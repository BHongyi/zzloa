from django.http import HttpResponse,JsonResponse
from zzlprm.Common import dictfetchall
from django.db import connection
from rest_framework.decorators import api_view
from zzlprm.models import AuthUser

@api_view(['GET','POST'])
def get_projects(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "select CONCAT(tb_project.projectname,'-',tb_projectschedule.schedulename) "\
"as projectname,tb_projectschedule.projectscheduleid from tb_project "\
"LEFT JOIN tb_projectschedule "\
"on tb_project.projectid = tb_projectschedule.projectid "\
"LEFT JOIN tb_projectschedule_user "\
"on  tb_projectschedule.projectscheduleid = tb_projectschedule_user.projectscheduleid "\
"LEFT JOIN auth_user "\
"on auth_user.id = tb_projectschedule_user.userid "\
"where tb_projectschedule.isfinished = 0 "\
"and auth_user.id = %s"
    cursor.execute(sql,[userid])
    projects = dictfetchall(cursor)

    return JsonResponse(projects, safe=False)

@api_view(['GET','POST'])
def get_receptionists(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "call getManagerList(%s)"
    cursor.execute(sql,[userid])
    managers = dictfetchall(cursor)

    projectscheduleids = request.POST.get("projectscheduleids").split(',')
    sql1 = ""
    if projectscheduleids[0] != "":
        sql1 = "select userid from tb_projectschedule_user "\
        "where ismanager = 1 and ("
        for projectscheduleid in projectscheduleids:
            sql1 = sql1 + "projectscheduleid = "+ projectscheduleid +" or "
    
    if sql1 != "":
        sql1 = sql1[:-3]
        sql1 = sql1 + ")"
        cursor.execute(sql1)
        users = dictfetchall(cursor)
        for user in users:
            managers.append(user)

    return JsonResponse(managers, safe=False)