from django.shortcuts import render
from zzlprm.models import TbBusiness
from zzlprm.models import TbBusinessClient
from zzlprm.models import TbBusinessContact
from zzlprm.models import TbBusinessUser
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
    cursor=connection.cursor()
    sql = "select b.*,tb_business_user.userid as managerid from ( "\
"SELECT a.*,GROUP_CONCAT(tb_contact.contactname) as contacts from ( "\
"select tb_business.*,GROUP_CONCAT(tb_client.companyname) as companyname from tb_business "\
"LEFT JOIN tb_business_client "\
"on tb_business.businessid = tb_business_client.businessid "\
"LEFT JOIN tb_client "\
"on tb_business_client.clientid = tb_client.clientid "\
"GROUP BY businessid) a "\
"LEFT JOIN tb_business_contact "\
"on a.businessid = tb_business_contact.businessid "\
"LEFT JOIN tb_contact "\
"on tb_business_contact.contactid = tb_contact.contactid "\
"GROUP BY a.businessid) b "\
"LEFT JOIN tb_business_user "\
"on b.businessid = tb_business_user.businessid "\
"where tb_business_user.ismanager = 1 "\
"order by b.updatetime desc"
    cursor.execute(sql)
    businesses = dictfetchall(cursor)
    return JsonResponse(businesses, safe=False)

@api_view(['GET','POST'])
def get_statuses(request):
    cursor=connection.cursor()
    sql = "SELECT * from tb_dict where type = 3 "
    cursor.execute(sql)
    statuses = dictfetchall(cursor)
    return JsonResponse(statuses, safe=False)

@api_view(['GET','POST'])
def create_business(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    TbBusiness.objects.create(
            businessname = json_data.get("businessname"),
            status = json_data.get("status"),
            description = json_data.get("description"),
            possibility = json_data.get("possibility"),
            budget = json_data.get("budget"),
            owner = json_data.get("owner"),
            writer = userid,
            createtime = datetime.datetime.now(),
            updatetime = datetime.datetime.now()
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

    returnjson = {
        'business':business,
        'business_client':business_client,
        'business_contact':business_contact,
        'business_user':business_user
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
    "where tb_contact.clientid in ("+clientlist+") "
    cursor.execute(sql)
    contacts = dictfetchall(cursor)
    return JsonResponse(contacts, safe=False)

@api_view(['GET','POST'])
def edit_business(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)

    TbBusiness.objects.filter(businessid=json_data.get("businessid")).update(
            businessname = json_data.get("businessname"),
            status = json_data.get("status"),
            description = json_data.get("description"),
            possibility = json_data.get("possibility"),
            budget = json_data.get("budget"),
            owner = json_data.get("owner"),
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
    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_business(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
        TbBusiness.objects.filter(businessid=delete_ids_list[i]).delete()
        TbBusinessClient.objects.filter(businessid=delete_ids_list[i]).delete()
        TbBusinessContact.objects.filter(businessid=delete_ids_list[i]).delete()
        TbBusinessUser.objects.filter(businessid=delete_ids_list[i]).delete()

    return HttpResponse("OK")