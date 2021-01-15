<template>
  <div>
    <el-row>
      <el-button
        @click="
          dialogVisible = true;
          clearcreateclientform();
        "
        v-if="this.permissions.indexOf('000027') != -1"
        ><i class="el-icon-plus"></i>新建客户</el-button
      >
      <el-button type="danger" @click="deleteclient()"
      v-if="this.permissions.indexOf('000028') != -1"
        ><i class="el-icon-delete"></i>删除客户</el-button
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
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-table
            :data="
              tableContactData.filter((f) => f.clientid == props.row.clientid)
            "
            stripe
            style="width: 100%"
            :row-class-name="tableRowClassName"
          >
            <el-table-column fixed type="index" width="20"> </el-table-column>
            <el-table-column
              prop="contactname"
              label="联系人名"
              fixed
              width="100"
            >
            </el-table-column>
            <el-table-column prop="position" label="职务" width="100" fixed>
            </el-table-column>
            <el-table-column prop="phone" label="手机" width="100" fixed>
            </el-table-column>
            <el-table-column prop="telephone" label="座机" width="100">
            </el-table-column>
            <el-table-column prop="email" label="邮箱" width="100">
            </el-table-column>
            <el-table-column prop="wx" label="微信号" width="100">
            </el-table-column>
            <el-table-column prop="fax" label="传真" width="100">
            </el-table-column>
            <el-table-column prop="ismanager" label="主要联系人" width="100">
              <template slot-scope="scope">
                <span v-if="scope.row.ismanager == 0">否</span>
                <span v-else-if="scope.row.ismanager == 1">是</span>
              </template>
            </el-table-column>
            <el-table-column prop="sex" label="性别" width="100">
            </el-table-column>
            <el-table-column prop="age" label="年龄" width="100">
            </el-table-column>
            <el-table-column prop="description" label="描述" width="100">
            </el-table-column>
            <el-table-column prop="createtime" width="110" label="创建时间">
              <template slot-scope="scope">{{
                scope.row.createtime | dateYMDHMSFormat
              }}</template>
            </el-table-column>
            <el-table-column prop="updatetime" width="110" label="更新时间">
              <template slot-scope="scope">{{
                scope.row.updatetime | dateYMDHMSFormat
              }}</template>
            </el-table-column>
            <el-table-column label="操作" width="245" fixed="right">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  @click="handleContactEdit(scope.$index, scope.row)"
                  ><i class="el-icon-edit"></i>修改联系人</el-button
                >
                <el-button
                  type="danger"
                  size="mini"
                  @click="deletecontact(scope.$index, scope.row)"
                  ><i class="el-icon-delete"></i>删除联系人</el-button
                >
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column prop="companyname" label="公司名" width="180">
      </el-table-column>
      <el-table-column prop="clienttype" label="用户类型" width="180">
      </el-table-column>
      <el-table-column prop="description" label="客户描述" width="180">
      </el-table-column>
      <el-table-column prop="phone" label="联系电话" width="180">
      </el-table-column>
      <el-table-column prop="staff" label="我方负责人" width="180">
      </el-table-column>
      <el-table-column prop="createtime" label="创建日期" width="120">
        <template slot-scope="scope">{{
          scope.row.createtime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="updatetime" label="更新日期" width="120">
        <template slot-scope="scope">{{
          scope.row.updatetime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column v-if="this.permissions.indexOf('000029') != -1" label="操作">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>修改客户</el-button
          >
          <el-button
            size="mini"
            @click="handleContactAdd(scope.$index, scope.row)"
            ><i class="el-icon-plus"></i>添加联系人</el-button
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

    <el-dialog title="新建客户" :visible.sync="dialogVisible" width="25%">
      <el-form
        name="createclientform"
        :label-position="labelPosition"
        label-width="90px"
        :model="createformdata"
        ref="createclientform"
      >
        <el-form-item
          label="公司名"
          prop="companyname"
          :rules="[
            { required: true, message: '公司名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.companyname"></el-input>
        </el-form-item>
        <el-form-item
          label="客户类别"
          prop="clienttype"
          :rules="[
            { required: true, message: '客户类别不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.clienttype" placeholder="请选择">
            <el-option
              v-for="item in clienttypeData"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="客户担当"
          prop="staff"
          :rules="[
            { required: true, message: '客户担当不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.staff" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="createformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="公司法人" prop="owner">
          <el-input v-model="createformdata.owner"></el-input>
        </el-form-item>
        <el-form-item label="公司规模" prop="scale">
          <el-input v-model="createformdata.scale"></el-input>
        </el-form-item>
        <el-form-item label="行业" prop="profession">
          <el-input v-model="createformdata.profession"></el-input>
        </el-form-item>
        <el-form-item label="网站" prop="website">
          <el-input v-model="createformdata.website"></el-input>
        </el-form-item>
        <el-form-item label="传真" prop="fax">
          <el-input v-model="createformdata.fax"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="createformdata.phone"></el-input>
        </el-form-item>
        <el-form-item label="邮件" prop="email">
          <el-input v-model="createformdata.email"></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="createformdata.address"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createclient()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="编辑客户" :visible.sync="editDialogVisible" width="25%">
      <el-form
        name="editclientform"
        :label-position="labelPosition"
        label-width="90px"
        :model="editformdata"
        ref="editclientform"
      >
        <el-form-item
          label="公司名"
          prop="companyname"
          :rules="[
            { required: true, message: '公司名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.companyname"></el-input>
        </el-form-item>
        <el-form-item
          label="客户类别"
          prop="clienttype"
          :rules="[
            { required: true, message: '客户类别不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="editformdata.clienttype" placeholder="请选择">
            <el-option
              v-for="item in clienttypeData"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="客户担当"
          prop="staff"
          :rules="[
            { required: true, message: '客户担当不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="editformdata.staff" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="editformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="公司法人" prop="owner">
          <el-input v-model="editformdata.owner"></el-input>
        </el-form-item>
        <el-form-item label="公司规模" prop="scale">
          <el-input v-model="editformdata.scale"></el-input>
        </el-form-item>
        <el-form-item label="行业" prop="profession">
          <el-input v-model="editformdata.profession"></el-input>
        </el-form-item>
        <el-form-item label="网站" prop="website">
          <el-input v-model="editformdata.website"></el-input>
        </el-form-item>
        <el-form-item label="传真" prop="fax">
          <el-input v-model="editformdata.fax"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="editformdata.phone"></el-input>
        </el-form-item>
        <el-form-item label="邮件" prop="email">
          <el-input v-model="editformdata.email"></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="editformdata.address"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editclient()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="新建联系人"
      :visible.sync="addContactDialogVisible"
      width="25%"
    >
      <el-form
        name="createcontactform"
        :label-position="labelPosition"
        label-width="90px"
        :model="createcontactformdata"
        ref="createcontactform"
      >
        <el-form-item
          label="姓名"
          prop="contactname"
          :rules="[
            { required: true, message: '姓名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createcontactformdata.contactname"></el-input>
        </el-form-item>
        <el-form-item label="职位" prop="position">
          <el-input v-model="createcontactformdata.position"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="phone">
          <el-input v-model="createcontactformdata.phone"></el-input>
        </el-form-item>
        <el-form-item label="座机" prop="telephone">
          <el-input v-model="createcontactformdata.telephone"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="createcontactformdata.email"></el-input>
        </el-form-item>
        <el-form-item label="微信号" prop="wx">
          <el-input v-model="createcontactformdata.wx"></el-input>
        </el-form-item>
        <el-form-item label="传真" prop="fax">
          <el-input v-model="createcontactformdata.fax"></el-input>
        </el-form-item>
        <el-form-item label="主要联系人" prop="sex">
          <el-select
            v-model="createcontactformdata.ismanager"
            placeholder="请选择"
          >
            <el-option label="否" value="0"></el-option>
            <el-option label="是" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="createcontactformdata.sex" placeholder="请选择">
            <el-option label="男" value="男"></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
          <el-input v-model="createcontactformdata.age"></el-input>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="createcontactformdata.description"
          ></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="addContactDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createcontact()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="修改联系人"
      :visible.sync="editContactDialogVisible"
      width="25%"
    >
      <el-form
        name="editcontactform"
        :label-position="labelPosition"
        label-width="90px"
        :model="editcontactformdata"
        ref="editcontactform"
      >
        <el-form-item
          label="姓名"
          prop="contactname"
          :rules="[
            { required: true, message: '姓名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editcontactformdata.contactname"></el-input>
        </el-form-item>
        <el-form-item label="职位" prop="position">
          <el-input v-model="editcontactformdata.position"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="phone">
          <el-input v-model="editcontactformdata.phone"></el-input>
        </el-form-item>
        <el-form-item label="座机" prop="telephone">
          <el-input v-model="editcontactformdata.telephone"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="editcontactformdata.email"></el-input>
        </el-form-item>
        <el-form-item label="微信号" prop="wx">
          <el-input v-model="editcontactformdata.wx"></el-input>
        </el-form-item>
        <el-form-item label="传真" prop="fax">
          <el-input v-model="editcontactformdata.fax"></el-input>
        </el-form-item>
        <el-form-item label="主要联系人" prop="sex">
          <el-select
            v-model="editcontactformdata.ismanager"
            placeholder="请选择"
          >
            <el-option label="否" value="0"></el-option>
            <el-option label="是" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="editcontactformdata.sex" placeholder="请选择">
            <el-option label="男" value="男"></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
          <el-input v-model="editcontactformdata.age"></el-input>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="editcontactformdata.description"
          ></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editContactDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editcontact()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
.el-table .success-row {
  background: #f0f9eb !important;
}
</style>

<script>
import axios from "../utils/httpRequest";

export default {
  name: "ClientManage",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      tableContactData: [],
      clienttypeData: [],
      userlist: [],
      dialogVisible: false,
      editDialogVisible: false,
      addContactDialogVisible: false,
      editContactDialogVisible: false,
      labelPosition: "right",
      multipleSelection: [],
      editformdata: {
        clientid: null,
        companyname: "",
        description: "",
        clienttype: null,
        staff: null,
        owner: "",
        scale: null,
        profession: "",
        website: "",
        fax: "",
        email: "",
        address: "",
        phone: "",
      },
      createformdata: {
        companyname: "",
        description: "",
        clienttype: null,
        staff: null,
        owner: "",
        scale: null,
        profession: "",
        website: "",
        fax: "",
        email: "",
        address: "",
        phone: "",
      },
      createcontactformdata: {
        clientid: null,
        contactname: "",
        position: "",
        description: "",
        ismanager: "0",
        phone: "",
        telephone: "",
        email: "",
        wx: "",
        fax: "",
        sex: "",
        age: null,
      },
      editcontactformdata: {
        contactid: null,
        clientid: null,
        contactname: "",
        position: "",
        description: "",
        ismanager: "0",
        phone: "",
        telephone: "",
        email: "",
        wx: "",
        fax: "",
        sex: "",
        age: null,
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initclients(); //需要触发的函数
    this.clienttypes();
    this.inituserlist();
    this.initContact();
  },
  methods: {
    initclients() {
      axios({
        url: "clientmanage/get_clients/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
    },
    clienttypes() {
      axios({
        url: "clientmanage/get_clienttypes/",
        method: "get",
        data: {},
      }).then((res) => {
        this.clienttypeData = res.data;
      });
    },
    inituserlist() {
      axios({
        url: "usermanage/get_users/",
        method: "get",
        data: {},
      }).then((res) => {
        this.userlist = res.data;
      });
    },
    initContact() {
      axios({
        url: "clientmanage/get_contacts/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableContactData = res.data;
      });
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    clearcreateclientform() {
      this.$refs["createclientform"].clearValidate();
      this.createformdata.companyname = "";
      this.createformdata.description = "";
      this.createformdata.clienttype = null;
      this.createformdata.staff = null;
      this.createformdata.owner = "";
      this.createformdata.scale = null;
      this.createformdata.profession = "";
      this.createformdata.website = "";
      this.createformdata.fax = "";
      this.createformdata.email = "";
      this.createformdata.address = "";
      this.createformdata.phone = "";
    },
    createclient() {
      this.$refs["createclientform"].validate((valid) => {
        if (valid) {
          axios({
            url: "clientmanage/create_client/",
            method: "post",
            data: this.createformdata,
          }).then((res) => {
            this.dialogVisible = false;
            this.initclients();
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
      param.append("clientid", row.clientid);
      axios({
        url: "clientmanage/get_client_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editformdata = res.data[0];
      });
    },
    editclient() {
      this.$refs["editclientform"].validate((valid) => {
        if (valid) {
          axios({
            url: "clientmanage/edit_client/",
            method: "post",
            data: this.editformdata,
          }).then((res) => {
            this.initclients();
            this.editDialogVisible = false;
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleteclient() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的客户");
      } else {
        this.$confirm("确认删除？")
          .then((_) => {
            let idarr = [];
            this.multipleSelection.forEach((element) => {
              idarr.push(element.clientid);
            });

            let param = new URLSearchParams();
            param.append("ids", idarr);
            axios({
              url: "clientmanage/delete_client/",
              method: "post",
              data: param,
            }).then((res) => {
              this.initclients();
            });
          })
          .catch((_) => {
            return;
          });
      }
    },
    handleContactAdd(index, row) {
      this.addContactDialogVisible = true;
      this.createcontactformdata.clientid = row.clientid;
      this.clearcreatecontactform();
    },
    clearcreatecontactform() {
      this.$refs["createcontactform"].clearValidate();
      this.createcontactformdata.clientid = null;
      this.createcontactformdata.contactname = "";
      this.createcontactformdata.position = null;
      this.createcontactformdata.description = null;
      this.createcontactformdata.ismanager = "0";
      this.createcontactformdata.phone = null;
      this.createcontactformdata.telephone = "";
      this.createcontactformdata.email = "";
      this.createcontactformdata.wx = "";
      this.createcontactformdata.fax = "";
      this.createcontactformdata.sex = "";
      this.createcontactformdata.age = null;
    },
    createcontact() {
      this.$refs["createcontactform"].validate((valid) => {
        if (valid) {
          axios({
            url: "clientmanage/create_contact/",
            method: "post",
            data: this.createcontactformdata,
          }).then((res) => {
            this.addContactDialogVisible = false;
            this.initContact();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    handleContactEdit(index, row) {
      this.editContactDialogVisible = true;
      let param = new URLSearchParams();
      param.append("contactid", row.contactid);
      axios({
        url: "clientmanage/get_contact_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editcontactformdata = res.data[0];
        this.editcontactformdata.ismanager =
          this.editcontactformdata.ismanager + "";
      });
    },
    editcontact() {
      this.$refs["editcontactform"].validate((valid) => {
        if (valid) {
          axios({
            url: "clientmanage/edit_contact/",
            method: "post",
            data: this.editcontactformdata,
          }).then((res) => {
            this.initContact();
            this.editContactDialogVisible = false;
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deletecontact(index, row) {
      this.$confirm("确认删除？")
        .then((_) => {
          let param = new URLSearchParams();
          param.append("contactid", row.contactid);
          axios({
            url: "clientmanage/delete_contact/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initContact();
          });
        })
        .catch((_) => {
          return;
        });
    },
    tableRowClassName({row, rowIndex}) {
        if (row.ismanager == 1) {
          return 'success-row';
        }
        return '';
    }
  },
};
</script>