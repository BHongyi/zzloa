from django.shortcuts import render
from zzlprm.Common import dictfetchall
from zzlprm.models import TbProject
from zzlprm.models import TbProjectUser
from zzlprm.models import TbProjectschedule

from django.http import HttpResponse,JsonResponse
from django.db import connection
import datetime

from rest_framework.decorators import api_view

# Create your views here.
@api_view(['GET','POST'])
def get_projects(request):
    cursor=connection.cursor()
    sql = "select tb_project.*,tb_group.name as groupname,tb_dict.typename from tb_project "\
        "LEFT JOIN tb_group "\
        "on tb_project.groupid = tb_group.groupid "\
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
    groupid = request.POST.get("groupid")
    managerid = request.POST.get("managerid")
    members = request.POST.get("members")
    isfinished = 0
    preworkload = request.POST.get("preworkload")
    prestarttime = datetime.datetime.strptime(request.POST.get("prestarttime"),'%Y-%m-%d')
    prefinishtime = datetime.datetime.strptime(request.POST.get("prefinishtime"),'%Y-%m-%d')
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    p = TbProject.objects.create(
            projectname = projectname,
            description = description,
            typeid = projecttype,
            groupid = groupid,
            prestarttime = prestarttime,
            prefinishtime = prefinishtime,
            isfinished = isfinished,
            preworkload = preworkload,
            createtime = createtime,
            updatetime = updatetime
        )

    TbProjectUser.objects.create(
            projectid = p.pk,
            userid = managerid,
            ismanager = 1
        )
    
    member_ids_list = members.split(',')
    if member_ids_list[0] != '':
        for i in range(0,len(member_ids_list)):
            TbProjectUser.objects.create(
                projectid = p.pk,
                userid = member_ids_list[i],
                ismanager = 0
                )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_project(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
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

    sql1 = "select * from tb_project_user "\
          "where projectid=%s"
    cursor.execute(sql1,[projectid])
    users = dictfetchall(cursor)

    returnjson = {
        'project':project,
        'users':users
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def edit_project(request):
    projectid = request.POST.get("projectid")
    projectname = request.POST.get("projectname")
    description = request.POST.get("description")
    projecttype = request.POST.get("projecttype")
    groupid = request.POST.get("groupid")
    managerid = request.POST.get("managerid")
    members = request.POST.get("members")
    preworkload = request.POST.get("preworkload")
    realworkload = request.POST.get("realworkload")
    isfinished = request.POST.get("isfinished")

    if request.POST.get("realworkload") != 'null':
        realworkload = request.POST.get("realworkload")
    else:
        realworkload = None

    if request.POST.get("prestarttime") != 'null':
        prestarttime = datetime.datetime.strptime(request.POST.get("prestarttime").split("T")[0],'%Y-%m-%d')
    else:
        prestarttime = None
    
    if request.POST.get("prefinishtime") != 'null':
        prefinishtime = datetime.datetime.strptime(request.POST.get("prefinishtime").split("T")[0],'%Y-%m-%d')
    else:
        prefinishtime = None

    if request.POST.get("realstarttime") != 'null':
        realstarttime = datetime.datetime.strptime(request.POST.get("realstarttime").split("T")[0],'%Y-%m-%d')
    else:
        realstarttime = None

    if request.POST.get("realfinishtime") != 'null':
        realfinishtime = datetime.datetime.strptime(request.POST.get("realfinishtime").split("T")[0],'%Y-%m-%d')
    else:
        realfinishtime = None

    updatetime = datetime.datetime.now()

    TbProject.objects.filter(projectid=projectid).update(
            projectname = projectname,
            description = description,
            typeid = projecttype,
            groupid = groupid,
            prestarttime = prestarttime,
            prefinishtime = prefinishtime,
            realstarttime = realstarttime,
            realfinishtime = realfinishtime,
            preworkload = preworkload,
            realworkload = realworkload,
            isfinished = isfinished,
            updatetime = updatetime
        )
    
    TbProjectUser.objects.filter(projectid=projectid).delete()
    TbProjectUser.objects.create(
            projectid = projectid,
            userid = managerid,
            ismanager = 1
        )
    
    member_ids_list = members.split(',')
    if member_ids_list[0] != '':
        for i in range(0,len(member_ids_list)):
            TbProjectUser.objects.create(
                projectid = projectid,
                userid = member_ids_list[i],
                ismanager = 0
                )
    return HttpResponse("OK")


@api_view(['GET','POST'])
def get_project_schedule(request):
    projectid = request.POST.get("projectid")

    cursor=connection.cursor()
    sql = "select * from tb_projectschedule "\
          "where projectid=%s order by schedulestartdate"
    cursor.execute(sql,[projectid])
    projectschedule = dictfetchall(cursor)
    return JsonResponse(projectschedule, safe=False)

@api_view(['GET','POST'])
def create_project_schedule(request):
    projectid = request.POST.get("projectid")
    schedulename = request.POST.get("schedulename")
    schedulestartdate = request.POST.get("schedulestartdate")
    schedulefinishdate = request.POST.get("schedulefinishdate")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    TbProjectschedule.objects.create(
            projectid = projectid,
            schedulename = schedulename,
            schedulestartdate = schedulestartdate,
            schedulefinishdate = schedulefinishdate,
            createtime = createtime,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def edit_project_schedule(request):
    projectscheduleid = request.POST.get("projectscheduleid")
    schedulename = request.POST.get("schedulename")
    schedulestartdate = request.POST.get("schedulestartdate")
    schedulefinishdate = request.POST.get("schedulefinishdate")
    updatetime = datetime.datetime.now()

    TbProjectschedule.objects.filter(projectscheduleid=projectscheduleid).update(
        schedulename = schedulename,
        schedulestartdate = schedulestartdate,
        schedulefinishdate = schedulefinishdate,
        updatetime = updatetime
        )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_project_schedule(request):
    delete_id = request.POST.get("projectscheduleid")

    TbProjectschedule.objects.filter(projectscheduleid=delete_id).delete()

    return HttpResponse("OK")