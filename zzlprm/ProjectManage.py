from django.shortcuts import render
from zzlprm.Common import dictfetchall
from zzlprm.models import TbProject
from zzlprm.models import TbProjectschedule
from zzlprm.models import TbProjectscheduleUser

from django.http import HttpResponse,JsonResponse
from django.db import connection
import datetime

from rest_framework.decorators import api_view

@api_view(['GET','POST'])
def get_projects(request):
    cursor=connection.cursor()
    sql = "select tb_project.*,tb_dict.typename projecttype from tb_project "\
"LEFT JOIN tb_dict "\
"on tb_project.typeid = tb_dict.dictid "\
"and tb_dict.type = 1 "\
"order by tb_project.updatetime desc"
    cursor.execute(sql)
    projects = dictfetchall(cursor)
    return JsonResponse(projects, safe=False)

@api_view(['GET','POST'])
def get_project_types(request):
    cursor=connection.cursor()
    sql = "select * from tb_dict "\
        "where type=1"
    cursor.execute(sql)
    project_types = dictfetchall(cursor)
    return JsonResponse(project_types, safe=False)

@api_view(['GET','POST'])
def create_project(request):
    projectname = request.POST.get("projectname")
    description = request.POST.get("description")
    projecttype = request.POST.get("projecttype")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    p = TbProject.objects.create(
            projectname = projectname,
            description = description,
            typeid = projecttype,
            createtime = createtime,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_project(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
        TbProjectschedule.objects.filter(projectid=delete_ids_list[i]).delete()
        TbProject.objects.filter(projectid=delete_ids_list[i]).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_project_byid(request):
    projectid = request.POST.get("projectid")

    cursor=connection.cursor()
    sql = "select * from tb_project "\
          "where projectid=%s"
    cursor.execute(sql,[projectid])
    project = dictfetchall(cursor)

    return JsonResponse(project, safe=False)

@api_view(['GET','POST'])
def edit_project(request):
    projectid = request.POST.get("projectid")
    projectname = request.POST.get("projectname")
    description = request.POST.get("description")
    projecttype = request.POST.get("projecttype")
    updatetime = datetime.datetime.now()

    TbProject.objects.filter(projectid=projectid).update(
            projectname = projectname,
            description = description,
            typeid = projecttype,
            updatetime = updatetime
        )
    
    return HttpResponse("OK")


@api_view(['GET','POST'])
def get_project_schedule(request):
    # projectid = request.POST.get("projectid")

    cursor=connection.cursor()
    sql = "select tb_projectschedule.*,tb_group.name as groupname,a.managername from tb_projectschedule "\
"LEFT JOIN tb_group "\
"on tb_projectschedule.groupid = tb_group.groupid "\
"LEFT JOIN (select tb_projectschedule_user.projectscheduleid,auth_user.name as managername from tb_projectschedule_user "\
"LEFT JOIN auth_user "\
"on tb_projectschedule_user.userid = auth_user.id "\
"where tb_projectschedule_user.ismanager = 1) a "\
"ON tb_projectschedule.projectscheduleid = a.projectscheduleid "\
"ORDER BY tb_projectschedule.schedulerealstartdate"
    cursor.execute(sql)
    projectschedule = dictfetchall(cursor)
    return JsonResponse(projectschedule, safe=False)

@api_view(['GET','POST'])
def create_project_schedule(request):
    projectid = request.POST.get("projectid")
    schedulename = request.POST.get("schedulename")
    scheduledescription = request.POST.get("scheduledescription")
    groupid = request.POST.get("groupid")
    managerid = request.POST.get("managerid")
    members = request.POST.get("members")
    schedulestartdate = datetime.datetime.strptime(request.POST.get("schedulestartdate").split("T")[0],'%Y-%m-%d')
    schedulefinishdate = datetime.datetime.strptime(request.POST.get("schedulefinishdate").split("T")[0],'%Y-%m-%d')
    preworkload = request.POST.get("preworkload")
    isfinished = 0
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    p = TbProjectschedule.objects.create(
            projectid = projectid,
            schedulename = schedulename,
            scheduledescription = scheduledescription,
            groupid = groupid,
            schedulestartdate = schedulestartdate,
            schedulefinishdate = schedulefinishdate,
            isfinished = isfinished,
            preworkload = preworkload,
            createtime = createtime,
            updatetime = updatetime
        )
    
    TbProjectscheduleUser.objects.create(
            projectscheduleid = p.pk,
            userid = managerid,
            ismanager = 1
        )
    
    member_ids_list = members.split(',')
    if member_ids_list[0] != '':
        for i in range(0,len(member_ids_list)):
            TbProjectscheduleUser.objects.create(
                projectscheduleid = p.pk,
                userid = member_ids_list[i],
                ismanager = 0
                )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_project_schedule_byid(request):
    projectscheduleid = request.POST.get("projectscheduleid")

    cursor=connection.cursor()
    sql = "select * from tb_projectschedule "\
          "where projectscheduleid=%s"
    cursor.execute(sql,[projectscheduleid])
    projectschedule = dictfetchall(cursor)

    sql1 = "select * from tb_projectschedule_user "\
          "where projectscheduleid=%s"
    cursor.execute(sql1,[projectscheduleid])
    users = dictfetchall(cursor)

    returnjson = {
        'projectschedule':projectschedule,
        'users':users
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def edit_project_schedule(request):
    projectscheduleid = request.POST.get("projectscheduleid")
    # projectid = request.POST.get("projectid")
    schedulename = request.POST.get("schedulename")
    scheduledescription = request.POST.get("scheduledescription")
    groupid = request.POST.get("groupid")
    managerid = request.POST.get("managerid")
    members = request.POST.get("members")
    schedulestartdate = request.POST.get("schedulestartdate")
    schedulefinishdate = request.POST.get("schedulefinishdate")
    schedulerealstartdate = request.POST.get("schedulerealstartdate")
    schedulerealfinishdate = request.POST.get("schedulerealfinishdate")
    preworkload = request.POST.get("preworkload")
    realworkload = request.POST.get("realworkload")
    isfinished = request.POST.get("isfinished")
    updatetime = datetime.datetime.now()

    if request.POST.get("realworkload") == 'null':
        realworkload = None

    if schedulestartdate == 'null':
        schedulestartdate = None
    
    if schedulefinishdate == 'null':
        schedulefinishdate = None

    if schedulerealstartdate == 'null':
        schedulerealstartdate = None

    if schedulerealfinishdate == 'null':
        schedulerealfinishdate = None

    TbProjectschedule.objects.filter(projectscheduleid=projectscheduleid).update(
        schedulename = schedulename,
        scheduledescription = scheduledescription,
        groupid = groupid,
        preworkload = preworkload,
        realworkload = realworkload,
        isfinished = isfinished,
        schedulestartdate = schedulestartdate,
        schedulefinishdate = schedulefinishdate,
        schedulerealstartdate = schedulerealstartdate,
        schedulerealfinishdate = schedulerealfinishdate,
        updatetime = updatetime
        )

    TbProjectscheduleUser.objects.filter(projectscheduleid=projectscheduleid).delete()
    TbProjectscheduleUser.objects.create(
            projectscheduleid = projectscheduleid,
            userid = managerid,
            ismanager = 1
        )
    
    member_ids_list = members.split(',')
    if member_ids_list[0] != '':
        for i in range(0,len(member_ids_list)):
            TbProjectscheduleUser.objects.create(
                projectscheduleid = projectscheduleid,
                userid = member_ids_list[i],
                ismanager = 0
                )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_project_schedule(request):
    projectscheduleid = request.POST.get("projectscheduleid")

    TbProjectscheduleUser.objects.filter(projectscheduleid=projectscheduleid).delete()
    TbProjectschedule.objects.filter(projectscheduleid=projectscheduleid).delete()

    return HttpResponse("OK")