<template>
  <div style="text-align: center; width: 100%">
    <el-form style="width: 300px; margin-left: 300px">
      <h1 class="title">用户登录</h1>
      <el-form-item label="">
        <el-input
          type="text"
          v-model="loginfrom.username"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input
          type="password"
          v-model="loginfrom.password"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" style="width: 100%" @click="doSubmit()"
          >登录</el-button
        >
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import axios from "../utils/httpRequest";
export default {
  name: "Login",
  data() {
    return {
      loginfrom: {
        username: "admin",
        password: "123456",
      },
      token: "",
    };
  },
  methods: {
    doSubmit() {
      let param = new URLSearchParams();
      param.append("username", this.loginfrom.username);
      param.append("password", this.loginfrom.password);
      axios({
        url: "login/login/",
        //  url: "api-token-auth/",
        method: "post",
        data: param,
      }).then((res) => {
        if (res.data == "账号密码不正确") {
          alert("账号密码不正确");
        } else {
          sessionStorage.setItem("token", res.data.token);
          var permission = "";
          res.data.permissions.forEach(element => {
            permission = permission + ',' + element.code
          });
          sessionStorage.setItem("permissions", permission);
          this.$router.push({path:"index"})
        }
      });
    },
  },
};
</script>