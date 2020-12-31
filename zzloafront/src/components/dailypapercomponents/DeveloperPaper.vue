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
            style="width:500px;"
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
            style="width:500px;"
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
      projectschedulelist: [],
      projectschedules: [],
      receptionists:"",
      userlist:[],
      checkeduser:[]
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
      //console.log(sessionStorage.getItem('token'));
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
  },
};
</script>