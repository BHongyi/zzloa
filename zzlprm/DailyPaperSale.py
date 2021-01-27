from django.http import HttpResponse,JsonResponse
from zzlprm.Common import dictfetchall
from django.db import connection
from django.db.models import Q
from rest_framework.decorators import api_view
from zzlprm.models import TbDailypaper
from zzlprm.models import TbDailypaperdetailSale
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

    sql = "select tb_dailypaperdetail_sale.*,tb_business.businessname,tb_contact.contactname from tb_dailypaperdetail_sale "\
    "LEFT JOIN tb_business "\
    "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
    "LEFT JOIN tb_dailypaper "\
    "on tb_dailypaper.dailypaperid = tb_dailypaperdetail_sale.dailypaperid "\
    "LEFT JOIN tb_contact "\
    "on tb_contact.contactid = tb_dailypaperdetail_sale.contactid "\
    "where tb_dailypaper.userid = %s"
    cursor.execute(sql,[userid])
    dailypaperdetails = dictfetchall(cursor)

    sql1 = "select a.*,b.receptionists as readreceptionists from ( "\
        "select tb_dailypaper.*,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
        "LEFT JOIN tb_dailypaper_user "\
        "on tb_dailypaper.dailypaperid = tb_dailypaper_user.dailypaperid "\
        "LEFT JOIN auth_user "\
        "on tb_dailypaper_user.userid = auth_user.id "\
        "where tb_dailypaper.userid =  "+str(userid)+" "\
        "GROUP BY tb_dailypaper.dailypaperid "\
        "ORDER BY tb_dailypaper.dailypaperdate desc) a "\
        "LEFT JOIN (select tb_dailypaper.*,group_concat(auth_user.name) as receptionists from tb_dailypaper "\
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
        'threedayago':threedayago
    }
    return JsonResponse(returnjson, safe=False)

def prev_weekday(adate):
    adate -= timedelta(days=1)
    while adate.weekday() > 4: # Mon-Fri are 0-4
        adate -= timedelta(days=1)
    return adate

@api_view(['GET','POST'])
def get_businesses(request):
    username = request.user.username
    
    cursor=connection.cursor()
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    userid = dictfetchall(cursor)[0]["id"]

    sql = "SELECT * from (select tb_business.businessname "\
    ",tb_business.businessid from tb_business "\
    "LEFT JOIN tb_business_user "\
    "on tb_business.businessid = tb_business_user.businessid "\
    "LEFT JOIN auth_user "\
    "on auth_user.id = tb_business_user.userid "\
    "where tb_business.status <> 4 and  tb_business.status <> 5 "\
    "and auth_user.id = %s and tb_business.isdeleted=0) a "\
    "group by a.businessid"
    cursor.execute(sql,[userid])
    businesses = dictfetchall(cursor)

    return JsonResponse(businesses, safe=False)

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

    businessids = request.POST.get("businessids").split(',')
    sql1 = ""
    if businessids[0] != "":
        sql1 = "select userid from tb_business_user "\
        "where ismanager = 1 and ("
        for businessid in businessids:
            sql1 = sql1 + "businessid = "+ businessid +" or "
    
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

def get_contacts(request):
    businessid = request.POST.get("businessid")

    cursor=connection.cursor()
    sql = "select tb_contact.contactid,tb_contact.contactname from tb_business "\
    "LEFT JOIN tb_business_contact "\
    "on tb_business.businessid = tb_business_contact.businessid "\
    "LEFT JOIN tb_contact "\
    "on tb_business_contact.contactid = tb_contact.contactid "\
    "where tb_business.businessid = %s and tb_contact.isdeleted=0 "\
    "GROUP BY tb_contact.contactid"
    cursor.execute(sql,[businessid])
    contacts = dictfetchall(cursor)

    return JsonResponse(contacts, safe=False)

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
        businessid = contents[j].get("businessid")
        worktime = contents[j].get("worktime")
        workcontent = contents[j].get("workcontent")
        cost = contents[j].get("cost")
        if cost == '':
            cost = None
        contactid = contents[j].get("contactid")
        TbDailypaperdetailSale.objects.create(
            dailypaperid = d.pk,
            businessid = businessid,
            worktime = worktime,
            cost = cost,
            contactid = contactid,
            workcontent = workcontent
        )
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
        "LEFT JOIN ( "\
        "select tb_dailypaperdetail_sale.*,tb_business.businessname  "\
        "from tb_dailypaperdetail_sale "\
        "LEFT JOIN tb_business "\
        "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
        ") b "\
        "ON a.dailypaperid = b.dailypaperid  "\
        "where a.dailypaperid = %s"
    cursor.execute(sql,[dailypaperid])
    dailypaper = dictfetchall(cursor)

    return JsonResponse(dailypaper, safe=False)

@api_view(['GET','POST'])
def delete_dailypaper(request):
    dailypaperid = request.POST.get("dailypaperid")

    TbDailypaperUser.objects.filter(dailypaperid=dailypaperid).delete()
    TbDailypaperdetailSale.objects.filter(dailypaperid=dailypaperid).delete()
    TbDailypaper.objects.filter(dailypaperid=dailypaperid).delete()

    return HttpResponse("OK")

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
    
    TbDailypaperdetailSale.objects.filter(dailypaperid=dailypaperid).delete()
    for j in range(0,len(contents)):
        businessid = contents[j].get("businessid")
        worktime = contents[j].get("worktime")
        workcontent = contents[j].get("workcontent")
        cost = contents[j].get("cost")
        if cost == '':
            cost = None
        contactid = contents[j].get("contactid")
        TbDailypaperdetailSale.objects.create(
            dailypaperid = dailypaperid,
            businessid = businessid,
            worktime = worktime,
            workcontent = workcontent,
            cost = cost,
            contactid = contactid
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
    "LEFT JOIN (select tb_dailypaperdetail_sale.*,tb_business.businessname,tb_contact.contactname "\
    "from tb_dailypaperdetail_sale "\
    "LEFT JOIN tb_business "\
    "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
    "LEFT JOIN tb_contact "\
    "on tb_dailypaperdetail_sale.contactid = tb_contact.contactid ) b "\
    "ON a.dailypaperid = b.dailypaperid "\
    "where a.dailypaperid = %s"
    cursor.execute(sql,[dailypaperid])
    dailypaper = dictfetchall(cursor)

    username = request.user.username
    sqlu = "select * from auth_user where username = '"+ username +"' "
    cursor.execute(sqlu)
    readuserid = dictfetchall(cursor)[0]["id"]

    TbDailypaperUser.objects.filter(Q(dailypaperid=int(dailypaperid)) & Q(userid=int(readuserid))).update(
            isread = 1,
            readtime = datetime.datetime.now()
            )
    return JsonResponse(dailypaper, safe=False)

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
        "LEFT JOIN ( "\
        "select tb_dailypaperdetail_sale.*,tb_business.businessname  "\
        "from tb_dailypaperdetail_sale "\
        "LEFT JOIN tb_business "\
        "on tb_dailypaperdetail_sale.businessid = tb_business.businessid "\
        ") b "\
        "ON a.dailypaperid = b.dailypaperid "\
        "where a.dailypaperid = (select dailypaperid from tb_dailypaper "\
        "where userid = %s "\
        "ORDER BY dailypaperdate desc "\
        "LIMIT 1)"
    cursor.execute(sql,[userid])
    dailypaper = dictfetchall(cursor)

    return JsonResponse(dailypaper, safe=False)