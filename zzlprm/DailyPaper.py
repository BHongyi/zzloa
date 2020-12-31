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