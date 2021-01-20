<template>
  <div>
    <span style="font-size: 14px; color: darkgrey"
      >*新建权限后需修改保存才可以新建</span
    >
    <el-tree
      style="width: 35%"
      :data="treeData"
      node-key="id"
      default-expand-all
      :expand-on-click-node="false"
      :render-content="renderContent"
    >
    </el-tree>
    <el-dialog title="权限编辑" :visible.sync="dialogVisible" width="25%">
      <el-form
        name="editpermissionform"
        ref="editpermissionform"
        label-width="80px"
        :model="editformdata"
      >
        <el-form-item
          label="权限名"
          prop="name"
          :rules="[
            { required: true, message: '权限名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.name"></el-input>
        </el-form-item>
        <el-form-item
          label="code"
          prop="code"
          :rules="[
            { required: true, message: '权限code不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.code"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editpermission()">保 存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-right: 8px;
}
</style>

<script>
import axios from "../utils/httpRequest";

export default {
  name: "PermissionManage",
  data() {
    return {
      treeData: [],
      editformdata: {
        parentid: "",
        name: "",
        id: 0,
        code: "",
      },
      dialogVisible: false,
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initpermissions();
  },
  methods: {
    initpermissions() {
      axios({
        url: "permissionmanage/get_permissions/",
        method: "get",
        data: {},
      }).then((res) => {
        this.treeData = res.data.children;
      });
    },
    append(data) {
      const newChild = {
        label: "新建权限",
        name: "新建权限",
        code: "999999",
        parentid: data.permissionid,
        children: [],
      };
      if (!data.children) {
        this.$set(data, "children", []);
      }
      data.children.push(newChild);
    },
    edit(data) {
      this.dialogVisible = true;
      this.editformdata.name = data.name;
      this.editformdata.id = data.permissionid;
      this.editformdata.parentid = data.parentid;
      this.editformdata.code = data.code;
    },
    editpermission() {
      this.$refs["editpermissionform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("permissionid", this.editformdata.id);
          param.append("name", this.editformdata.name);
          param.append("parentid", this.editformdata.parentid);
          param.append("code", this.editformdata.code);

          axios({
            url: "permissionmanage/edit_permission/",
            method: "post",
            data: param,
          })
            .then((res) => {
              this.dialogVisible = false;
              this.initpermissions();
            })
            .catch(function (error) {
              alert("重复code,请更换");
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    remove(node, data) {
      this.$confirm("确认删除？")
        .then((_) => {
          let param = new URLSearchParams();
          param.append("permissionid", data.permissionid);
          axios({
            url: "permissionmanage/delete_permission/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initpermissions();
          });
        })
        .catch((_) => {
          return;
        });
    },
    renderContent(h, { node, data, store }) {
      return (
        <span class="custom-tree-node">
          <span>{node.label}</span>
          <span>
            <el-button
              size="mini"
              type="text"
              v-show={this.permissions.indexOf("000012") != -1 ? "ok" : ""}
              on-click={() => this.append(data)}
            >
              <i class="el-icon-circle-plus-outline"></i>
            </el-button>
            <el-button
              size="mini"
              v-show={this.permissions.indexOf("000014") != -1 ? "ok" : ""}
              type="text"
              on-click={() => this.edit(data)}
            >
              <i class="el-icon-edit"></i>
            </el-button>
            <el-button
              size="mini"
              type="text"
              v-show={this.permissions.indexOf("000013") != -1 & node.level != 1 ? "ok" : ""}
              on-click={() => this.remove(node, data)}
            >
              <i class="el-icon-delete"></i>
            </el-button>
          </span>
        </span>
      );
    },
  },
};
</script>