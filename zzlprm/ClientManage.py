from django.shortcuts import render
from zzlprm.models import TbClient
from zzlprm.models import TbContact
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
def get_clients(request):
    cursor=connection.cursor()
    sql = "select tb_client.clientid,tb_client.companyname "\
    ",tb_client.description,tb_client.phone "\
    ",auth_user.name as staff,tb_client.createtime "\
    ",tb_client.updatetime,tb_dict.typename as clienttype from tb_client "\
    "LEFT JOIN tb_dict "\
    "ON tb_client.clienttype = tb_dict.typeid "\
    "and tb_dict.type = 4 "\
    "LEFT JOIN auth_user "\
    "on tb_client.staff = auth_user.id "\
    "order by tb_client.updatetime desc"
    cursor.execute(sql)
    clients = dictfetchall(cursor)
    return JsonResponse(clients, safe=False)

@api_view(['GET','POST'])
def get_clienttypes(request):
    cursor=connection.cursor()
    sql = "select * from tb_dict "\
          "where type=4"
    cursor.execute(sql)
    types = dictfetchall(cursor)
    return JsonResponse(types, safe=False)

@api_view(['GET','POST'])
def create_client(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)
    companyname = json_data.get("companyname")
    clienttype = json_data.get("clienttype")
    staff = json_data.get("staff")
    owner = json_data.get("owner")
    scale = json_data.get("scale")
    profession = json_data.get("profession")
    website = json_data.get("website")
    fax = json_data.get("fax")
    email = json_data.get("email")
    address = json_data.get("address")
    phone = json_data.get("phone")
    description = json_data.get("description")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    TbClient.objects.create(
            companyname = companyname,
            clienttype = clienttype,
            staff = staff,
            owner = owner,
            scale = scale,
            profession = profession,
            website = website,
            fax = fax,
            email = email,
            address = address,
            phone = phone,
            description = description,
            createtime = createtime,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def edit_client(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)
    clientid = json_data.get("clientid")
    companyname = json_data.get("companyname")
    clienttype = json_data.get("clienttype")
    staff = json_data.get("staff")
    owner = json_data.get("owner")
    scale = json_data.get("scale")
    profession = json_data.get("profession")
    website = json_data.get("website")
    fax = json_data.get("fax")
    email = json_data.get("email")
    address = json_data.get("address")
    phone = json_data.get("phone")
    description = json_data.get("description")
    updatetime = datetime.datetime.now()

    TbClient.objects.filter(clientid=clientid).update(
            companyname = companyname,
            clienttype = clienttype,
            staff = staff,
            owner = owner,
            scale = scale,
            profession = profession,
            website = website,
            fax = fax,
            email = email,
            address = address,
            phone = phone,
            description = description,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_client(request):
    delete_ids = request.POST.get("ids")

    delete_ids_list = delete_ids.split(',')
    for i in range(0,len(delete_ids_list)):
        TbClient.objects.filter(clientid=delete_ids_list[i]).delete()

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_client_byid(request):
    clientid = request.POST.get("clientid")

    cursor=connection.cursor()
    sql = "select * from tb_client "\
          "where clientid=%s"
    cursor.execute(sql,[clientid])
    clients = dictfetchall(cursor)
    return JsonResponse(clients, safe=False)

@api_view(['GET','POST'])
def get_contacts(request):
    cursor=connection.cursor()
    sql = "select * from tb_contact "
    cursor.execute(sql)
    contacts = dictfetchall(cursor)
    return JsonResponse(contacts, safe=False)

@api_view(['GET','POST'])
def create_contact(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)
    clientid = json_data.get("clientid")
    contactname = json_data.get("contactname")
    position = json_data.get("position")
    description = json_data.get("description")
    ismanager = json_data.get("ismanager")
    phone = json_data.get("phone")
    telephone = json_data.get("telephone")
    email = json_data.get("email")
    wx = json_data.get("wx")
    fax = json_data.get("fax")
    sex = json_data.get("sex")
    age = json_data.get("age")
    createtime = datetime.datetime.now()
    updatetime = datetime.datetime.now()

    TbContact.objects.create(
            clientid = clientid,
            contactname = contactname,
            position = position,
            description = description,
            ismanager = ismanager,
            phone = phone,
            telephone = telephone,
            email = email,
            wx = wx,
            fax = fax,
            sex = sex,
            age = age,
            createtime = createtime,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def get_contact_byid(request):
    contactid = request.POST.get("contactid")

    cursor=connection.cursor()
    sql = "select * from tb_contact "\
          "where contactid=%s"
    cursor.execute(sql,[contactid])
    contacts = dictfetchall(cursor)
    return JsonResponse(contacts, safe=False)

@api_view(['GET','POST'])
def edit_contact(request):
    data = request.body.decode("utf-8")
    json_data = json.loads(data)
    contactid = json_data.get("contactid")
    clientid = json_data.get("clientid")
    contactname = json_data.get("contactname")
    position = json_data.get("position")
    description = json_data.get("description")
    ismanager = json_data.get("ismanager")
    phone = json_data.get("phone")
    telephone = json_data.get("telephone")
    email = json_data.get("email")
    wx = json_data.get("wx")
    fax = json_data.get("fax")
    sex = json_data.get("sex")
    age = json_data.get("age")
    updatetime = datetime.datetime.now()

    TbContact.objects.filter(contactid=contactid).update(
            clientid = clientid,
            contactname = contactname,
            position = position,
            description = description,
            ismanager = ismanager,
            phone = phone,
            telephone = telephone,
            email = email,
            wx = wx,
            fax = fax,
            sex = sex,
            age = age,
            updatetime = updatetime
        )

    return HttpResponse("OK")

@api_view(['GET','POST'])
def delete_contact(request):
    contactid = request.POST.get("contactid")
    TbContact.objects.filter(contactid=contactid).delete()
    return HttpResponse("OK")