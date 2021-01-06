from django.http import HttpResponse,JsonResponse
from zzlprm.Common import dictfetchall
from django.db import connection
from rest_framework.decorators import api_view
from zzlprm.models import TbDailypaper
from zzlprm.models import TbDailypaperdetail
from zzlprm.models import TbDailypaperUser
import json
import datetime

@api_view(['GET','POST'])
def get_dailypapers(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "select tb_dailypaperdetail.*,CONCAT(tb_project.projectname,'-' "\
    ",tb_projectschedule.schedulename) as projectname from tb_dailypaperdetail "\
    "LEFT JOIN tb_projectschedule "\
    "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
    "LEFT JOIN tb_project "\
    "on tb_project.projectid = tb_projectschedule.projectid "\
    "LEFT JOIN tb_dailypaper "\
    "on tb_dailypaper.dailypaperid = tb_dailypaperdetail.dailypaperid "\
    "where tb_dailypaper.userid = %s"
    cursor.execute(sql,[userid])
    dailypaperdetails = dictfetchall(cursor)

    sql1 = "select tb_dailypaper.*,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
    "LEFT JOIN tb_dailypaper_user "\
    "on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
    "LEFT JOIN auth_user "\
    "on tb_dailypaper_user.userid = auth_user.id "\
    "where tb_dailypaper.userid =  %s "\
    "GROUP BY tb_dailypaper.dailypaperid "\
    "ORDER BY tb_dailypaper.dailypaperdate desc "
    cursor.execute(sql1,[userid])
    dailypapers = dictfetchall(cursor)

    returnjson = {
        'dailypapers':dailypapers,
        'dailypaperdetails':dailypaperdetails
    }
    return JsonResponse(returnjson, safe=False)

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

@api_view(['GET','POST'])
def create_dailypaper(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]
    checkeduser = json_data.get("checkeduser")
    dailypaperdate = datetime.datetime.strptime(json_data.get("dailypaperdate").split("T")[0],'%Y-%m-%d')
    contents = json_data.get("tableData")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    d = TbDailypaper.objects.create(
            userid = userid,
            dailypaperdate = dailypaperdate,
            createtime = createtime,
            updatetime = updatetime
        )
    
    for i in range(0,len(checkeduser)):
        TbDailypaperUser.objects.create(
            dailypaperid = d.pk,
            userid = checkeduser[i]
        )

    for j in range(0,len(contents)):
        projectscheduleid = contents[j].get("projectscheduleid")
        worktime = contents[j].get("worktime")
        workcontent = contents[j].get("workcontent")
        TbDailypaperdetail.objects.create(
            dailypaperid = d.pk,
            projectscheduleid = projectscheduleid,
            worktime = worktime,
            workcontent = workcontent
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_organization(request):
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

    sql1 = "select tb_group.groupid,auth_user.id,auth_user.name from tb_group "\
    "LEFT JOIN tb_group_user "\
    "on tb_group.groupid = tb_group_user.groupid "\
    "LEFT JOIN auth_user "\
    "on tb_group_user.userid = auth_user.id "\
    "WHERE auth_user.name is not NULL"
    cursor.execute(sql1)
    users = dictfetchall(cursor)

    returnjson = {
        'users':users,
        'grouptree':grouptree
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def load_userdailypaper(request):
    writerid = request.POST.get("userid")
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    receptionistid = dictfetchall(cursor)[0]["id"]

    sql = "select tb_dailypaper.dailypaperid,tb_dailypaper.dailypaperdate "\
    ",tb_dailypaper.createtime "\
    ",tb_dailypaper.userid as writer "\
    ",b.userid as receptionist from tb_dailypaper "\
    "LEFT JOIN (select * from tb_dailypaper_user where tb_dailypaper_user.userid = %s) b "\
    "on tb_dailypaper.userid = tb_dailypaper.userid "\
    "where tb_dailypaper.userid = %s  and b.userid is not null "\
    "GROUP BY tb_dailypaper.dailypaperid "\
    "ORDER BY tb_dailypaper.dailypaperdate desc,tb_dailypaper.createtime DESC"
    cursor.execute(sql,[receptionistid,writerid])
    dailypapers = dictfetchall(cursor)

    return JsonResponse(dailypapers, safe=False)

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