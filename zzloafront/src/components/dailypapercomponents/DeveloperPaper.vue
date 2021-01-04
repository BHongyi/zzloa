<template>
  <div>
    <table>
      <tr>
        <td>选择项目:</td>
        <td>
          <el-select
            v-model="projectschedules"
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
        </td>
      </tr>
      <tr>
        <td>接收人：</td>
        <td>
          <el-select
            v-model="checkeduser"
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
        </td>
      </tr>
      <tr>
        <td>工作内容:</td>
        <td style="width: 800px">
          <el-table :data="tableData" empty-text="请选择项目" style="width: 100%">
            <el-table-column
              prop="projectschedulename"
              label="项目-阶段"
              width="180"
            >
            </el-table-column>
            <el-table-column prop="worktime" label="工时(单位:h)" width="180">
              <template slot-scope="scope">
                <el-select v-model="scope.row.worktime" placeholder="请选择">
                  <el-option
                    v-for="item in timelist"
                    :key="item.id"
                    :value="item.id"
                    :label="item.name"
                  ></el-option>
                </el-select>
              </template>
            </el-table-column>
            <el-table-column prop="workcontent" label="工作内容">
              <template slot-scope="scope1">
                <el-input v-model="scope1.row.workcontent" type="textarea" style="width: 420px"></el-input>
              </template>
            </el-table-column>
          </el-table>
          
        </td>
      </tr>
      <tr><td colspan="2" style="text-align:right;">
        <el-button type="primary" @click="submitdailypaper()">提交</el-button>
        </td></tr>
    </table>
  </div>
</template>

<style>
ul {
  list-style: none;
}
</style>

<script>
import axios from "../../utils/httpRequest";
export default {
  name: "DeveloperPaper",
  data() {
    return {
      tableData: [],
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
      projectschedules: [],
      oldprojectschedules: [],
      receptionists: "",
      userlist: [],
      checkeduser: [],
    };
  },
  mounted: function () {
    this.initproject();
    this.initusers();
  },
  methods: {
    initproject() {
      axios({
        url: "dailypaper/get_projects/",
        method: "post",
      }).then((res) => {
        this.projectschedulelist = res.data;
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
    submitdailypaper() {
      console.log(this.tableData);
    },
    projectschedulechange() {

      this.oldprojectschedules.forEach((element) => {
        var flag = 0;
        this.projectschedules.forEach((element1) => {
          if (element == element1) {
            flag = 1;
          }
        });
        if (flag == 0) {
          var index = 0;
          this.tableData.forEach(element3 => {
            if(element3.projectscheduleid == element){
              this.tableData.splice(index,1);
            }
            index++;
          });
        }
      });
      this.oldprojectschedules = this.projectschedules;

      this.projectschedules.forEach((element) => {
        if (document.getElementById("projectschedule_" + element) == null) {
          var projectschedulename = "";
          this.projectschedulelist.forEach((element1) => {
            if (element == element1.projectscheduleid) {
              projectschedulename = element1.projectname;
            }
          });

          var exist = 0;
          this.tableData.forEach((element2) => {
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

            this.tableData.push(node);
          }
        }
      });

      this.checkeduser = [];
      let param = new URLSearchParams();
      param.append("projectscheduleids", this.projectschedules);
      axios({
        url: "dailypaper/get_receptionists/",
        method: "post",
        data: param,
      }).then((res) => {
        res.data.forEach((element) => {
          var flag = 0;
          this.checkeduser.forEach((element1) => {
            if (element.userid == element1) {
              flag = 1;
            }
          });
          if (flag == 0) {
            this.checkeduser.push(element.userid);
          }
        });
      });
    },
  },
};
</script>