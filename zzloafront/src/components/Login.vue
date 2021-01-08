<template>
  <div style="text-align: center; width: 100%;">
    <el-form id="loginform" :style="loginfromstyle">
      <h1 style="font-family:宋体;">中智联项目管理系统</h1>
      <el-form-item label="">
        <el-input
          type="text"
          v-model="loginfrom.username"
          placeholder="请输入用户名"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input
          type="password"
          placeholder="请输入密码"
          v-model="loginfrom.password"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-checkbox v-model="remember" class="rememberme">记住密码</el-checkbox>
      <el-form-item>
        <el-button type="primary" style="width: 100%" @click="doSubmit()"
          >登录</el-button
        >
      </el-form-item>
    </el-form>
  </div>
</template>
<style>
label.el-checkbox.rememberme {
    margin: 0px 0px 15px 0px;
    text-align: left;
}
.el-dialog__body{
  display: inline-block;
}
</style>
<script>
import axios from "../utils/httpRequest";
import CryptoJS from "crypto-js";
export default {
  name: "Login",
  data() {
    return {
      loginfrom: {
        username: null,
        password: null,
      },
      marginleft:300,
      loginfromstyle:{
        width:"300px",
        marginTop:"100px",
        marginLeft:"400px"
      },
      remember:true,
      token: "",
    };
  },
  mounted(){
    this.loginfromstyle.marginLeft = window.innerWidth/2 - 150 + "px";
  },
  created(){ 
    if (localStorage.getItem("rememberPsw") == 'true') {
      this.getCookie();
      }
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
          sessionStorage.setItem("positiontype", res.data.positiontype);
          if(this.remember){
            this.setCookie(this.loginfrom.username,this.loginfrom.password,7);
          }
          else{
            this.clearCookie();
          }
          localStorage.setItem("rememberPsw", this.remember);
          this.$router.push({path:"index"})
        }
      });
    },
    //设置cookie
    setCookie(portId, psw, exdays) {
      // Encrypt，加密账号密码
      var cipherPortId = CryptoJS.AES.encrypt(
        portId+'',
        "secretkey123"
      ).toString();
      var cipherPsw = CryptoJS.AES.encrypt(psw+'', "secretkey123").toString();
      //console.log(cipherPortId+'/'+cipherPsw)//打印一下看看有没有加密成功

      var exdate = new Date(); //获取时间
      exdate.setTime(exdate.getTime() + 24 * 60 * 60 * 1000 * exdays); //保存的天数
      //字符串拼接cookie，为什么这里用了==，因为加密后的字符串也有个=号，影响下面getcookie的字符串切割，你也可以使用更炫酷的符号。
      window.document.cookie =
        "currentPortId" +
        "==" +
        cipherPortId +
        ";path=/;expires=" +
        exdate.toGMTString();
      window.document.cookie =
        "password" +
        "==" +
        cipherPsw +
        ";path=/;expires=" +
        exdate.toGMTString();
    },
    //读取cookie
    getCookie: function() {
      if (document.cookie.length > 0) {
        var arr = document.cookie.split("; "); //这里显示的格式请根据自己的代码更改
        for (var i = 0; i < arr.length; i++) {
          var arr2 = arr[i].split("=="); //根据==切割
          //判断查找相对应的值
          if (arr2[0] == "currentPortId") {
            // Decrypt，将解密后的内容赋值给账号
            var bytes = CryptoJS.AES.decrypt(arr2[1], "secretkey123");
            this.loginfrom.username = bytes.toString(CryptoJS.enc.Utf8);
          } else if (arr2[0] == "password") {
            // Decrypt，将解密后的内容赋值给密码
            var bytes = CryptoJS.AES.decrypt(arr2[1], "secretkey123");
            this.loginfrom.password = bytes.toString(CryptoJS.enc.Utf8);
          }
        }
      }
    },
    //清除cookie
    clearCookie: function() {
      this.setCookie("", "", -1); 
    }
  },
};
</script>