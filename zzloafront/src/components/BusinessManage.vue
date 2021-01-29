<template>
  <div>
    <el-row>
      <el-button
        @click="
          dialogVisible = true;
          clearcreatebusinessform();
        "
        v-if="this.permissions.indexOf('000032') != -1"
        ><i class="el-icon-plus"></i>新建商机</el-button
      >
      <el-button
        type="danger"
        @click="deletebusiness()"
        v-if="this.permissions.indexOf('000033') != -1"
        ><i class="el-icon-delete"></i>删除商机</el-button
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
      <el-table-column prop="businessname" fixed label="商机名" width="150">
      </el-table-column>
      <el-table-column
        fixed
        prop="status"
        label="状态"
        width="120"
        :formatter="stausFormat"
      >
      </el-table-column>
      <el-table-column fixed label="客户" width="180">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top">
            <p>联系人: {{ scope.row.contacts }}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium">{{ scope.row.companyname }}</el-tag>
            </div>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" width="180">
      </el-table-column>
      <el-table-column prop="possibility" label="可能性(%)" width="120">
      </el-table-column>
      <el-table-column prop="budget" label="预算(万)" width="120">
      </el-table-column>
      <el-table-column
        prop="managerid"
        label="负责人"
        width="100"
        :formatter="managerFormat"
      >
      </el-table-column>
      <el-table-column
        prop="owner"
        label="所有人"
        width="100"
        :formatter="ownerFormat"
      >
      </el-table-column>
      <!-- <el-table-column
        prop="writer"
        label="填报人"
        width="100"
        :formatter="writerFormat"
      >
      </el-table-column> -->
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
        v-if="this.permissions.indexOf('000034') != -1"
        label="操作"
        fixed="right"
        width="380"
      >
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>修改商机</el-button
          >
          <el-popover trigger="click" placement="top" width="300">
            <p>
              <el-timeline :reverse="false">
                <el-timeline-item v-for="(activity, businessrecordid) in businessrecord.filter((f) => f.businessid == scope.row.businessid)"
                :key="businessrecordid"
                :timestamp="activity.createtime.replace('T',' ')">
                {{activity.typename}}
                </el-timeline-item>
              </el-timeline>
            </p>
            <el-button size="mini" type="info" slot="reference">查看记录</el-button>
          </el-popover>
          <el-popover trigger="click" placement="top" width="300">
            <p>
              <el-timeline :reverse="false">
                <el-timeline-item v-for="(activity, dailypaperdetail_saleid) in importantrecord.filter((f) => f.businessid == scope.row.businessid)"
                :key="dailypaperdetail_saleid"
                :timestamp="activity.dailypaperdate.split('T')[0]">
                {{activity.writer}}:{{activity.workcontent}}
                </el-timeline-item>
              </el-timeline>
            </p>
            <el-button size="mini" type="info" slot="reference">重要活动</el-button>
          </el-popover>
          <el-button
            size="mini"
            @click="handleEnd(scope.$index, scope.row)"
            type="warning"
            ><i class="el-icon-switch-button"></i>结束商机</el-button
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

    <el-dialog title="新建商机" :visible.sync="dialogVisible" width="25%">
      <el-form
        name="createbusinessform"
        :label-position="labelPosition"
        label-width="90px"
        :model="createformdata"
        ref="createbusinessform"
      >
        <el-form-item
          label="商机名"
          prop="businessname"
          :rules="[
            { required: true, message: '商机名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.businessname"></el-input>
        </el-form-item>
        <el-form-item
          label="状态"
          prop="status"
          :rules="[
            { required: true, message: '状态不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.status" placeholder="请选择">
            <el-option
              v-for="item in statuslist"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="所有者" prop="owner">
          <el-select v-model="createformdata.owner" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item> -->
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="createformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="可能性(%)" prop="possibility">
          <el-input type="number" v-model="createformdata.possibility"></el-input>
        </el-form-item>
        <el-form-item label="预算(万)" prop="budget">
          <el-input type="number" v-model="createformdata.budget"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createbusiness()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="编辑商机" :visible.sync="editDialogVisible" width="25%">
      <el-form
        name="editbusinessform"
        :label-position="labelPosition"
        label-width="100px"
        :model="editformdata"
        ref="editbusinessform"
      >
        <el-form-item
          label="商机名"
          prop="businessname"
          :rules="[
            { required: true, message: '商机名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.businessname"></el-input>
        </el-form-item>
        <el-form-item
          label="状态"
          prop="status"
          :rules="[
            { required: true, message: '状态不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="editformdata.status" placeholder="请选择">
            <el-option
              v-for="item in statuslist"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="所有者" prop="owner">
          <el-select v-model="editformdata.owner" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item> -->
        <el-form-item label="描述" prop="description">
          <el-input
            type="textarea"
            v-model="editformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="可能性(%)" prop="possibility">
          <el-input type="number" v-model="editformdata.possibility"></el-input>
        </el-form-item>
        <el-form-item label="预算(万)" prop="budget">
          <el-input type="number" v-model="editformdata.budget"></el-input>
        </el-form-item>
        <el-form-item label="客户" prop="clientlist">
          <el-select
            v-model="editformdata.clientlist"
            multiple
            placeholder="请选择"
            @change="clientlistchange()"
          >
            <el-option
              v-for="item in clientlist"
              :key="item.clientid"
              :label="item.companyname"
              :value="item.clientid"
            >
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="联系人" prop="contactlist">
          <el-select
            v-model="editformdata.contactlist"
            multiple
            placeholder="请选择"
            @change="contactlistchange()"
          >
            <el-option
              v-for="item in contactlist"
              :key="item.contactid"
              :label="item.contactname"
              :value="item.contactid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="负责人(我方)" prop="managerid">
          <el-select
            v-model="editformdata.managerid"
            placeholder="请选择"
            @change="managerchange()"
          >
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="组成员(我方)" prop="members">
          <el-select
            v-model="editformdata.members"
            multiple
            placeholder="请选择"
            @change="memberschange()"
          >
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editbusiness()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="结束商机" :visible.sync="endDialogVisible" width="25%">
      <el-form
        name="endbusinessform"
        :label-position="labelPosition"
        label-width="140px"
        :model="endbusinessformdata"
        ref="endbusinessform"
      >
        <el-form-item label="状态" prop="status" :rules="[
            { required: true, message: '状态不能为空', trigger: 'blur' },
          ]">
          <el-select v-model="endbusinessformdata.status" @change="endstatuschange()" placeholder="请选择">
            <el-option label="丢失商机" value="0"></el-option>
            <el-option label="获取商机" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="丢失原因" v-if="endbusinessformdata.lossoption" prop="lossreason">
          <el-input
            type="textarea"
            v-model="endbusinessformdata.lossreason"
          ></el-input>
        </el-form-item>

        <el-form-item label="是否自动转为项目" v-if="endbusinessformdata.getoption" prop="status">
          <el-select v-model="endbusinessformdata.transtoproject" @change="transtoprojectchange()" placeholder="请选择">
            <el-option label="否" value="0"></el-option>
            <el-option label="是" value="1"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item
          label="项目名"
          prop="projectname"
          v-if="endbusinessformdata.istranstoproject"
          :rules="[
            { required: true, message: '项目名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="endbusinessformdata.projectname"></el-input>
        </el-form-item>

        <el-form-item label="项目描述" v-if="endbusinessformdata.istranstoproject" prop="description">
          <el-input
            type="textarea"
            v-model="endbusinessformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="项目类型" v-if="endbusinessformdata.istranstoproject" prop="projecttype" :rules="[
            { required: true, message: '项目类型不能为空', trigger: 'blur' },
          ]">
          <el-select
            v-model="endbusinessformdata.projecttype"
            placeholder="请选择"
          >
            <el-option
              v-for="item in projecttypes"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="endDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="endbusiness()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";

export default {
  name: "BusinessManage",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      businessrecord:[],
      importantrecord:[],
      statuslist: [],
      userlist: [],
      clientlist: [],
      contactlist: [],
      projecttypes:[],
      dialogVisible: false,
      editDialogVisible: false,
      endDialogVisible: false,
      labelPosition: "right",
      multipleSelection: [],
      editformdata: {
        businessid: null,
        businessname: "",
        status: null,
        description: "",
        possibility: null,
        budget: null,
        owner: null,
        clientlist: [],
        contactlist: [],
        managerid: null,
        members: [],
      },
      createformdata: {
        businessname: "",
        status: null,
        description: "",
        possibility: null,
        budget: null,
        owner: null,
      },
      endbusinessformdata: {
        status:null,
        transtoproject:"0",
        description:"",
        lossreason:"",
        projectname:"",
        projecttype:null,
        lossoption:false,
        getoption:false,
        istranstoproject:false,
        businessid:null,
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initbusinesses();
    this.initusers();
    this.initstatuses();
    this.initclients();
    this.inittypes();
  },
  methods: {
    initbusinesses() {
      axios({
        url: "businessmanage/get_businesses/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data.businesses;
        this.businessrecord = res.data.businessrecord;
        this.importantrecord = res.data.importantrecord;
        console.log(this.businessrecord);
        this.total = res.data.length;
      });
    },
    initusers() {
      axios({
        url: "usermanage/get_users/",
        method: "get",
        data: {},
      }).then((res) => {
        this.userlist = res.data;
      });
    },
    initstatuses() {
      axios({
        url: "businessmanage/get_statuses/",
        method: "get",
        data: {},
      }).then((res) => {
        this.statuslist = res.data;
      });
    },
    initclients() {
      axios({
        url: "clientmanage/get_clients/",
        method: "get",
        data: {},
      }).then((res) => {
        this.clientlist = res.data;
      });
    },
    inittypes() {
      axios({
        url: "projectmanage/get_project_types/",
        method: "get",
        data: {},
      }).then((res) => {
        this.projecttypes = res.data;
      });
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    clearcreatebusinessform() {
      this.$refs["createbusinessform"].clearValidate();
      this.createformdata.businessname = "";
      this.createformdata.status = null;
      this.createformdata.description = "";
      this.createformdata.possibility = null;
      this.createformdata.budget = null;
      this.createformdata.owner = null;
    },
    createbusiness() {
      this.$refs["createbusinessform"].validate((valid) => {
        if (valid) {
          axios({
            url: "businessmanage/create_business/",
            method: "post",
            data: this.createformdata,
          }).then((res) => {
            this.dialogVisible = false;
            this.initbusinesses();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    writerFormat(row, column) {
      let name = "";
      this.userlist.forEach((element) => {
        if (element.id == row.writer) {
          name = element.name;
        }
      });
      if (name == "") {
        return "";
      } else {
        return name;
      }
    },
    managerFormat(row, column) {
      let name = "";
      this.userlist.forEach((element) => {
        if (element.id == row.managerid) {
          name = element.name;
        }
      });
      if (name == "") {
        return "";
      } else {
        return name;
      }
    },
    ownerFormat(row, column) {
      let name = "";
      this.userlist.forEach((element) => {
        if (element.id == row.owner) {
          name = element.name;
        }
      });
      if (name == "") {
        return "";
      } else {
        return name;
      }
    },
    stausFormat(row, column) {
      let name = "";
      this.statuslist.forEach((element) => {
        if (element.typeid == row.status) {
          name = element.typename;
        }
      });
      if (name == "") {
        return "";
      } else {
        return name;
      }
    },
    handleEdit(index, row) {
      this.editDialogVisible = true;
      let param = new URLSearchParams();
      param.append("businessid", row.businessid);
      axios({
        url: "businessmanage/get_business_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editformdata = res.data.business[0];
        this.editformdata.clientlist = [];
        res.data.business_client.forEach((element) => {
          this.editformdata.clientlist.push(element.clientid);
        });
        this.editformdata.contactlist = [];
        res.data.business_contact.forEach((element) => {
          this.editformdata.contactlist.push(element.contactid);
        });

        this.editformdata.members = [];
        res.data.business_user.forEach((element) => {
          if (element.ismanager == 1) {
            this.editformdata.managerid = element.userid;
          } else {
            this.editformdata.members.push(element.userid);
          }
        });
        this.clientlistchange();
      });
    },
    handleEnd(index, row) {
      console.log(this.projecttypes);
      this.endbusinessformdata.businessid = row.businessid
      this.endbusinessformdata.status = null;
      this.endbusinessformdata.transtoproject = "0";
      this.endbusinessformdata.description = row.description;
      this.endbusinessformdata.lossreason = null;
      this.endbusinessformdata.projectname = row.businessname;
      this.endbusinessformdata.projecttype = 1;
      this.endbusinessformdata.lossoption = false;
      this.endbusinessformdata.getoption = false;
      this.endbusinessformdata.istranstoproject = false;
      this.endDialogVisible = true;
    },
    endbusiness(){
      this.$refs["endbusinessform"].validate((valid) => {
        if (valid) {
          axios({
            url: "businessmanage/end_business/",
            method: "post",
            data: this.endbusinessformdata,
          }).then((res) => {
            this.endDialogVisible = false;
            this.initbusinesses();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    clientlistchange() {
      this.$forceUpdate();

      if (this.editformdata.clientlist.length > 0) {
        let param = new URLSearchParams();
        param.append("clientlist", this.editformdata.clientlist);
        axios({
          url: "businessmanage/get_contacts/",
          method: "post",
          data: param,
        }).then((res) => {
          this.contactlist = res.data;
        });
      }
    },
    contactlistchange() {
      this.$forceUpdate();
    },
    managerchange() {
      this.$forceUpdate();
    },
    memberschange() {
      this.$forceUpdate();
    },
    endstatuschange(){
      if(this.endbusinessformdata.status == 0){
        this.endbusinessformdata.lossoption = true;
        this.endbusinessformdata.getoption = false;
      }
      else{
        this.endbusinessformdata.lossoption = false;
        this.endbusinessformdata.getoption = true;
      }
    },
    transtoprojectchange(){
      if(this.endbusinessformdata.transtoproject == 0){
        this.endbusinessformdata.istranstoproject = false;
      }
      else{
        this.endbusinessformdata.istranstoproject = true;
      }
    },
    editbusiness() {
      this.$refs["editbusinessform"].validate((valid) => {
        if (valid) {
          axios({
            url: "businessmanage/edit_business/",
            method: "post",
            data: this.editformdata,
          }).then((res) => {
            this.editDialogVisible = false;
            this.initbusinesses();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deletebusiness() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的商机");
      } else {
        this.$confirm("确认删除？")
          .then((_) => {
            let idarr = [];
            this.multipleSelection.forEach((element) => {
              idarr.push(element.businessid);
            });

            let param = new URLSearchParams();
            param.append("ids", idarr);
            axios({
              url: "businessmanage/delete_business/",
              method: "post",
              data: param,
            }).then((res) => {
              this.initbusinesses();
            });
          })
          .catch((_) => {
            return;
          });
      }
    },
  },
};
</script>