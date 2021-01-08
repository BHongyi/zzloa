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
    email = models.CharField(max_length=254)
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


class TbDict(models.Model):
    dictid = models.AutoField(primary_key=True)
    type = models.IntegerField()
    typeid = models.IntegerField()
    typename = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'tb_dict'


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
