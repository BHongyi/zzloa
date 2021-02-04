<template>
  <div>
    <el-row>
      <el-button
        @click="
          dialogVisible = true;
          clearcreateuserform();
        "
        v-if="this.permissions.indexOf('000002') != -1"
        ><i class="el-icon-plus"></i>新建</el-button
      >
      <el-button
        type="danger"
        @click="deleteuser()"
        v-if="this.permissions.indexOf('000003') != -1"
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
      <el-table-column prop="name" label="姓名" width="180"> </el-table-column>
      <el-table-column prop="username" label="用户名" width="180">
      </el-table-column>
      <el-table-column prop="positiontype" label="岗位类别" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.positiontype == 1">开发岗</span>
          <span v-else-if="scope.row.positiontype == 2">销售岗</span>
          <span v-else-if="scope.row.positiontype == 3">管理岗</span>
          <span v-else>其他岗</span>
        </template>
      </el-table-column>
      <!-- <el-table-column prop="is_active" label="状态" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.is_active == 1" style="color:green;">已激活</span>
          <span v-else-if="scope.row.is_active == 0" style="color:red;">未激活</span>
          <span v-else>未激活</span>
        </template>
      </el-table-column> -->
      <el-table-column prop="phone" label="电话" width="180"> </el-table-column>
      <el-table-column prop="email" label="邮件" width="180"> </el-table-column>
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
        v-if="this.permissions.indexOf('000004') != -1"
        label="操作"
      >
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>修改</el-button
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
      title="新建用户"
      :visible.sync="dialogVisible"
      width="25%"
      :before-close="handleClose"
    >
      <el-form
        name="createuserform"
        :label-position="labelPosition"
        label-width="90px"
        :model="createformdata"
        ref="createuserform"
      >
        <el-form-item
          label="姓名"
          prop="name"
          :rules="[
            { required: true, message: '姓名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.name"></el-input>
        </el-form-item>
        <el-form-item
          label="用户名"
          prop="username"
          :rules="[
            { required: true, message: '用户名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.username"></el-input>
        </el-form-item>
        <el-form-item
          label="电话"
          prop="phone"
          :rules="[
            { required: true, message: '电话不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.phone"></el-input>
        </el-form-item>
        <el-form-item
          label="邮件"
          prop="email"
        >
          <el-input v-model="createformdata.email"></el-input>
        </el-form-item>
        <el-form-item
          label="岗位类别"
          prop="positiontype"
          :rules="[
            { required: true, message: '岗位类别不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.positiontype" placeholder="请选择">
            <el-option
              v-for="item in positiontypeData"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="角色"
          prop="roles"
        >
          <el-select v-model="createformdata.roles" multiple placeholder="请选择">
            <el-option
              v-for="item in roleData"
              :key="item.roleid"
              :label="item.rolename"
              :value="item.roleid"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createuser()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="编辑用户"
      :visible.sync="editDialogVisible"
      width="25%"
      :before-close="handleClose"
    >
      <el-form
        name="edituserform"
        :label-position="labelPosition"
        label-width="90px"
        :model="editformdata"
        ref="edituserform"
      >
        <el-form-item
          label="姓名"
          prop="name"
          :rules="[
            { required: true, message: '姓名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.name"></el-input>
        </el-form-item>
        <el-form-item
          label="电话"
          prop="phone"
          :rules="[
            { required: true, message: '电话不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.phone"></el-input>
        </el-form-item>
        <el-form-item
          label="邮件"
          prop="email"
        >
          <el-input v-model="editformdata.email"></el-input>
        </el-form-item>
        <el-form-item
          label="岗位类别"
          prop="positiontype"
          :rules="[
            { required: true, message: '岗位类别不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="editformdata.positiontype" placeholder="请选择">
            <el-option
              v-for="item in positiontypeData"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="角色"
          prop="roles"
        >
          <el-select v-model="editformdata.roles" multiple placeholder="请选择">
            <el-option
              v-for="item in roleData"
              :key="item.roleid"
              :label="item.rolename"
              :value="item.roleid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <!-- <el-form-item
          label="状态"
          prop="isactive"
        >
          <el-select v-model="editformdata.isactive" placeholder="请选择">
            <el-option label="已激活" value="1"></el-option>
            <el-option label="未激活" value="0"></el-option>
          </el-select>
        </el-form-item> -->
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="edituser()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";

export default {
  name: "UserManage",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      positiontypeData: [],
      roleData: [],
      dialogVisible: false,
      editDialogVisible: false,
      labelPosition: "right",
      multipleSelection: [],
      editformdata: {
        name: "",
        phone: "",
        email: "",
        isactive: 1,
        id: 0,
        positiontype: 0,
        roles: [],
      },
      createformdata: {
        name: "",
        username: "",
        phone: "",
        email: "",
        positiontype: null,
        roles: [],
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    //console.log(this.permissions);
    this.initusers(); //需要触发的函数
    this.positiontypes();
    this.initroles();
  },
  methods: {
    initusers() {
      axios({
        url: "usermanage/get_users/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
    },
    positiontypes() {
      axios({
        url: "usermanage/get_positiontypes/",
        method: "get",
        data: {},
      }).then((res) => {
        this.positiontypeData = res.data;
      });
    },
    initroles(){
      axios({
        url: "rolemanage/get_roles/",
        method: "get",
        data: {},
      }).then((res) => {
        this.roleData = res.data;
      });
    },
    filterTag(value, row) {
      return row.is_active === value;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleClick(row) {
      console.log(row);
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
    clearcreateuserform() {
      this.$refs["createuserform"].clearValidate();
      this.createformdata.name = "";
      this.createformdata.username = "";
      this.createformdata.phone = "";
      this.createformdata.email = "";
      this.createformdata.positiontype = null;
      this.createformdata.roles = [];
    },
    createuser() {
      this.$refs["createuserform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("name", this.createformdata.name);
          param.append("username", this.createformdata.username);
          param.append("phone", this.createformdata.phone);
          param.append("email", this.createformdata.email);
          param.append("positiontype", this.createformdata.positiontype);
          param.append("roles", this.createformdata.roles);

          axios({
            url: "usermanage/create_user/",
            method: "post",
            data: param,
          }).then((res) => {
            this.dialogVisible = false;
            this.initusers();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleteuser() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的用户");
      } else {
        this.$confirm("确认删除？")
          .then((_) => {
            let idarr = [];
            this.multipleSelection.forEach((element) => {
              idarr.push(element.id);
            });

            let param = new URLSearchParams();
            param.append("ids", idarr);
            axios({
              url: "usermanage/delete_user/",
              method: "post",
              data: param,
            }).then((res) => {
              this.initusers();
            });
          })
          .catch((_) => {
            return;
          });
      }
    },
    edituser() {
      this.$refs["edituserform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("name", this.editformdata.name);
          param.append("id", this.editformdata.id);
          param.append("phone", this.editformdata.phone);
          param.append("email", this.editformdata.email);
          param.append("isactive", this.editformdata.isactive);
          param.append("positiontype", this.editformdata.positiontype);
          param.append("roles", this.editformdata.roles);

          axios({
            url: "usermanage/edit_user/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initusers();
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
      param.append("id", row.id);
      axios({
        url: "usermanage/get_user_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editformdata.name = res.data[0].name;
        this.editformdata.email = res.data[0].email;
        this.editformdata.phone = res.data[0].phone;
        this.editformdata.isactive = res.data[0].is_active + "";
        this.editformdata.id = res.data[0].id;
        this.editformdata.positiontype = res.data[0].positiontype;
        this.editformdata.roles = [];
        res.data[0].roles.forEach(element => {
          this.editformdata.roles.push(element.roleid);
        });
      });
    },
  },
};
</script>