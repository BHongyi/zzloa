<template>
  <div>
    <el-row>
      <el-button @click="editPasswordDialogVisible = true"
        ><i class="el-icon-edit"></i>修改密码</el-button
      >
    </el-row>

    <el-dialog
      title="修改密码"
      :visible.sync="editPasswordDialogVisible"
      width="25%"
    >
      <el-form
        name="editpasswordform"
        label-position="left"
        label-width="100px"
        :model="editpasswordformdata"
        ref="editpasswordform"
      >
        <el-form-item
          label="旧密码"
          prop="oldpassword"
          :rules="[
            { required: true, message: '旧密码不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editpasswordformdata.oldpassword"></el-input>
        </el-form-item>
        <el-form-item
          label="新密码"
          prop="newpassword"
          :rules="[
            { required: true, message: '新密码不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editpasswordformdata.newpassword"></el-input>
        </el-form-item>
        <el-form-item
          label="重复新密码"
          prop="newpasswordagain"
          :rules="rules.repassword"
        >
          <el-input v-model="editpasswordformdata.newpasswordagain"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editPasswordDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editpassword()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "PersonalPage",
  data() {
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
        // password 是表单上绑定的字段
      } else if (value !== this.editpasswordformdata.newpassword) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      editPasswordDialogVisible: false,
      editpasswordformdata: {
        oldpassword: "",
        newpassword: "",
        newpasswordagain: "",
      },
      rules: {
        repassword: [
          { required: true, validator: validatePass2, trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    editpassword() {
      this.$refs["editpasswordform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("oldpassword", this.editpasswordformdata.oldpassword);
          param.append("newpassword", this.editpasswordformdata.newpassword);
          param.append(
            "newpasswordagain",
            this.editpasswordformdata.newpasswordagain
          );
          axios({
            url: "personalpage/edit_password/",
            method: "post",
            data: param,
          }).then((res) => {
            if (res.data == "旧密码不正确") {
              alert("旧密码不正确");
            } else {
              this.editPasswordDialogVisible = false;
              this.$message("修改成功");
            }
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
  },
};
</script>