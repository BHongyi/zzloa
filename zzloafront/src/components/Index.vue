<template>
  <el-container style="height: 100%">
    <!-- 页面顶部 -->
    <el-header
      ><img src="../assets/img/logo.png" style="width: 30px" />
      中智联项目管理系统
    </el-header>
    <el-container>
      <!-- 页面左侧菜单 -->
      <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
        <el-menu router>
          <!-- 开启菜单中的router=true之后，点击菜单会把index作为路由跳转路径 -->
          <el-menu-item
            index="usermanage"
            v-if="this.permissions.indexOf('000005') != -1"
          >
            <i class="el-icon-user"></i>用户管理
          </el-menu-item>
          <el-menu-item
            index="groupmanage"
            v-if="this.permissions.indexOf('000010') != -1"
          >
            <i class="el-icon-folder"></i>部门管理
          </el-menu-item>
          <el-menu-item
            index="permissionmanage"
            v-if="this.permissions.indexOf('000015') != -1"
          >
            <i class="el-icon-menu"></i>权限管理
          </el-menu-item>
          <el-menu-item
            index="rolemanage"
            v-if="this.permissions.indexOf('000020') != -1"
          >
            <i class="el-icon-user-solid"></i>角色管理
          </el-menu-item>
          <el-menu-item
            index="projectmanage"
            v-if="this.permissions.indexOf('000025') != -1"
          >
            <i class="el-icon-files"></i>项目管理
          </el-menu-item>
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-document"></i>
              <span>日报管理</span>
            </template>
            <el-menu-item index="dailypaper">
              <i class="el-icon-edit"></i>填写日报
            </el-menu-item>
            <el-menu-item index="readdailypaper">
              <i class="el-icon-view"></i>查看日报
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-main>
        <router-view :permissions="permissions"></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<style>
.el-header {
  background-color: #c1cbd8;
  color: #333;
  line-height: 60px;
}

.el-aside {
  color: #333;
}
</style>

<script>
export default {
  name: "Index",
  data() {
    return {
      permissions: "",
    };
  },
  mounted: function () {
    this.initpermissions();
  },
  methods: {
    initpermissions() {
      this.permissions = sessionStorage.getItem("permissions");
    },
  },
};
</script>