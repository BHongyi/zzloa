from django.http import HttpResponse,JsonResponse
from zzlprm.Common import dictfetchall
from django.db import connection
from django.db.models import Q
from rest_framework.decorators import api_view
from zzlprm.models import TbDailypaper
from zzlprm.models import TbDailypaperdetail
from zzlprm.models import TbDailypaperUser
import json
import datetime
import time
from datetime import date,timedelta

@api_view(['GET','POST'])
def get_dailypapers(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "select tb_dailypaperdetail.*,tb_dict.typename,CONCAT(tb_project.projectname,'-' "\
    ",tb_projectschedule.schedulename) as projectname from tb_dailypaperdetail "\
    "LEFT JOIN tb_projectschedule "\
    "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
    "LEFT JOIN tb_project "\
    "on tb_project.projectid = tb_projectschedule.projectid "\
    "LEFT JOIN tb_dailypaper "\
    "on tb_dailypaper.dailypaperid = tb_dailypaperdetail.dailypaperid "\
    "LEFT JOIN tb_dict "\
    "on tb_dailypaperdetail.worktype = tb_dict.typeid "\
    "and tb_dict.type=9 "\
    "where tb_dailypaper.userid = %s"
    cursor.execute(sql,[userid])
    dailypaperdetails = dictfetchall(cursor)

    sql1 = "select a.*,b.readreceptionists from ( "\
"select tb_dailypaper.*,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"where tb_dailypaper.userid =  "+str(userid)+" "\
"GROUP BY tb_dailypaper.dailypaperid "\
"ORDER BY tb_dailypaper.dailypaperdate desc) a "\
"LEFT JOIN (select tb_dailypaper.dailypaperid,group_concat(auth_user.name) as readreceptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"where tb_dailypaper.userid =  "+str(userid)+" "\
"and tb_dailypaper_user.isread = 1 "\
"GROUP BY tb_dailypaper.dailypaperid "\
"ORDER BY tb_dailypaper.dailypaperdate desc) b "\
"on a.dailypaperid = b.dailypaperid "
    cursor.execute(sql1)
    dailypapers = dictfetchall(cursor)

    threedayago = date.today()
    for i in range(0,2):
        threedayago = prev_weekday(threedayago)
    returnjson = {
        'dailypapers':dailypapers,
        'dailypaperdetails':dailypaperdetails,
        'threedayago':threedayago,
        'today':date.today()
    }
    return JsonResponse(returnjson, safe=False)

def prev_weekday(adate):
    adate -= timedelta(days=1)
    while adate.weekday() > 4: # Mon-Fri are 0-4
        adate -= timedelta(days=1)
    return adate

@api_view(['GET','POST'])
def get_projects(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "SELECT * from (select CONCAT(tb_project.projectname,'-',tb_projectschedule.schedulename) "\
"as projectname,tb_projectschedule.projectscheduleid from tb_project "\
"LEFT JOIN tb_projectschedule "\
"on tb_project.projectid = tb_projectschedule.projectid "\
"LEFT JOIN tb_projectschedule_user "\
"on  tb_projectschedule.projectscheduleid = tb_projectschedule_user.projectscheduleid "\
"LEFT JOIN auth_user "\
"on auth_user.id = tb_projectschedule_user.userid "\
"where tb_projectschedule.isfinished = 0 and tb_projectschedule.isdeleted=0 "\
"and auth_user.id = %s) a "\
"group by a.projectscheduleid"
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
    
    managerids = ''
    for i in range(0,len(managers)):
        managerids = managerids + str(managers[i].get("userid")) + ','
    managerids =  managerids[:-1]

    if managerids != '':
        sql_manager = " select id as userid from auth_user where is_active=1 and id in ("+managerids+")"
        cursor.execute(sql_manager)
        managers = dictfetchall(cursor)

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

    sqldatecheck = "SELECT * FROM tb_dailypaper "\
    "where dailypaperdate = %s "\
    "and userid = %s"
    cursor.execute(sqldatecheck,[json_data.get("dailypaperdate").split("T")[0],userid])
    if len(dictfetchall(cursor))>0:
        return HttpResponse("一天只能提交一个日报")


    d = TbDailypaper.objects.create(
            userid = userid,
            dailypaperdate = dailypaperdate,
            createtime = createtime,
            updatetime = updatetime
        )
    
    for i in range(0,len(checkeduser)):
        TbDailypaperUser.objects.create(
            dailypaperid = d.pk,
            userid = checkeduser[i],
            isread = 0
        )

    for j in range(0,len(contents)):
        projectscheduleid = contents[j].get("projectscheduleid")
        worktime = contents[j].get("worktime")
        workcontent = contents[j].get("workcontent")
        worktype = contents[j].get("worktype")
        TbDailypaperdetail.objects.create(
            dailypaperid = d.pk,
            projectscheduleid = projectscheduleid,
            worktime = worktime,
            worktype = worktype,
            workcontent = workcontent
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_organization(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

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

    sql1 = "select c.*,count(d.dailypaperid) as count from ( "\
        "SELECT (@rowNO := @rowNo+1) AS rowno,a.* from ( "\
        "select tb_group.groupid,auth_user.id,auth_user.name from tb_group "\
        "LEFT JOIN tb_group_user  "\
        "on tb_group.groupid = tb_group_user.groupid  "\
        "LEFT JOIN auth_user  "\
        "on tb_group_user.userid = auth_user.id  "\
        "WHERE auth_user.name is not NULL and auth_user.is_active = 1) a,(select @rowNO :=0) b) c "\
        "LEFT JOIN (select tb_dailypaper.*,tb_dailypaper_user.isread from tb_dailypaper "\
        "LEFT JOIN tb_dailypaper_user "\
        "ON tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
        "where tb_dailypaper_user.userid = %s "\
        "and tb_dailypaper_user.isread = 0 "\
        ") d "\
        "on c.id = d.userid "\
        "GROUP BY c.rowno "
    cursor.execute(sql1,userid)
    users = dictfetchall(cursor)

    returnjson = {
        'users':users,
        'grouptree':grouptree
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def load_userdailypaper_bydate(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]
    dailypaperdate = request.POST.get("dailypaperdate")

    sql = "select tb_dailypaper.*,auth_user.name as writer,auth_user.positiontype "\
",tb_dailypaper_user.isread,z.receptionists,z.readreceptionists "\
"from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper.userid = auth_user.id "\
"LEFT JOIN (select x.*,y.readreceptionists from (  "\
"SELECT tb_dailypaper.dailypaperid,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"GROUP BY tb_dailypaper.dailypaperid) x "\
"LEFT JOIN (SELECT tb_dailypaper.dailypaperid,group_concat(auth_user.name) as readreceptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"where tb_dailypaper_user.isread = 1 "\
"GROUP BY tb_dailypaper.dailypaperid) y "\
"ON x.dailypaperid = y.dailypaperid) z "\
"on tb_dailypaper.dailypaperid = z.dailypaperid "\
"where tb_dailypaper_user.userid = %s "\
"and tb_dailypaper.dailypaperdate = %s"
    cursor.execute(sql,[userid,dailypaperdate])
    dailypapers = dictfetchall(cursor)

    sql_detail_dev = "select tb_dailypaperdetail.*,tb_dict.typename,CONCAT(tb_project.projectname,'-' "\
        ",tb_projectschedule.schedulename) as projectname from tb_dailypaperdetail "\
        "LEFT JOIN tb_projectschedule "\
        "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
        "LEFT JOIN tb_project "\
        "on tb_project.projectid = tb_projectschedule.projectid "\
        "LEFT JOIN tb_dailypaper "\
        "on tb_dailypaper.dailypaperid = tb_dailypaperdetail.dailypaperid "\
        "LEFT JOIN tb_dict "\
        "on tb_dailypaperdetail.worktype = tb_dict.typeid "\
        "and tb_dict.type=9 "\
        "where tb_dailypaper.dailypaperdate = %s "
    cursor.execute(sql_detail_dev,[dailypaperdate])
    dailypaperdetails_dev = dictfetchall(cursor)

    sql_detail_business = "select tb_dailypaperdetail_sale.*,tb_dict.typename,tb_business.businessname,tb_contact.contactname from tb_dailypaperdetail_sale "\
        "LEFT JOIN tb_business "\
        "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
        "LEFT JOIN tb_dailypaper "\
        "on tb_dailypaper.dailypaperid = tb_dailypaperdetail_sale.dailypaperid "\
        "LEFT JOIN tb_contact "\
        "on tb_contact.contactid = tb_dailypaperdetail_sale.contactid "\
        "LEFT JOIN tb_dict "\
        "on tb_dailypaperdetail_sale.worktype = tb_dict.typeid "\
        "and tb_dict.type=5 "\
        "where tb_dailypaper.dailypaperdate = %s"
    cursor.execute(sql_detail_business,[dailypaperdate])
    dailypaperdetails_business = dictfetchall(cursor)

    returnjson = {
        'dailypapers':dailypapers,
        'dailypaperdetails_dev':dailypaperdetails_dev,
        'dailypaperdetails_business':dailypaperdetails_business
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def load_userdailypaper(request):
    writerid = request.POST.get("userid")
    limit = request.POST.get("limit")
    page = request.POST.get("page")
    startindex = (int(page)-1)*int(limit)
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    receptionistid = dictfetchall(cursor)[0]["id"]

    sql = "select a.*,z.receptionists,z.readreceptionists from ( "\
"select tb_dailypaper.dailypaperid,tb_dailypaper.dailypaperdate "\
",tb_dailypaper.createtime "\
",tb_dailypaper.userid as writer "\
",b.userid as receptionist,b.isread from tb_dailypaper "\
"LEFT JOIN (select * from tb_dailypaper_user where tb_dailypaper_user.userid = %s) b "\
"on tb_dailypaper.dailypaperid = b.dailypaperid "\
"where tb_dailypaper.userid = %s  and b.userid is not null "\
"GROUP BY tb_dailypaper.dailypaperid "\
"ORDER BY tb_dailypaper.dailypaperdate desc,tb_dailypaper.createtime DESC) a "\
"LEFT JOIN (select x.*,y.readreceptionists from ( "\
"SELECT tb_dailypaper.dailypaperid,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"GROUP BY tb_dailypaper.dailypaperid) x "\
"LEFT JOIN (SELECT tb_dailypaper.dailypaperid,group_concat(auth_user.name) as readreceptionists from tb_dailypaper "\
"LEFT JOIN tb_dailypaper_user "\
"on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
"LEFT JOIN auth_user "\
"on tb_dailypaper_user.userid = auth_user.id "\
"where tb_dailypaper_user.isread = 1 "\
"GROUP BY tb_dailypaper.dailypaperid) y "\
"ON x.dailypaperid = y.dailypaperid) z "\
"on a.dailypaperid = z.dailypaperid limit "+str(startindex)+","+str(limit)+";"
    cursor.execute(sql,[receptionistid,writerid])
    dailypapers = dictfetchall(cursor)
    dailypaperids = ''
    for i in range(0,len(dailypapers)):
        dailypaperids = dailypaperids + str(dailypapers[i].get("dailypaperid")) + ','
    dailypaperids =  dailypaperids[:-1]
    sql_total = "SELECT count(*) as total from ( "\
"select tb_dailypaper.dailypaperid from tb_dailypaper "\
"LEFT JOIN (select * from tb_dailypaper_user where tb_dailypaper_user.userid = %s) b "\
"on tb_dailypaper.dailypaperid = b.dailypaperid "\
"where tb_dailypaper.userid = %s  and b.userid is not null "\
"GROUP BY tb_dailypaper.dailypaperid "\
"ORDER BY tb_dailypaper.dailypaperdate desc,tb_dailypaper.createtime DESC) c"
    cursor.execute(sql_total,[receptionistid,writerid])
    total = dictfetchall(cursor)[0].get("total")

    sql_getusertype = "select * from auth_user where id = "+ writerid +" "
    cursor.execute(sql_getusertype)
    positiontype = dictfetchall(cursor)[0]["positiontype"]

    dailypaperdetails = None
    if positiontype == 1:
        sql_detail = "select tb_dailypaperdetail.*,tb_dict.typename,CONCAT(tb_project.projectname,'-' "\
        ",tb_projectschedule.schedulename) as projectname from tb_dailypaperdetail "\
        "LEFT JOIN tb_projectschedule "\
        "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
        "LEFT JOIN tb_project "\
        "on tb_project.projectid = tb_projectschedule.projectid "\
        "LEFT JOIN tb_dailypaper "\
        "on tb_dailypaper.dailypaperid = tb_dailypaperdetail.dailypaperid "\
        "LEFT JOIN tb_dict "\
        "on tb_dailypaperdetail.worktype = tb_dict.typeid "\
        "and tb_dict.type=9 "\
        "where tb_dailypaper.userid = %s "
        if dailypaperids != '':
            sql_detail = sql_detail + " and tb_dailypaper.dailypaperid in ("+dailypaperids+")"
        cursor.execute(sql_detail,[writerid])
        dailypaperdetails = dictfetchall(cursor)
    elif positiontype == 2:
        sql_detail = "select tb_dailypaperdetail_sale.*,tb_dict.typename,tb_business.businessname,tb_contact.contactname from tb_dailypaperdetail_sale "\
        "LEFT JOIN tb_business "\
        "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
        "LEFT JOIN tb_dailypaper "\
        "on tb_dailypaper.dailypaperid = tb_dailypaperdetail_sale.dailypaperid "\
        "LEFT JOIN tb_contact "\
        "on tb_contact.contactid = tb_dailypaperdetail_sale.contactid "\
        "LEFT JOIN tb_dict "\
        "on tb_dailypaperdetail_sale.worktype = tb_dict.typeid "\
        "and tb_dict.type=5 "\
        "where tb_dailypaper.userid = %s"
        if dailypaperids != '':
            sql_detail = sql_detail + " and tb_dailypaper.dailypaperid in ("+dailypaperids+")"
        cursor.execute(sql_detail,[writerid])
        dailypaperdetails = dictfetchall(cursor)
    returnjson = {
        'dailypapers':dailypapers,
        'positiontype':positiontype,
        'dailypaperdetails':dailypaperdetails,
        "total":total
    }

    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def readdailypaper_byid(request):
    dailypaperid = request.POST.get("dailypaperid")

    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    readuserid = dictfetchall(cursor)[0]["id"]

    TbDailypaperUser.objects.filter(Q(dailypaperid=int(dailypaperid)) & Q(userid=int(readuserid))).update(
            isread = 1,
            readtime = datetime.datetime.now()
            )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_worktypes(request):
    projectscheduleid = request.POST.get("projectscheduleid")

    cursor=connection.cursor()
    sql = "SELECT * FROM tb_projectschedule_worktype "\
"LEFT JOIN tb_dict "\
"on tb_projectschedule_worktype.typeid = tb_dict.typeid "\
"where tb_dict.type = 9 "\
"and projectscheduleid = %s"
    cursor.execute(sql,[projectscheduleid])
    worktypes = dictfetchall(cursor)

    return JsonResponse(worktypes, safe=False)

@api_view(['GET','POST'])
def readdailypaper_list(request):
    dailypaperids = request.POST.get("dailypaperids").split(',')

    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    readuserid = dictfetchall(cursor)[0]["id"]

    for i in range(0,len(dailypaperids)):
        TbDailypaperUser.objects.filter(Q(dailypaperid=int(dailypaperids[i])) & Q(userid=int(readuserid))).update(
            isread = 1,
            readtime = datetime.datetime.now()
            )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def read_dailypaperdetail(request):
    dailypaperid = request.POST.get("dailypaperid")

    cursor=connection.cursor()
    sql = "select * from ( "\
        "select tb_dailypaper.*,GROUP_CONCAT(auth_user.name) as receptionists from tb_dailypaper "\
        "LEFT JOIN tb_dailypaper_user "\
        "on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
        "LEFT JOIN auth_user "\
        "on tb_dailypaper_user.userid = auth_user.id "\
        "GROUP BY tb_dailypaper.dailypaperid) a "\
        "LEFT JOIN (select tb_dailypaperdetail.*,CONCAT(tb_project.projectname,'-',tb_projectschedule.schedulename)  "\
        "as projectname from tb_dailypaperdetail "\
        "LEFT JOIN tb_projectschedule "\
        "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
        "LEFT JOIN tb_project "\
        "on tb_projectschedule.projectid = tb_project.projectid) b "\
        "ON a.dailypaperid = b.dailypaperid "\
        "where a.dailypaperid = %s"
    cursor.execute(sql,[dailypaperid])
    dailypaper = dictfetchall(cursor)

    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    readuserid = dictfetchall(cursor)[0]["id"]

    TbDailypaperUser.objects.filter(Q(dailypaperid=int(dailypaperid)) & Q(userid=int(readuserid))).update(
            isread = 1,
            readtime = datetime.datetime.now()
            )
    return JsonResponse(dailypaper, safe=False)

@api_view(['GET','POST'])
def delete_dailypaper(request):
    dailypaperid = request.POST.get("dailypaperid")

    TbDailypaperUser.objects.filter(dailypaperid=dailypaperid).delete()
    TbDailypaperdetail.objects.filter(dailypaperid=dailypaperid).delete()
    TbDailypaper.objects.filter(dailypaperid=dailypaperid).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_dailypaperbyid(request):
    dailypaperid = request.POST.get("dailypaperid")

    cursor=connection.cursor()
    sql = "select * from ( "\
        "select tb_dailypaper.*,GROUP_CONCAT(auth_user.name) as receptionists,GROUP_CONCAT(auth_user.id) as receptionistids from tb_dailypaper "\
        "LEFT JOIN tb_dailypaper_user "\
        "on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
        "LEFT JOIN auth_user "\
        "on tb_dailypaper_user.userid = auth_user.id "\
        "GROUP BY tb_dailypaper.dailypaperid) a "\
        "LEFT JOIN (select tb_dailypaperdetail.*,CONCAT(tb_project.projectname,'-',tb_projectschedule.schedulename)  "\
        "as projectname from tb_dailypaperdetail "\
        "LEFT JOIN tb_projectschedule "\
        "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
        "LEFT JOIN tb_project "\
        "on tb_projectschedule.projectid = tb_project.projectid ) b "\
        "ON a.dailypaperid = b.dailypaperid "\
        "where a.dailypaperid = %s"
    cursor.execute(sql,[dailypaperid])
    dailypaper = dictfetchall(cursor)

    return JsonResponse(dailypaper, safe=False)

@api_view(['GET','POST'])
def edit_dailypaper(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    checkeduser = json_data.get("checkeduser")
    dailypaperdate = datetime.datetime.strptime(json_data.get("dailypaperdate").split("T")[0],'%Y-%m-%d')
    contents = json_data.get("tableData")
    updatetime = datetime.datetime.now()
    dailypaperid = json_data.get("dailypaperid")

    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sqldatecheck = "SELECT * FROM tb_dailypaper "\
    "where dailypaperdate = %s "\
    "and userid = %s"
    cursor.execute(sqldatecheck,[json_data.get("dailypaperdate").split("T")[0],userid])
    dp = dictfetchall(cursor)
    if len(dp)>0 and dp[0]["dailypaperid"] != dailypaperid:
        return HttpResponse("一天只能提交一个日报")

    TbDailypaper.objects.filter(dailypaperid=int(dailypaperid)).update(
            dailypaperdate = dailypaperdate,
            updatetime = updatetime
        )
    
    TbDailypaperUser.objects.filter(dailypaperid=dailypaperid).delete()
    for i in range(0,len(checkeduser)):
        TbDailypaperUser.objects.create(
            dailypaperid = dailypaperid,
            userid = checkeduser[i],
            isread = 0
        )
    
    TbDailypaperdetail.objects.filter(dailypaperid=dailypaperid).delete()
    for j in range(0,len(contents)):
        projectscheduleid = contents[j].get("projectscheduleid")
        worktime = contents[j].get("worktime")
        workcontent = contents[j].get("workcontent")
        worktype = contents[j].get("worktype")
        TbDailypaperdetail.objects.create(
            dailypaperid = dailypaperid,
            worktype = worktype,
            projectscheduleid = projectscheduleid,
            worktime = worktime,
            workcontent = workcontent
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_history(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    cursor=connection.cursor()
    sql = "select * from ( "\
        "select tb_dailypaper.*,GROUP_CONCAT(auth_user.name) as receptionists,GROUP_CONCAT(auth_user.id) as receptionistids from tb_dailypaper "\
        "LEFT JOIN tb_dailypaper_user "\
        "on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
        "LEFT JOIN auth_user "\
        "on tb_dailypaper_user.userid = auth_user.id "\
        "where auth_user.is_active = 1 "\
        "GROUP BY tb_dailypaper.dailypaperid) a "\
        "LEFT JOIN (select tb_dailypaperdetail.*,CONCAT(tb_project.projectname,'-',tb_projectschedule.schedulename)  "\
        "as projectschedulename from tb_dailypaperdetail "\
        "LEFT JOIN tb_projectschedule "\
        "on tb_dailypaperdetail.projectscheduleid = tb_projectschedule.projectscheduleid "\
        "LEFT JOIN tb_project "\
        "on tb_projectschedule.projectid = tb_project.projectid where tb_projectschedule.isdeleted = 0 or ISNULL(tb_projectschedule.isdeleted)) b "\
        "ON a.dailypaperid = b.dailypaperid "\
        "where a.dailypaperid  = (select dailypaperid from tb_dailypaper "\
        "where userid = %s "\
        "ORDER BY dailypaperdate desc "\
        "LIMIT 1)"
    cursor.execute(sql,[userid])
    dailypaper = dictfetchall(cursor)

    return JsonResponse(dailypaper, safe=False)

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