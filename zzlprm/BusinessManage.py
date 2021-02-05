from django.shortcuts import render
from zzlprm.models import TbBusiness
from zzlprm.models import TbBusinessClient
from zzlprm.models import TbBusinessContact
from zzlprm.models import TbBusinessUser
from zzlprm.models import TbBusinessrecord
from zzlprm.models import TbBusinessWorktype
from zzlprm.models import TbProject
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
def get_businesses(request):
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "select b.*,c.userid as managerid from ( "\
"SELECT a.*,GROUP_CONCAT(tb_contact.contactname) as contacts from ( "\
"select tb_business.*,GROUP_CONCAT(tb_client.companyname) as companyname from tb_business "\
"LEFT JOIN tb_business_client "\
"on tb_business.businessid = tb_business_client.businessid "\
"LEFT JOIN tb_client "\
"on tb_business_client.clientid = tb_client.clientid where tb_business.isdeleted=0 "\
"GROUP BY businessid) a "\
"LEFT JOIN tb_business_contact "\
"on a.businessid = tb_business_contact.businessid "\
"LEFT JOIN tb_contact "\
"on tb_business_contact.contactid = tb_contact.contactid "\
"GROUP BY a.businessid) b "\
"LEFT JOIN (select * from tb_business_user "\
"where ismanager=1) c "\
"on b.businessid = c.businessid "
    if userid != 1:#商机超级管理员
        sql = sql + "where b.businessid in (select businessid from tb_business_user "\
            "where userid = "+str(userid)+" "\
            "GROUP BY businessid) or b.owner="+str(userid)+" "
    sql = sql + "GROUP BY b.businessid "\
        "order by b.updatetime desc"
    cursor.execute(sql)
    businesses = dictfetchall(cursor)

    sqlrecord = "select tb_businessrecord.*,tb_dict.typename "\
",auth_user.name as uname from tb_businessrecord "\
"LEFT JOIN tb_dict "\
"on tb_businessrecord.typeid = tb_dict.typeid "\
"LEFT JOIN auth_user "\
"on auth_user.id = tb_businessrecord.userid "\
"where tb_dict.type = 3"
    cursor.execute(sqlrecord)
    businesserecord = dictfetchall(cursor)

    sqlimportantrecord = "select tb_dailypaperdetail_sale.*,tb_dailypaper.dailypaperdate "\
