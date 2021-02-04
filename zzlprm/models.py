# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30, blank=True, null=True)
    last_name = models.CharField(max_length=150, blank=True, null=True)
    email = models.CharField(max_length=254, blank=True, null=True)
    is_staff = models.IntegerField(blank=True, null=True)
    is_active = models.IntegerField()
    date_joined = models.DateTimeField(blank=True, null=True)
    name = models.CharField(max_length=30)
    phone = models.CharField(max_length=30)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    positiontype = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class AuthtokenToken(models.Model):
    key = models.CharField(primary_key=True, max_length=40)
    created = models.DateTimeField()
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'authtoken_token'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class TbAudit(models.Model):
    auditid = models.AutoField(primary_key=True)
    leaveid = models.IntegerField()
    flownodeid = models.IntegerField()
    userid = models.IntegerField()
    auditinfo = models.CharField(max_length=200, blank=True, null=True)
    audittime = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_audit'


class TbBusiness(models.Model):
    businessid = models.AutoField(primary_key=True)
    businessname = models.CharField(max_length=100)
    status = models.IntegerField()
    description = models.CharField(max_length=200, blank=True, null=True)
    possibility = models.FloatField(blank=True, null=True)
    budget = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    lossreason = models.CharField(max_length=200, blank=True, null=True)
    owner = models.IntegerField(blank=True, null=True)
    writer = models.IntegerField()
    finishtime = models.DateTimeField(blank=True, null=True)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    isdeleted = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_business'


class TbBusinessClient(models.Model):
    business_client_id = models.AutoField(primary_key=True)
    businessid = models.IntegerField()
    clientid = models.IntegerField()
    ismanager = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_business_client'


class TbBusinessContact(models.Model):
    business_contact_id = models.AutoField(primary_key=True)
    businessid = models.IntegerField()
    contactid = models.IntegerField()
    ismanager = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_business_contact'


class TbBusinessUser(models.Model):
    business_user_id = models.AutoField(primary_key=True)
    businessid = models.IntegerField()
    userid = models.IntegerField()
    ismanager = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_business_user'


class TbBusinessrecord(models.Model):
    businessrecordid = models.AutoField(primary_key=True)
    businessid = models.IntegerField()
    typeid = models.IntegerField()
    userid = models.IntegerField()
    createtime = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'tb_businessrecord'


