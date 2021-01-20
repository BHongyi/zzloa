<template>
  <div>
    <el-row>
      <el-button
        @click="dialogVisible = true"
        v-if="this.permissions.indexOf('000017') != -1"
        ><i class="el-icon-plus"></i>新建</el-button
      >
      <el-button
        type="danger"
        @click="deleterole()"
        v-if="this.permissions.indexOf('000018') != -1"
        ><i class="el-icon-delete"></i>删除</el-button
      >
    </el-row>
    <el-table
      :data="
        tableData.slice(
          (limitePage.page - 1) * limitePage.limit,
          limitePage.limit * limitePage.page
        )
      "
      style="width: 100%"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55"> </el-table-column>
      <el-table-column prop="rolename" label="角色名" width="180">
      </el-table-column>
      <el-table-column prop="createtime" label="创建日期" width="180">
        <template slot-scope="scope">{{
          scope.row.createtime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="updatetime" label="更新日期" width="180">
        <template slot-scope="scope">{{
          scope.row.updatetime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column
        v-if="this.permissions.indexOf('000019') != -1"
        label="操作"
      >
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>修改角色</el-button
          >
          <el-button
            size="mini"
            @click="handleEditPermission(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>修改权限</el-button
          >
          <el-button
            size="mini"
            @click="handleEditUser(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>编辑人员</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <div class="block">
      <span class="demonstration"></span>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="limitePage.page"
        :page-sizes="[5, 10, 20]"
        :page-size="limitePage.limit"
        layout="total, sizes, prev, pager, next, jumper"
        :total="tableData.length"
      >
      </el-pagination>
    </div>

    <el-dialog
      title="新建角色"
      :visible.sync="dialogVisible"
      width="25%"
      :before-close="handleClose"
    >
      <el-form
        name="createroleform"
        ref="createroleform"
        :label-position="labelPosition"
        label-width="80px"
        :model="createformdata"
      >
        <el-form-item
          label="角色名"
          prop="rolename"
          :rules="[
            { required: true, message: '权限名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.rolename"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createrole()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="编辑角色" :visible.sync="editDialogVisible" width="25%">
      <el-form
        name="editroleform"
        ref="editroleform"
        :label-position="labelPosition"
        label-width="80px"
        :model="editformdata"
      >
        <el-form-item
          label="角色名"
          prop="rolename"
          :rules="[
            { required: true, message: '权限名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.rolename"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editrole()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="修改权限"
      :visible.sync="editPermissionDialogVisible"
      width="25%"
    >
      <el-tree
        style="width: 100%"
        :data="treeData"
        node-key="permissionid"
        ref="tree"
        default-expand-all
        show-checkbox
        :expand-on-click-node="false"
        @check-change="handleCheckChange"
      >
      </el-tree>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editPermissionDialogVisible = false"
          >取 消</el-button
        >
        <el-button type="primary" @click="editpermission()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="编辑人员"
      :visible.sync="editUserDialogVisible"
      width="15%"
    >
      <div style="width: 100%; height: 240px; overflow-y: auto">
        <el-table
          :data="treeUserData"
          ref="multipleTable"
          @selection-change="handleUserSelectionChange"
        >
          <el-table-column column-key="id" type="selection" width="55">
          </el-table-column>
          <el-table-column prop="name" label="姓名"> </el-table-column>
        </el-table>
      </div>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editUserDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editroleuser()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";

export default {
  name: "RoleManage",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      treeData: [],
      treeUserData: [],
      dialogVisible: false,
      editDialogVisible: false,
      editPermissionDialogVisible: false,
      editUserDialogVisible: false,
      labelPosition: "right",
      multipleSelection: [],
      multipleUserSelection: [],
      mutipleUserSelected: [],
      permissionSelection: [],
      currentroleid: 0,
      firstloadtree: 0,
      editformdata: {
        rolename: "",
        roleid: 0,
      },
      createformdata: {
        rolename: "",
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initroles(); //需要触发的函数
    this.initpermissions();
    this.initusers();
  },
  methods: {
    initroles() {
      axios({
        url: "rolemanage/get_roles/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
    },
    initpermissions() {
      axios({
        url: "permissionmanage/get_permissions/",
        method: "get",
        data: {},
      }).then((res) => {
        this.treeData = res.data.children;
      });
    },
    initusers() {
      axios({
        url: "usermanage/get_users/",
        method: "get",
        data: {},
      }).then((res) => {
        this.treeUserData = res.data;
      });
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleClose(done) {
      done();
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleUserSelectionChange(val) {
      this.multipleUserSelection = val;
    },
    createrole() {
      this.$refs["createroleform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("rolename", this.createformdata.rolename);

          axios({
            url: "rolemanage/create_role/",
            method: "post",
            data: param,
          }).then((res) => {
            this.dialogVisible = false;
            this.initroles();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleterole() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的角色");
      } else {
        this.$confirm("确认删除？")
          .then((_) => {
            let idarr = [];
            this.multipleSelection.forEach((element) => {
              idarr.push(element.roleid);
            });

            let param = new URLSearchParams();
            param.append("ids", idarr);
            axios({
              url: "rolemanage/delete_role/",
              method: "post",
              data: param,
            }).then((res) => {
              this.initroles();
            });
          })
          .catch((_) => {
            return;
          });
      }
    },
    editrole() {
      this.$refs["editroleform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("rolename", this.editformdata.rolename);
          param.append("roleid", this.editformdata.roleid);
          axios({
            url: "rolemanage/edit_role/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initroles();
            this.editDialogVisible = false;
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    handleEdit(index, row) {
      this.editDialogVisible = true;
      let param = new URLSearchParams();
      param.append("roleid", row.roleid);
      axios({
        url: "rolemanage/get_role_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editformdata.roleid = res.data[0].roleid;
        this.editformdata.rolename = res.data[0].rolename;
      });
    },
    handleEditPermission(index, row) {
      this.editPermissionDialogVisible = true;
      this.currentroleid = row.roleid;
      this.permissionSelection = undefined;
      this.permissionSelection = new Array();
      let param = new URLSearchParams();
      param.append("roleid", row.roleid);
      axios({
        url: "rolemanage/get_role_permission/",
        method: "post",
        data: param,
      }).then((res) => {
        this.$refs.tree.setCheckedKeys([]);
        res.data.forEach((element) => {
          this.permissionSelection.push(element.permissionid);
          this.$refs.tree.setChecked(element.permissionid, true);
        });
      });
    },
    editpermission() {
      let param = new URLSearchParams();
      param.append("roleid", this.currentroleid);
      param.append("permissionid", this.$refs.tree.getCheckedKeys());
      axios({
        url: "rolemanage/edit_role_permission/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editPermissionDialogVisible = false;
      });
    },
    handleCheckChange(data, checked, indeterminate) {
      if (checked) {
        this.permissionSelection.push(data.permissionid);
      } else {
        for (var i; i < this.permissionSelection.length; i++) {
          if (this.permissionSelection[i] == data.permissionid) {
            this.permissionSelection.splice(i, 1);
            return;
          }
        }
      }
    },
    handleEditUser(index, row) {
      this.editUserDialogVisible = true;
      this.currentroleid = row.roleid;
      let param = new URLSearchParams();
      param.append("roleid", this.currentroleid);
      axios({
        url: "rolemanage/get_user_role/",
        method: "post",
        data: param,
      }).then((res) => {
        this.$refs.multipleTable.clearSelection();
        res.data.forEach((element) => {
          this.multipleUserSelection.push(element);
          this.treeUserData.forEach((element1) => {
            if (element.id == element1.id) {
              this.$nextTick(() => {
                this.$refs.multipleTable.toggleRowSelection(element1);
              });
            }
          });
        });
      });
    },
    editroleuser() {
      var users = [];
      this.multipleUserSelection.forEach((element) => {
        users.push(element.id);
      });
      let param = new URLSearchParams();
      param.append("roleid", this.currentroleid);
      param.append("userid", users);
      axios({
        url: "rolemanage/edit_role_user/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editUserDialogVisible = false;
      });
    },
  },
};
</script>