",auth_user.name as writer from tb_dailypaperdetail_sale "\
"LEFT JOIN tb_dailypaper "\
"on tb_dailypaperdetail_sale.dailypaperid = tb_dailypaper.dailypaperid "\
"LEFT JOIN auth_user "\
"on auth_user.id = tb_dailypaper.userid "\
"where isimportant=1"
    cursor.execute(sqlimportantrecord)
    importantrecord = dictfetchall(cursor)

    returnjson = {
        'businesses':businesses,
        'businessrecord':businesserecord,
        'importantrecord':importantrecord
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def get_statuses(request):
    cursor=connection.cursor()
    sql = "SELECT * from tb_dict where type = 3 order by tb_dict.order "
    cursor.execute(sql)
    statuses = dictfetchall(cursor)
    return JsonResponse(statuses, safe=False)

@api_view(['GET','POST'])
def get_business_worktypes(request):
    cursor=connection.cursor()
    sql = "select * from tb_dict "\
        "where type=5 order by tb_dict.order "
    cursor.execute(sql)
    work_types = dictfetchall(cursor)
    return JsonResponse(work_types, safe=False)

@api_view(['GET','POST'])
def create_business(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    b = TbBusiness.objects.create(
        businessname = json_data.get("businessname"),
        status = json_data.get("status"),
        description = json_data.get("description"),
        possibility = json_data.get("possibility"),
        budget = json_data.get("budget"),
        owner = userid, #填报人就是所有人
        writer = userid,
        createtime = datetime.datetime.now(),
        updatetime = datetime.datetime.now(),
        isdeleted=0
        )
    
    TbBusinessrecord.objects.create(
        businessid = b.pk,
        typeid = json_data.get("status"),
        userid = userid,
        createtime = datetime.datetime.now(),
        )

    worktype_ids_list = json_data.get("worktypes")
    if worktype_ids_list[0] != '':
        for i in range(0,len(worktype_ids_list)):
            TbBusinessWorktype.objects.create(
                businessid = b.pk,
                typeid = worktype_ids_list[i]
                )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_business_byid(request):
    businessid = request.POST.get("businessid")

    cursor=connection.cursor()
    sql = "select * from tb_business "\
          "where businessid=%s"
    cursor.execute(sql,[businessid])
    business = dictfetchall(cursor)

    sql_client = "select clientid from tb_business_client "\
          "where businessid=%s"
    cursor.execute(sql_client,[businessid])
    business_client = dictfetchall(cursor)

    sql_contact = "select contactid from tb_business_contact "\
          "where businessid=%s"
    cursor.execute(sql_contact,[businessid])
    business_contact = dictfetchall(cursor)

    sql_user = "select userid,ismanager from tb_business_user "\
          "where businessid=%s"
    cursor.execute(sql_user,[businessid])
    business_user = dictfetchall(cursor)

    sql_worktype = "select businessid,typeid as worktype from tb_business_worktype "\
          "where businessid=%s"
    cursor.execute(sql_worktype,[businessid])
    business_worktype = dictfetchall(cursor)

    returnjson = {
        'business':business,
        'business_client':business_client,
        'business_contact':business_contact,
        'business_user':business_user,
        'business_worktype':business_worktype
    }
    return JsonResponse(returnjson, safe=False)

@api_view(['GET','POST'])
def get_contacts(request):
    clientlist = request.POST.get("clientlist")

    cursor=connection.cursor()
    sql = "select tb_contact.contactid "\
    ",CONCAT(tb_contact.contactname,'-',tb_client.companyname) "\
    "as contactname from tb_contact "\
    "LEFT JOIN tb_client "\
    "on tb_contact.clientid = tb_client.clientid "\
    "where tb_contact.isdeleted=0 and tb_contact.clientid in ("+clientlist+") "
    cursor.execute(sql)
    contacts = dictfetchall(cursor)
    return JsonResponse(contacts, safe=False)

@api_view(['GET','POST'])
def edit_business(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    cursor=connection.cursor()
    sqlbusiness = "select * from tb_business where businessid = "+ str(json_data.get("businessid")) +" "
    cursor.execute(sqlbusiness)
    business = dictfetchall(cursor)[0]
    if business.get("status") != json_data.get("status"):
        username = request.user.username
        sqlu = "select * from auth_user where username = '"+ username +"' "
        cursor.execute(sqlu)
        userid = dictfetchall(cursor)[0]["id"]
        TbBusinessrecord.objects.create(
            businessid = json_data.get("businessid"),
            typeid = json_data.get("status"),
            userid = userid,
            createtime = datetime.datetime.now(),
        )
        
    TbBusiness.objects.filter(businessid=json_data.get("businessid")).update(
            businessname = json_data.get("businessname"),
            status = json_data.get("status"),
            description = json_data.get("description"),
            possibility = json_data.get("possibility"),
            budget = json_data.get("budget"),
            # owner = json_data.get("owner"),
            updatetime = datetime.datetime.now()
        )

    clientlist = json_data.get("clientlist")
    contactlist = json_data.get("contactlist")

    TbBusinessClient.objects.filter(businessid=json_data.get("businessid")).delete()
    for i in range(0,len(clientlist)):
            TbBusinessClient.objects.create(
                businessid = json_data.get("businessid"),
                clientid = clientlist[i],
                ismanager = 0
                )

    TbBusinessContact.objects.filter(businessid=json_data.get("businessid")).delete()
    for i in range(0,len(contactlist)):
            TbBusinessContact.objects.create(
                businessid = json_data.get("businessid"),
                contactid = contactlist[i],
                ismanager = 0
                )
    
    managerid = json_data.get("managerid")
    members = json_data.get("members")

    TbBusinessUser.objects.filter(businessid=json_data.get("businessid")).delete()
    if managerid != None:
        TbBusinessUser.objects.create(
            businessid = json_data.get("businessid"),
            userid = managerid,
            ismanager = 1
            )
    
    if members != None:
        for i in range(0,len(members)):
            TbBusinessUser.objects.create(
                businessid = json_data.get("businessid"),
                userid = members[i],
                ismanager = 0
                )
    
    TbBusinessWorktype.objects.filter(businessid=json_data.get("businessid")).delete()
    worktype_ids_list = json_data.get("worktypes")
    if worktype_ids_list[0] != '':
        for i in range(0,len(worktype_ids_list)):
            TbBusinessWorktype.objects.create(
                businessid = json_data.get("businessid"),
                typeid = worktype_ids_list[i]
                )
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_business(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
        TbBusiness.objects.filter(businessid=delete_ids_list[i]).update(
            isdeleted = 1
            )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def end_business(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    status = json_data.get("status")
    transtoproject = json_data.get("transtoproject")
    businessid = json_data.get("businessid")
    lossreason = json_data.get("lossreason")
    projectname = json_data.get("projectname")
    projecttype = json_data.get("projecttype")
    description = json_data.get("description")
    tempstatus = None
    if status == "0":
        tempstatus = 5
        TbBusiness.objects.filter(businessid=json_data.get("businessid")).update(
            status = 5,
            lossreason = lossreason,
            finishtime = datetime.datetime.now(),
            updatetime = datetime.datetime.now()
        )
    else:
        tempstatus = 4
        TbBusiness.objects.filter(businessid=json_data.get("businessid")).update(
            status = 4,
            finishtime = datetime.datetime.now(),
            updatetime = datetime.datetime.now()
        )
        if transtoproject == "1":
            TbProject.objects.create(
                projectname = projectname,
                description = description,
                typeid = projecttype,
                createtime = datetime.datetime.now(),
                updatetime = datetime.datetime.now()
                )
    
    username = request.user.username
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    TbBusinessrecord.objects.create(
        businessid = businessid,
        typeid = tempstatus,
        userid = userid,
        createtime = datetime.datetime.now(),
        )
    return HttpResponse("OK")