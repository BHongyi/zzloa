<template>
  <div>
    <el-row>
      <el-button
        @click="dialogVisible = true"
        v-if="this.permissions.indexOf('000022') != -1"
        ><i class="el-icon-plus"></i>新建</el-button
      >
      <el-button
        type="danger"
        @click="deleteproject()"
        v-if="this.permissions.indexOf('000023') != -1"
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
      <el-table-column type="selection" width="50"> </el-table-column>
      <el-table-column prop="projectname" label="项目名" width="180">
      </el-table-column>
      <el-table-column prop="description" label="项目描述" width="180">
      </el-table-column>
      <el-table-column prop="groupname" label="负责部门" width="180">
      </el-table-column>
      <el-table-column prop="prestarttime" label="预计开始时间" width="120">
        <template slot-scope="scope">{{
          scope.row.prestarttime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="realstarttime" label="实际开始时间" width="120">
        <template slot-scope="scope">{{
          scope.row.realstarttime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="prefinishtime" label="预计完成时间" width="120">
        <template slot-scope="scope">{{
          scope.row.prefinishtime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="realfinishtime" label="实际完成时间" width="120">
        <template slot-scope="scope">{{
          scope.row.realfinishtime | dateYMDHMSFormat
        }}</template>
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
      <el-table-column
        v-if="this.permissions.indexOf('000024') != -1"
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

    <el-dialog title="新建项目" :visible.sync="dialogVisible" width="25%">
      <el-form
        name="createprojectform"
        :label-position="labelPosition"
        label-width="100px"
        :model="createformdata"
      >
        <el-form-item label="项目名">
          <el-input v-model="createformdata.projectname"></el-input>
        </el-form-item>
        <el-form-item label="项目描述">
          <el-input
            type="textarea"
            v-model="createformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="项目类型">
          <el-select v-model="createformdata.projecttype" placeholder="请选择">
            <el-option
              v-for="item in types"
              :key="item.dictid"
              :label="item.typename"
              :value="item.dictid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="负责部门">
          <SelectTree
            :props="props"
            :options="options"
            :value="valueId"
            :clearable="isClearable"
            :accordion="isAccordion"
            @getValue="getValue($event)"
          />
        </el-form-item>
        <el-form-item label="负责人">
          <el-select v-model="createformdata.managerid" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目组成员">
          <el-select
            v-model="createformdata.members"
            multiple
            placeholder="请选择"
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
        <el-form-item label="预计开始日期">
          <el-date-picker
            v-model="createformdata.prestarttime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="预计结束日期">
          <el-date-picker
            v-model="createformdata.prefinishtime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createproject()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="编辑项目" :visible.sync="editDialogVisible" width="25%">
      <el-form
        name="editprojectform"
        :label-position="labelPosition"
        label-width="100px"
        :model="editformdata"
      >
        <el-form-item label="项目名">
          <el-input v-model="editformdata.projectname"></el-input>
        </el-form-item>
        <el-form-item label="项目描述">
          <el-input
            type="textarea"
            v-model="editformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item label="项目类型">
          <el-select v-model="editformdata.projecttype" placeholder="请选择">
            <el-option
              v-for="item in types"
              :key="item.dictid"
              :label="item.typename"
              :value="item.dictid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="负责部门">
          <SelectTree
            :props="props"
            :options="options"
            :value="editGroupId"
            :clearable="isClearable"
            :accordion="isAccordion"
            @getValue="getValue($event)"
          />
        </el-form-item>
        <el-form-item label="负责人">
          <el-select v-model="editformdata.managerid" placeholder="请选择">
            <el-option
              v-for="item in userlist"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目组成员">
          <el-select
            v-model="editformdata.members"
            multiple
            placeholder="请选择"
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
        <el-form-item label="预计开始日期">
          <el-date-picker
            v-model="editformdata.prestarttime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="预计结束日期">
          <el-date-picker
            v-model="editformdata.prefinishtime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际开始日期">
          <el-date-picker
            v-model="editformdata.realstarttime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际结束日期">
          <el-date-picker
            v-model="editformdata.realfinishtime"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editproject()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";
import SelectTree from "../components/common/treeSelect.vue";

export default {
  name: "ProjectManage",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      multipleSelection: [],
      dialogVisible: false,
      editDialogVisible: false,
      labelPosition: "right",
      createformdata: {
        projectname: "",
        description: "",
        groupid: 0,
        managerid: null,
        members: [],
        prestarttime: "",
        prefinishtime: "",
        projecttype: null,
      },
      editformdata: {
        projectid:0,
        projectname: "",
        description: "",
        groupid: 0,
        managerid: null,
        members: [],
        prestarttime: "",
        prefinishtime: "",
        projecttype: null,
        realstarttime: "",
        realfinishtime: "",
      },
      isClearable: true, // 可清空（可选）
      isAccordion: false, // 可收起（可选）
      valueId: "0", // 初始ID（可选）
      editGroupId: "0", // 初始ID（可选）
      props: {
        // 配置项（必选）
        value: "groupid",
        label: "label",
        children: "children",
        // disabled:true
      },
      options: [],
      userlist: [],
      types: [],
    };
  },
  components: {
    SelectTree,
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initprojects();
    this.initgroups();
    this.initusers();
    this.inittypes();
  },
  methods: {
    initprojects() {
      axios({
        url: "projectmanage/get_projects/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
    },
    initgroups() {
      axios({
        url: "groupmanage/get_groups/",
        method: "get",
        data: {},
      }).then((res) => {
        this.options = res.data.children;
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
    inittypes() {
      axios({
        url: "projectmanage/get_project_types/",
        method: "get",
        data: {},
      }).then((res) => {
        this.types = res.data;
      });
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    getValue(value) {
      this.createformdata.groupid = value;
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    createproject() {
      let param = new URLSearchParams();
      param.append("projectname", this.createformdata.projectname);
      param.append("description", this.createformdata.description);
      param.append("projecttype", this.createformdata.projecttype);
      param.append("groupid", this.createformdata.groupid);
      param.append("managerid", this.createformdata.managerid);
      param.append("members", this.createformdata.members);
      param.append("prestarttime", this.createformdata.prestarttime);
      param.append("prefinishtime", this.createformdata.prefinishtime);

      axios({
        url: "projectmanage/create_project/",
        method: "post",
        data: param,
      }).then((res) => {
        this.dialogVisible = false;
        this.initprojects();
      });
    },
    deleteproject() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的用户");
      } else {
        this.$confirm("确认删除？")
          .then((_) => {
            let idarr = [];
            this.multipleSelection.forEach((element) => {
              idarr.push(element.projectid);
            });

            let param = new URLSearchParams();
            param.append("ids", idarr);
            axios({
              url: "projectmanage/delete_project/",
              method: "post",
              data: param,
            }).then((res) => {
              this.initprojects();
            });
          })
          .catch((_) => {
            return;
          });
      }
    },
    handleEdit(index, row) {
      this.editDialogVisible = true;
      this.editformdata.members = [];
      let param = new URLSearchParams();
      param.append("projectid", row.projectid);
      axios({
        url: "projectmanage/get_project_byid/",
        method: "post",
        data: param,
      }).then((res) => {
         this.editformdata.projectid = res.data.project[0].projectid;
         this.editformdata.projectname = res.data.project[0].projectname;
         this.editformdata.description = res.data.project[0].description;
         this.editformdata.projecttype = res.data.project[0].typeid;
         this.editGroupId = res.data.project[0].groupid + "";
         this.editformdata.prestarttime = res.data.project[0].prestarttime;
         this.editformdata.prefinishtime = res.data.project[0].prefinishtime;
         this.editformdata.realstarttime = res.data.project[0].realstarttime;
         this.editformdata.realfinishtime = res.data.project[0].realfinishtime;
         res.data.users.forEach(element => {
             if(element.ismanager == 1){
                 this.editformdata.managerid = element.userid;
             }
             else{
                 this.editformdata.members.push(element.userid);
             }
         });
      });
    },
    editproject() {
      let param = new URLSearchParams();
      param.append("projectid", this.editformdata.projectid);
      param.append("projectname", this.editformdata.projectname);
      param.append("description", this.editformdata.description);
      param.append("projecttype", this.editformdata.projecttype);
      param.append("groupid", this.editGroupId);
      param.append("managerid", this.editformdata.managerid);
      param.append("members", this.editformdata.members);
      param.append("prestarttime", this.editformdata.prestarttime);
      param.append("prefinishtime", this.editformdata.prefinishtime);
      param.append("realstarttime", this.editformdata.realstarttime);
      param.append("realfinishtime", this.editformdata.realfinishtime);

      axios({
        url: "projectmanage/edit_project/",
        method: "post",
        data: param,
      }).then((res) => {
        this.initprojects();
        this.editDialogVisible = false;
      });
    },
  },
};
</script>