class TbClient(models.Model):
    clientid = models.AutoField(primary_key=True)
    companyname = models.CharField(max_length=100)
    clienttype = models.IntegerField()
    staff = models.IntegerField()
    owner = models.CharField(max_length=50, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    scale = models.IntegerField(blank=True, null=True)
    profession = models.CharField(max_length=50, blank=True, null=True)
    website = models.CharField(max_length=100, blank=True, null=True)
    fax = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    address = models.CharField(max_length=200, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    isdeleted = models.IntegerField()
    source = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_client'


class TbContact(models.Model):
    contactid = models.AutoField(primary_key=True)
    contactname = models.CharField(max_length=50)
    position = models.CharField(max_length=50, blank=True, null=True)
    description = models.CharField(max_length=200, blank=True, null=True)
    clientid = models.IntegerField()
    ismanager = models.IntegerField()
    phone = models.CharField(max_length=50, blank=True, null=True)
    telephone = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    wx = models.CharField(max_length=50, blank=True, null=True)
    fax = models.CharField(max_length=50, blank=True, null=True)
    sex = models.CharField(max_length=10, blank=True, null=True)
    age = models.IntegerField(blank=True, null=True)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    isdeleted = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_contact'


class TbDailypaper(models.Model):
    dailypaperid = models.AutoField(primary_key=True)
    userid = models.IntegerField()
    dailypaperdate = models.DateTimeField()
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'tb_dailypaper'


class TbDailypaperUser(models.Model):
    dailypaper_user_id = models.AutoField(primary_key=True)
    dailypaperid = models.IntegerField()
    userid = models.IntegerField()
    isread = models.IntegerField()
    readtime = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_dailypaper_user'


class TbDailypaperdetail(models.Model):
    dailypaperdetailid = models.AutoField(primary_key=True)
    dailypaperid = models.IntegerField()
    projectscheduleid = models.IntegerField(blank=True, null=True)
    worktime = models.FloatField()
    workcontent = models.CharField(max_length=1000)

    class Meta:
        managed = False
        db_table = 'tb_dailypaperdetail'


class TbDailypaperdetailSale(models.Model):
    dailypaperdetail_saleid = models.AutoField(primary_key=True)
    dailypaperid = models.IntegerField()
    businessid = models.IntegerField(blank=True, null=True)
    cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    worktime = models.FloatField()
    workcontent = models.CharField(max_length=1000, blank=True, null=True)
    contactid = models.IntegerField(blank=True, null=True)
    isimportant = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_dailypaperdetail_sale'


class TbDict(models.Model):
    dictid = models.AutoField(primary_key=True)
    type = models.IntegerField()
    typeid = models.IntegerField()
    typename = models.CharField(max_length=50)
    order = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_dict'


class TbFlow(models.Model):
    flowid = models.AutoField(primary_key=True)
    flowno = models.IntegerField(unique=True)
    flowname = models.CharField(max_length=50)
    remark = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_flow'


class TbFlowline(models.Model):
    flowlineid = models.AutoField(primary_key=True)
    flowno = models.IntegerField()
    prevnodeid = models.IntegerField()
    nextnodeid = models.IntegerField()
    remark = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_flowline'


class TbFlownode(models.Model):
    flownodeid = models.AutoField(primary_key=True)
    flowno = models.IntegerField()
    flownodename = models.CharField(max_length=50)
    flownodetype = models.IntegerField()
    remark = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_flownode'


class TbFlownodeuser(models.Model):
    flownodeuserid = models.AutoField(primary_key=True)
    flownodename = models.CharField(max_length=50)
    userid = models.IntegerField()
    remark = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_flownodeuser'


class TbGroup(models.Model):
    groupid = models.AutoField(primary_key=True)
    parentid = models.IntegerField(blank=True, null=True)
    name = models.CharField(unique=True, max_length=150)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'tb_group'


class TbGroupUser(models.Model):
    group_user_id = models.AutoField(primary_key=True)
    userid = models.IntegerField()
    groupid = models.IntegerField()
    ismanager = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_group_user'


class TbLeave(models.Model):
    leaveid = models.AutoField(primary_key=True)
    userid = models.IntegerField()
    leavetype = models.IntegerField()
    leavereason = models.CharField(max_length=200)
    starttime = models.DateTimeField()
    finishtime = models.DateTimeField()
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    flowno = models.IntegerField()
    currentnode = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_leave'


class TbPermission(models.Model):
    permissionid = models.AutoField(primary_key=True)
    parentid = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=50)
    code = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'tb_permission'


class TbProject(models.Model):
    projectid = models.AutoField(primary_key=True)
    projectname = models.CharField(max_length=50)
    description = models.CharField(max_length=255, blank=True, null=True)
    typeid = models.IntegerField()
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    isdeleted = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_project'


class TbProjectschedule(models.Model):
    projectscheduleid = models.AutoField(primary_key=True)
    projectid = models.IntegerField()
    schedulename = models.CharField(max_length=50)
    scheduledescription = models.CharField(max_length=255, blank=True, null=True)
    groupid = models.IntegerField()
    preworkload = models.IntegerField()
    realworkload = models.IntegerField(blank=True, null=True)
    schedulestartdate = models.DateTimeField()
    schedulefinishdate = models.DateTimeField()
    schedulerealstartdate = models.DateTimeField(blank=True, null=True)
    schedulerealfinishdate = models.DateTimeField(blank=True, null=True)
    isfinished = models.IntegerField()
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()
    isdeleted = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_projectschedule'


class TbProjectscheduleUser(models.Model):
    projectschedule_user_id = models.AutoField(primary_key=True)
    projectscheduleid = models.IntegerField()
    userid = models.IntegerField()
    ismanager = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_projectschedule_user'


class TbRole(models.Model):
    roleid = models.AutoField(primary_key=True)
    rolename = models.CharField(max_length=50)
    createtime = models.DateTimeField()
    updatetime = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'tb_role'


class TbRolePermission(models.Model):
    role_permission_id = models.AutoField(primary_key=True)
    roleid = models.IntegerField()
    permissionid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_role_permission'


class TbUserRole(models.Model):
    user_role_id = models.AutoField(primary_key=True)
    userid = models.IntegerField()
    roleid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'tb_user_role'
