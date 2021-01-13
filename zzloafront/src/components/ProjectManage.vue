<template>
  <div>
    <el-row>
      <el-button
        @click="
          dialogVisible = true;
          clearcreateprojectform();
        "
        v-if="this.permissions.indexOf('000022') != -1"
        ><i class="el-icon-plus"></i>新建项目</el-button
      >
      <el-button
        type="danger"
        @click="deleteproject()"
        v-if="this.permissions.indexOf('000023') != -1"
        ><i class="el-icon-delete"></i>删除项目</el-button
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
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-table
            :data="
              tableScheduleData.filter(
                (f) => f.projectid == props.row.projectid
              )
            "
            stripe
            style="width: 100%"
          >
            <el-table-column fixed type="index" width="20"> </el-table-column>
            <el-table-column
              prop="schedulename"
              label="阶段名"
              fixed
              width="100"
            >
            </el-table-column>
            <el-table-column
              prop="scheduledescription"
              label="阶段描述"
              width="100"
              fixed
            >
            </el-table-column>
            <el-table-column
              prop="groupname"
              label="负责部门"
              width="100"
              fixed
            >
            </el-table-column>
            <el-table-column
              prop="managername"
              label="负责人"
              width="100"
              fixed
            >
            </el-table-column>
            <el-table-column
              label="阶段状态"
              prop="isfinished"
              align="center"
              width="80"
              fixed
            >
              <template slot-scope="scope">
                <span v-if="scope.row.isfinished == 0">进行中</span>
                <span v-if="scope.row.isfinished == 1">已结束</span>
              </template>
            </el-table-column>
            <el-table-column
              prop="preworkload"
              label="预计工作量(人/日)"
              width="150"
            >
            </el-table-column>
            <el-table-column
              prop="realworkload"
              label="实际工作量(人/日)"
              width="150"
            >
            </el-table-column>
            <el-table-column
              prop="schedulestartdate"
              label="预计开始时间"
              width="110"
            >
              <template slot-scope="scope">{{
                scope.row.schedulestartdate | dateYMDHMSFormat
              }}</template>
            </el-table-column>
            <el-table-column
              prop="schedulefinishdate"
              width="110"
              label="预计结束时间"
            >
              <template slot-scope="scope">{{
                scope.row.schedulefinishdate | dateYMDHMSFormat
              }}</template>
            </el-table-column>
            <el-table-column
              prop="schedulerealstartdate"
              width="110"
              label="实际开始时间"
            >
              <template slot-scope="scope">{{
                scope.row.schedulerealstartdate | dateYMDHMSFormat
              }}</template>
            </el-table-column>
            <el-table-column
              prop="schedulerealfinishdate"
              width="110"
              label="实际结束时间"
            >
              <template slot-scope="scope">{{
                scope.row.schedulefinishdate | dateYMDHMSFormat
              }}</template>
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
            <el-table-column label="操作" width="230" fixed="right">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  @click="handleScheduleEdit(scope.$index, scope.row)"
                  ><i class="el-icon-edit"></i>修改阶段</el-button
                >
                <el-button
                  type="danger"
                  size="mini"
                  @click="deleteprojectschedule(scope.$index, scope.row)"
                  ><i class="el-icon-delete"></i>删除阶段</el-button
                >
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column prop="projectname" label="项目名" width="180">
      </el-table-column>
      <el-table-column prop="description" label="项目描述" width="300">
      </el-table-column>
      <el-table-column prop="projecttype" label="项目类型" width="120">
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
            ><i class="el-icon-edit"></i>修改项目</el-button
          >
          <el-button
            size="mini"
            @click="
              handleScheduleAdd(scope.$index, scope.row);
              clearcreatescheduleformdata();
            "
            ><i class="el-icon-plus"></i>添加阶段</el-button
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

    <el-dialog title="新建项目" :visible.sync="dialogVisible" width="25%" :close-on-click-modal="false">
      <el-form
        name="createprojectform"
        ref="createprojectform"
        :label-position="labelPosition"
        label-width="130px"
        :model="createformdata"
      >
        <el-form-item
          label="项目名"
          prop="projectname"
          :rules="[
            { required: true, message: '项目名不能为空', trigger: 'blur' },
            { max: 50, message: '长度最大支持50个字符', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createformdata.projectname"></el-input>
        </el-form-item>
        <el-form-item label="项目描述" prop="description">
          <el-input
            type="textarea"
            v-model="createformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="项目类型"
          prop="projecttype"
          :rules="[
            { required: true, message: '项目类型不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.projecttype" placeholder="请选择">
            <el-option
              v-for="item in types"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createproject()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="编辑项目" :visible.sync="editDialogVisible" width="25%" :close-on-click-modal="false">
      <el-form
        name="editprojectform"
        :label-position="labelPosition"
        label-width="130px"
        ref="editprojectform"
        :model="editformdata"
      >
        <el-form-item
          label="项目名"
          prop="projectname"
          :rules="[
            { required: true, message: '项目名不能为空', trigger: 'blur' },
            { max: 50, message: '长度最大支持50个字符', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.projectname"></el-input>
        </el-form-item>
        <el-form-item label="项目描述">
          <el-input
            type="textarea"
            v-model="editformdata.description"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="项目类型"
          prop="projecttype"
          :rules="[
            { required: true, message: '项目类型不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="editformdata.projecttype" placeholder="请选择">
            <el-option
              v-for="item in types"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editproject()">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="添加阶段"
      :visible.sync="addScheduleDialogVisible"
      width="28%"
      :close-on-click-modal="false"
    >
      <el-form
        name="createscheduleform"
        ref="createscheduleform"
        :label-position="labelPosition"
        label-width="150px"
        :model="createscheduleformdata"
      >
        <el-form-item
          label="阶段名"
          prop="schedulename"
          :rules="[
            { required: true, message: '阶段名不能为空', trigger: 'blur' },
            { max: 50, message: '长度最大支持50个字符', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createscheduleformdata.schedulename"></el-input>
        </el-form-item>
        <el-form-item label="阶段描述" prop="scheduledescription">
          <el-input
            type="textarea"
            v-model="createscheduleformdata.scheduledescription"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="负责部门"
          prop="groupid"
          :rules="[
            { required: true, message: '负责部门不能为空', trigger: 'blur' },
          ]"
        >
          <SelectTree
            :props="props"
            :options="options"
            :value="createscheduleformdata.groupid"
            :clearable="isClearable"
            :accordion="isAccordion"
            @getValue="getValue($event)"
          />
        </el-form-item>
        <el-form-item label="负责人" prop="managerid">
          <el-select
            v-model="createscheduleformdata.managerid"
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
        <el-form-item label="项目组成员" prop="members">
          <el-select
            v-model="createscheduleformdata.members"
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
        <el-form-item
          label="预计工作量(人/日)"
          prop="preworkload"
          :rules="[
            { required: true, message: '预计工作量不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="createscheduleformdata.preworkload"></el-input>
        </el-form-item>
        <el-form-item
          label="预计开始日期"
          prop="schedulestartdate"
          :rules="[
            {
              required: true,
              message: '预计开始时间不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-date-picker
            v-model="createscheduleformdata.schedulestartdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item
          label="预计结束日期"
          prop="schedulefinishdate"
          :rules="[
            {
              required: true,
              message: '预计结束时间不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-date-picker
            v-model="createscheduleformdata.schedulefinishdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="addScheduleDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createprojectschedule()"
          >确 定</el-button
        >
      </span>
    </el-dialog>

    <el-dialog
      title="编辑阶段"
      :visible.sync="editScheduleDialogVisible"
      width="30%"
      :close-on-click-modal="false"
    >
      <el-form
        name="editscheduleform"
        :label-position="labelPosition"
        label-width="150px"
        ref="editscheduleform"
        :model="editscheduleformdata"
      >
        <el-form-item label="阶段名" prop="schedulename" :rules="[
            { required: true, message: '阶段名不能为空', trigger: 'blur' },
            { max: 50, message: '长度最大支持50个字符', trigger: 'blur' },
          ]">
          <el-input v-model="editscheduleformdata.schedulename"></el-input>
        </el-form-item>
        <el-form-item label="阶段描述">
          <el-input
            type="textarea"
            v-model="editscheduleformdata.scheduledescription"
          ></el-input>
        </el-form-item>
        <el-form-item label="负责部门" prop="groupid" :rules="[
            { required: true, message: '负责部门不能为空', trigger: 'blur' },
          ]">
          <SelectTree
            :props="props"
            :options="options"
            :value="editscheduleformdata.groupid"
            :clearable="isClearable"
            :accordion="isAccordion"
            @getValue="getValueedit($event)"
          />
        </el-form-item>
        <el-form-item label="负责人">
          <el-select
            v-model="editscheduleformdata.managerid"
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
        <el-form-item label="项目组成员">
          <el-select
            v-model="editscheduleformdata.members"
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
        <el-form-item label="预计工作量(人/日)" prop="preworkload" :rules="[
            { required: true, message: '预计工作量不能为空', trigger: 'blur' },
          ]">
          <el-input v-model="editscheduleformdata.preworkload"></el-input>
        </el-form-item>
        <el-form-item label="实际工作量(人/日)">
          <el-input v-model="editscheduleformdata.realworkload"></el-input>
        </el-form-item>
        <el-form-item label="预计开始日期" prop="schedulestartdate" :rules="[
            {
              required: true,
              message: '预计开始时间不能为空',
              trigger: 'blur',
            },
          ]">
          <el-date-picker
            v-model="editscheduleformdata.schedulestartdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="预计结束日期" prop="schedulefinishdate" :rules="[
            {
              required: true,
              message: '预计结束时间不能为空',
              trigger: 'blur',
            },
          ]">
          <el-date-picker
            v-model="editscheduleformdata.schedulefinishdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际开始日期">
          <el-date-picker
            v-model="editscheduleformdata.schedulerealstartdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="实际结束日期">
          <el-date-picker
            v-model="editscheduleformdata.schedulerealfinishdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="阶段状态" prop="isfinished">
          <el-select
            v-model="editscheduleformdata.isfinished"
            placeholder="请选择"
          >
            <el-option label="进行中" value="0"></el-option>
            <el-option label="已结束" value="1"></el-option>
          </el-select>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editScheduleDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editprojectschedule()"
          >确 定</el-button
        >
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
        limit: 5,
        page: 1,
      },
      tableData: [],
      tableScheduleData: [],
      multipleSelection: [],
      dialogVisible: false,
      editDialogVisible: false,
      addScheduleDialogVisible: false,
      editScheduleDialogVisible: false,
      labelPosition: "right",
      createformdata: {
        projectname: "",
        description: "",
        projecttype: null,
      },
      editformdata: {
        projectid: 0,
        projectname: "",
        description: "",
        projecttype: null,
      },
      createscheduleformdata: {
        projectid: null,
        schedulename: "",
        scheduledescription: "",
        groupid: "",
        managerid: null,
        members: [],
        schedulestartdate: "",
        schedulefinishdate: "",
        preworkload: null,
      },
      editscheduleformdata: {
        projectscheduleid: null,
        projectid: null,
        schedulename: "",
        scheduledescription: "",
        groupid: "",
        managerid: null,
        members: [],
        schedulestartdate: "",
        schedulefinishdate: "",
        preworkload: null,
        realworkload: null,
        schedulerealstartdate: "",
        schedulerealfinishdate: "",
        isfinished: "",
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
      types: [],
      options: [],
      userlist: [],
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
    this.initschedules();
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
        //this.total = res.data.length;
      });
    },
    initschedules() {
      axios({
        url: "projectmanage/get_project_schedule/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableScheduleData = res.data;
        //this.total = res.data.length;
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
    clearcreateprojectform() {
      this.$refs["createprojectform"].clearValidate();
      this.createformdata.projectname = "";
      this.createformdata.description = "";
      this.createformdata.projecttype = null;
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    createproject() {
      this.$refs["createprojectform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("projectname", this.createformdata.projectname);
          param.append("description", this.createformdata.description);
          param.append("projecttype", this.createformdata.projecttype);

          axios({
            url: "projectmanage/create_project/",
            method: "post",
            data: param,
          }).then((res) => {
            this.dialogVisible = false;
            this.initprojects();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleteproject() {
      if (this.multipleSelection.length == 0) {
        alert("请选择要删除的项目");
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
      let param = new URLSearchParams();
      param.append("projectid", row.projectid);
      axios({
        url: "projectmanage/get_project_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editformdata.projectid = res.data[0].projectid;
        this.editformdata.projectname = res.data[0].projectname;
        this.editformdata.description = res.data[0].description;
        this.editformdata.projecttype = res.data[0].typeid;
      });
    },
    editproject() {
      this.$refs["editprojectform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("projectid", this.editformdata.projectid);
          param.append("projectname", this.editformdata.projectname);
          param.append("description", this.editformdata.description);
          param.append("projecttype", this.editformdata.projecttype);

          axios({
            url: "projectmanage/edit_project/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initprojects();
            this.editDialogVisible = false;
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    handleScheduleAdd(index, row) {
      this.addScheduleDialogVisible = true;
      this.createscheduleformdata.projectid = row.projectid;
    },
    getValue(value) {
      this.createscheduleformdata.groupid = value;
    },
    getValueedit(value) {
      this.editscheduleformdata.groupid = value;
    },
    clearcreatescheduleformdata() {
      this.$refs["createscheduleform"].clearValidate();
      this.createscheduleformdata.schedulename = "";
      this.createscheduleformdata.scheduledescription = "";
      this.createscheduleformdata.groupid = "";
      this.createscheduleformdata.managerid = null;
      this.createscheduleformdata.members = [];
      this.createscheduleformdata.schedulestartdate = "";
      this.createscheduleformdata.schedulefinishdate = "";
      this.createscheduleformdata.preworkload = null;
    },
    createprojectschedule() {
      this.$refs["createscheduleform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("projectid", this.createscheduleformdata.projectid);
          param.append(
            "schedulename",
            this.createscheduleformdata.schedulename
          );
          param.append(
            "scheduledescription",
            this.createscheduleformdata.scheduledescription
          );
          param.append("groupid", this.createscheduleformdata.groupid);
          param.append("managerid", this.createscheduleformdata.managerid);
          param.append("members", this.createscheduleformdata.members);
          param.append(
            "schedulestartdate",
            this.createscheduleformdata.schedulestartdate
          );
          param.append(
            "schedulefinishdate",
            this.createscheduleformdata.schedulefinishdate
          );
          param.append("preworkload", this.createscheduleformdata.preworkload);

          axios({
            url: "projectmanage/create_project_schedule/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initschedules();
          });

          this.addScheduleDialogVisible = false;
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    handleScheduleEdit(index, row) {
      this.editScheduleDialogVisible = true;
      this.editscheduleformdata.members = [];
      let param = new URLSearchParams();
      param.append("projectscheduleid", row.projectscheduleid);
      axios({
        url: "projectmanage/get_project_schedule_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.editscheduleformdata.projectscheduleid =
          res.data.projectschedule[0].projectscheduleid;
        this.editscheduleformdata.projectid =
          res.data.projectschedule[0].projectid;
        this.editscheduleformdata.schedulename =
          res.data.projectschedule[0].schedulename;
        this.editscheduleformdata.scheduledescription =
          res.data.projectschedule[0].scheduledescription;
        this.editscheduleformdata.groupid =
          res.data.projectschedule[0].groupid + "";
        this.editscheduleformdata.preworkload =
          res.data.projectschedule[0].preworkload;
        this.editscheduleformdata.realworkload =
          res.data.projectschedule[0].realworkload;
        this.editscheduleformdata.schedulestartdate =
          res.data.projectschedule[0].schedulestartdate;
        this.editscheduleformdata.schedulefinishdate =
          res.data.projectschedule[0].schedulefinishdate;
        this.editscheduleformdata.schedulerealstartdate =
          res.data.projectschedule[0].schedulerealstartdate;
        this.editscheduleformdata.schedulerealfinishdate =
          res.data.projectschedule[0].schedulerealfinishdate;
        this.editscheduleformdata.isfinished =
          res.data.projectschedule[0].isfinished + "";
        res.data.users.forEach((element) => {
          if (element.ismanager == 1) {
            this.editscheduleformdata.managerid = element.userid;
          } else {
            this.editscheduleformdata.members.push(element.userid);
          }
        });
      });
    },
    editprojectschedule() {
      this.$refs["editscheduleform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append(
            "projectscheduleid",
            this.editscheduleformdata.projectscheduleid
          );
          param.append("projectid", this.editscheduleformdata.projectid);
          param.append("schedulename", this.editscheduleformdata.schedulename);
          param.append(
            "scheduledescription",
            this.editscheduleformdata.scheduledescription
          );
          param.append("groupid", this.editscheduleformdata.groupid);
          param.append("managerid", this.editscheduleformdata.managerid);
          param.append("members", this.editscheduleformdata.members);
          param.append(
            "schedulestartdate",
            this.editscheduleformdata.schedulestartdate
          );
          param.append(
            "schedulefinishdate",
            this.editscheduleformdata.schedulefinishdate
          );
          param.append(
            "schedulerealstartdate",
            this.editscheduleformdata.schedulerealstartdate
          );
          param.append(
            "schedulerealfinishdate",
            this.editscheduleformdata.schedulerealfinishdate
          );
          param.append("preworkload", this.editscheduleformdata.preworkload);
          param.append("realworkload", this.editscheduleformdata.realworkload);
          param.append("isfinished", this.editscheduleformdata.isfinished);
          axios({
            url: "projectmanage/edit_project_schedule/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initschedules();
            this.editScheduleDialogVisible = false;
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    deleteprojectschedule(index, row) {
      this.$confirm("确认删除？")
        .then((_) => {
          let param = new URLSearchParams();
          param.append("projectscheduleid", row.projectscheduleid);
          axios({
            url: "projectmanage/delete_project_schedule/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initschedules();
          });
        })
        .catch((_) => {
          return;
        });
    },
  },
};
</script>