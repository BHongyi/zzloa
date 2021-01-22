<template>
  <div>
    <el-row>
      <el-button @click="dialogVisible = true;cleardailypaperForm()"
        ><i class="el-icon-plus"></i>填写日报</el-button
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
    >
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-table
            :data="
              tableDailypaperDetail.filter(
                (f) => f.dailypaperid == props.row.dailypaperid
              )
            "
            stripe
            style="width: 100%"
          >
            <el-table-column type="index" width="20"> </el-table-column>
            <el-table-column prop="projectname" label="项目-阶段名" width="200">
            </el-table-column>
            <el-table-column prop="worktime" label="用时(单位:h)" width="200">
            </el-table-column>
            <el-table-column
              prop="workcontent"
              label="工作内容"
              style="width: 50%"
            >
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column prop="dailypaperdate" label="日报日期" width="180">
        <template slot-scope="scope">{{
          scope.row.dailypaperdate | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="receptionists" label="接收人" style="width: 25%">
      </el-table-column>
      <el-table-column prop="readreceptionists" label="已读接收人" style="width: 25%">
      </el-table-column>
      <el-table-column prop="createtime" label="提交日期" width="180">
        <template slot-scope="scope">{{
          scope.row.createtime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column
        label="操作"
        width="180"
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
      title="填写日报"
      :visible.sync="dialogVisible"
      width="650px"
      :before-close="handleClose"
    >
      <el-form
        :model="returnjson"
        label-position="left"
        label-width="80px"
        ref="dailypaperForm"
      >
        <el-form-item
          label="日期:"
          prop="dailypaperdate"
          :rules="[
            {
              required: true,
              message: '日报日期不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-date-picker
            v-model="returnjson.dailypaperdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
            :picker-options="pickerOptions"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item
          label="项目:"
          prop="projectschedules"
          :rules="[
            {
              required: true,
              message: '项目不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-select
            v-model="returnjson.projectschedules"
            multiple
            placeholder="请选择项目"
            style="width: 500px"
            @change="projectschedulechange()"
          >
            <el-option
              v-for="item in projectschedulelist"
              :key="item.projectscheduleid"
              :label="item.projectname"
              :value="item.projectscheduleid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="接收人:"
          prop="checkeduser"
          :rules="[
            {
              required: true,
              message: '接收人不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-select
            v-model="returnjson.checkeduser"
            multiple
            placeholder="请选择收件人"
            style="width: 500px"
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
        <el-table
          :data="returnjson.tableData"
          empty-text="请选择项目"
          style="width: 100%"
        >
          <el-table-column
            prop="projectschedulename"
            label="项目-阶段"
            width="180"
          >
          </el-table-column>
          <el-table-column prop="worktime" label="工时(单位:h)" width="120">
            <template slot-scope="scope">
              <el-form-item
                label-width="0px"
                :prop="'tableData.' + scope.$index + '.worktime'"
                :rules="[
                  {
                    required: true,
                    message: '工作内容不能为空',
                    trigger: 'blur',
                  },
                ]"
              >
                <el-select v-model="scope.row.worktime" placeholder="请选择">
                  <el-option
                    v-for="item in timelist"
                    :key="item.id"
                    :value="item.id"
                    :label="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="workcontent" label="工作内容">
            <template slot-scope="scope">
              <el-form-item
                label-width="0px"
                :prop="'tableData.' + scope.$index + '.workcontent'"
                :rules="[
                  {
                    required: true,
                    message: '工作内容不能为空',
                    trigger: 'blur',
                  },
                ]"
              >
                <el-input
                  v-model="scope.row.workcontent"
                  type="textarea"
                ></el-input>
              </el-form-item>
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-link type="info" @click="history()">一键带入历史</el-link>
        <el-button type="primary" @click="submitdailypaper()">提交</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="编辑日报"
      :visible.sync="editDialogVisible"
      width="650px"
    >
      <el-form
        :model="editreturnjson"
        label-position="left"
        label-width="80px"
        ref="editdailypaperForm"
      >
        <el-form-item
          label="日期:"
          prop="dailypaperdate"
          :rules="[
            {
              required: true,
              message: '日报日期不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-date-picker
            v-model="editreturnjson.dailypaperdate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="选择日期"
            :picker-options="pickerOptions"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item
          label="项目:"
          prop="projectschedules"
          :rules="[
            {
              required: true,
              message: '项目不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-select
            v-model="editreturnjson.projectschedules"
            multiple
            placeholder="请选择项目"
            style="width: 500px"
            @change="editprojectschedulechange()"
          >
            <el-option
              v-for="item in projectschedulelist"
              :key="item.projectscheduleid"
              :label="item.projectname"
              :value="item.projectscheduleid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="接收人:"
          prop="checkeduser"
          :rules="[
            {
              required: true,
              message: '接收人不能为空',
              trigger: 'blur',
            },
          ]"
        >
          <el-select
            v-model="editreturnjson.checkeduser"
            multiple
            placeholder="请选择收件人"
            style="width: 500px"
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
        <el-table
          :data="editreturnjson.tableData"
          empty-text="请选择项目"
          style="width: 100%"
        >
          <el-table-column
            prop="projectname"
            label="项目-阶段"
            width="180"
          >
          </el-table-column>
          <el-table-column prop="worktime" label="工时(单位:h)" width="120">
            <template slot-scope="scope">
              <el-form-item
                label-width="0px"
                :prop="'tableData.' + scope.$index + '.worktime'"
                :rules="[
                  {
                    required: true,
                    message: '工作内容不能为空',
                    trigger: 'blur',
                  },
                ]"
              >
                <el-select v-model="scope.row.worktime" placeholder="请选择">
                  <el-option
                    v-for="item in timelist"
                    :key="item.id"
                    :value="item.id"
                    :label="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="workcontent" label="工作内容">
            <template slot-scope="scope">
              <el-form-item
                label-width="0px"
                :prop="'tableData.' + scope.$index + '.workcontent'"
                :rules="[
                  {
                    required: true,
                    message: '工作内容不能为空',
                    trigger: 'blur',
                  },
                ]"
              >
                <el-input
                  v-model="scope.row.workcontent"
                  type="textarea"
                ></el-input>
              </el-form-item>
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submiteditdailypaper()">提交</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
ul {
  list-style: none;
}
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "DailyPaper",
  data() {
    return {
      dialogVisible: false,
      editDialogVisible:false,
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      tableDailypaperDetail: [],
      pickerOptions: {
        disabledDate(time) {
          var curTime = new Date().getTime();
          var startDate = curTime - 3 * 3600 * 24 * 1000;
          startDate = new Date(startDate);
          return time.getTime() > Date.now() || time.getTime() < startDate;
        },
      },
      timelist: [
        { id: 0.5, name: "0.5" },
        { id: 1, name: "1.0" },
        { id: 1.5, name: "1.5" },
        { id: 2, name: "2.0" },
        { id: 3.0, name: "3.0" },
        { id: 4.0, name: "4.0" },
        { id: 5.0, name: "5.0" },
        { id: 6.0, name: "6.0" },
        { id: 7.0, name: "7.0" },
        { id: 8.0, name: "8.0" },
        { id: 9.0, name: "9.0" },
        { id: 10.0, name: "10.0" },
        { id: 11.0, name: "11.0" },
        { id: 12.0, name: "12.0" },
      ],
      projectschedulelist: [],
      oldprojectschedules: [],
      editoldprojectschedules: [],
      receptionists: "",
      userlist: [],
      returnjson: {
        dailypaperdate: new Date(),
        projectschedules: [],
        checkeduser: [],
        tableData: [],
      },
      editreturnjson: {
        dailypaperid:null,
        dailypaperdate: "",
        projectschedules: [],
        checkeduser: [],
        tableData: [],
      },
    };
  },
  mounted: function () {
    this.initdailypapers();
    this.initproject();
    this.initusers();
    this.returnjson.dailypaperdate = new Date();
  },
  methods: {
    initdailypapers() {
      axios({
        url: "dailypaper/get_dailypapers/",
        method: "post",
      }).then((res) => {
        this.tableData = res.data.dailypapers;
        this.tableDailypaperDetail = res.data.dailypaperdetails;
        this.tableDailypaperDetail.forEach((element) => {
          if (element.projectscheduleid == -1) {
            element.projectname = "自我学习";
          }
        });
      });
    },
    initproject() {
      axios({
        url: "dailypaper/get_projects/",
        method: "post",
      }).then((res) => {
        //console.log(res.data);
        this.projectschedulelist = res.data;
        this.projectschedulelist.push({
          projectscheduleid: -1,
          projectname: "自我学习",
        });
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
    cleardailypaperForm(){
      this.$refs["dailypaperForm"].clearValidate();
      this.returnjson.dailypaperdate = new Date();
      this.returnjson.projectschedules = [];
      this.returnjson.checkeduser = [];
      this.returnjson.tableData = [];
    },
    submitdailypaper() {
      this.$refs["dailypaperForm"].validate((valid) => {
        if (valid) {
          axios({
            url: "dailypaper/create_dailypaper/",
            data: this.returnjson,
            method: "post",
          }).then((res) => {
            if(res.data != "OK"){
              alert(res.data);
            }
            else{
              this.initdailypapers();
              this.dialogVisible = false;
            }
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    submiteditdailypaper(){
      this.$refs["editdailypaperForm"].validate((valid) => {
        if (valid) {
          axios({
            url: "dailypaper/edit_dailypaper/",
            data: this.editreturnjson,
            method: "post",
          }).then((res) => {
            if(res.data != "OK"){
              alert(res.data);
            }
            else{
              this.initdailypapers();
              this.editDialogVisible = false;
            }
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    handleClose(done) {
      done();
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleEdit(index, row){
      this.editreturnjson.dailypaperid = null;
      this.editreturnjson.dailypaperdate = "";
      this.editreturnjson.projectschedules = [];
      this.editreturnjson.checkeduser = [];
      this.editreturnjson.tableData = [];

      this.editDialogVisible = true;
      let param = new URLSearchParams();
      param.append("dailypaperid", row.dailypaperid);
      axios({
            url: "dailypaper/get_dailypaperbyid/",
            data: param,
            method: "post",
          }).then((res) => {
            console.log(res.data);
            this.editreturnjson.dailypaperid = res.data[0].dailypaperid;
            this.editreturnjson.dailypaperdate = res.data[0].dailypaperdate.split('T')[0];
            res.data.forEach(element => {
              if(element.projectscheduleid == -1){
                element.projectname="自我学习";
              }
              this.editreturnjson.projectschedules.push(element.projectscheduleid);
              this.editreturnjson.tableData.push(element);
            });

            this.editoldprojectschedules = this.editreturnjson.projectschedules;
            res.data[0].receptionistids.split(',').forEach(element => {
              this.editreturnjson.checkeduser.push(parseInt(element));
            });

          });
    },
    history() {
      this.returnjson.businesses = [];
      this.returnjson.checkeduser = [];
      this.returnjson.tableData = [];
      axios({
        url: "dailypaper/get_history/",
        method: "post",
      }).then((res) => {
        res.data.forEach((element) => {
          if(element.projectscheduleid == -1){
              element.projectschedulename="自我学习";
          }
          console.log(element);
          this.returnjson.projectschedules.push(element.projectscheduleid);
          this.returnjson.tableData.push(element);
        });

        res.data[0].receptionistids.split(",").forEach((element) => {
          this.returnjson.checkeduser.push(parseInt(element));
        });
      });
    },
    editprojectschedulechange(){
      //debugger
      this.editoldprojectschedules.forEach((element) => {
        var flag = 0;
        this.editreturnjson.projectschedules.forEach((element1) => {
          if (element == element1) {
            flag = 1;
          }
        });
        if (flag == 0) {
          var index = 0;
          this.editreturnjson.tableData.forEach((element3) => {
            if (element3.projectscheduleid == element) {
              this.editreturnjson.tableData.splice(index, 1);
            }
            index++;
          });
        }
      });
      this.editoldprojectschedules = this.editreturnjson.projectschedules;

      this.editreturnjson.projectschedules.forEach((element) => {
        if (document.getElementById("projectschedule_" + element) == null) {
          var projectschedulename = "";
          this.projectschedulelist.forEach((element1) => {
            if (element == element1.projectscheduleid) {
              projectschedulename = element1.projectname;
            }
          });

          var exist = 0;
          this.editreturnjson.tableData.forEach((element2) => {
            if (element == element2.projectscheduleid) {
              exist = 1;
            }
          });

          if (exist == 0) {
            var node = {
              projectscheduleid: element,
              projectname: projectschedulename,
              worktime: null,
              workcontent: null,
            };
            this.editreturnjson.tableData.push(node);
          }
        }
      });

      this.editreturnjson.checkeduser = [];
      let param = new URLSearchParams();
      param.append("projectscheduleids", this.editreturnjson.projectschedules);
      axios({
        url: "dailypaper/get_receptionists/",
        method: "post",
        data: param,
      }).then((res) => {
        res.data.forEach((element) => {
          var flag = 0;
          this.editreturnjson.checkeduser.forEach((element1) => {
            if (element.userid == element1) {
              flag = 1;
            }
          });
          if (flag == 0) {
            this.editreturnjson.checkeduser.push(element.userid);
          }
        });
      });
    },
    projectschedulechange() {
      this.oldprojectschedules.forEach((element) => {
        var flag = 0;
        this.returnjson.projectschedules.forEach((element1) => {
          if (element == element1) {
            flag = 1;
          }
        });
        if (flag == 0) {
          var index = 0;
          this.returnjson.tableData.forEach((element3) => {
            if (element3.projectscheduleid == element) {
              this.returnjson.tableData.splice(index, 1);
            }
            index++;
          });
        }
      });
      this.oldprojectschedules = this.returnjson.projectschedules;

      this.returnjson.projectschedules.forEach((element) => {
        if (document.getElementById("projectschedule_" + element) == null) {
          var projectschedulename = "";
          this.projectschedulelist.forEach((element1) => {
            if (element == element1.projectscheduleid) {
              projectschedulename = element1.projectname;
            }
          });

          var exist = 0;
          this.returnjson.tableData.forEach((element2) => {
            if (element == element2.projectscheduleid) {
              exist = 1;
            }
          });

          if (exist == 0) {
            var node = {
              projectscheduleid: element,
              projectschedulename: projectschedulename,
              worktime: null,
              workcontent: null,
            };

            this.returnjson.tableData.push(node);
          }
        }
      });

      this.returnjson.checkeduser = [];
      let param = new URLSearchParams();
      param.append("projectscheduleids", this.returnjson.projectschedules);
      axios({
        url: "dailypaper/get_receptionists/",
        method: "post",
        data: param,
      }).then((res) => {
        res.data.forEach((element) => {
          var flag = 0;
          this.returnjson.checkeduser.forEach((element1) => {
            if (element.userid == element1) {
              flag = 1;
            }
          });
          if (flag == 0) {
            this.returnjson.checkeduser.push(element.userid);
          }
        });
      });
    },
  },
};
</script>