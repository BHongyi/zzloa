<template>
  <div>
    <el-row>
      <el-date-picker
        v-model="dailypaperdate"
        type="date"
        value-format="yyyy-MM-dd"
        placeholder="选择日期"
        @change="datachange()"
      >
      </el-date-picker>
      <el-button @click="expandall()"
        ><i class="el-icon-folder-opened"></i>展开/合上(全部)</el-button
      >
    </el-row>
    <el-table
      :data="tableData"
      style="width: 100%"
      :expand-row-keys="expandrowkeys"
      row-key="dailypaperid"
      @expand-change="exChange"
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
            <el-table-column prop="businessname" label="商机名" width="200">
            </el-table-column>
            <el-table-column
              prop="isimportant"
              v-if="props.row.positiontype == 2"
              label="重要活动"
              width="100"
            >
              <template slot-scope="scope">
                <span v-if="scope.row.isimportant == 1">是</span>
                <span v-else>否</span>
              </template>
            </el-table-column>
            <el-table-column prop="worktime" label="用时(单位:h)" width="120">
            </el-table-column>
            <el-table-column
              prop="cost"
              label="费用(单位:元)"
              v-if="props.row.positiontype == 2"
              width="120"
            >
            </el-table-column>
            <el-table-column
              prop="contactname"
              v-if="props.row.positiontype == 2"
              label="联系人"
              width="100"
            >
            </el-table-column>
            <el-table-column prop="workcontent" label="工作内容">
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column width="50">
        <template slot-scope="scope">
          <i v-if="scope.row.isread == 1" class="el-icon-folder-opened"></i>
          <i v-else class="el-icon-folder"></i>
        </template>
        <i v-if="tableData.isread == 1" class="el-icon-folder-opened"></i>
        <i v-else class="el-icon-folder"></i>
      </el-table-column>
      <el-table-column prop="writer" label="发送人" width="180">
      </el-table-column>
      <el-table-column prop="receptionists" label="接收人" style="width: 25%">
      </el-table-column>
      <el-table-column
        prop="readreceptionists"
        label="已读接收人"
        style="width: 25%"
      >
      </el-table-column>
      <el-table-column prop="createtime" label="提交日期">
        <template slot-scope="scope">{{
          scope.row.createtime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
    </el-table>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "ReadDailypaperBydate",
  data() {
    return {
      dailypaperdate:
        new Date().getFullYear() +
        "-" +
        (new Date().getMonth() + 1) +
        "-" +
        new Date().getDate(),
      tableData: [],
      total: null,
      currentnode: null,
      tableDailypaperDetail: [],
      expandrowkeys: [],
      unexpandrowkeys: [],
    };
  },
  mounted: function () {
    this.initdailypapers();
  },
  methods: {
    initdailypapers() {
      let param = new URLSearchParams();
      param.append("dailypaperdate", this.dailypaperdate);
      axios({
        url: "dailypaper/load_userdailypaper_bydate/",
        method: "post",
        data: param,
      }).then((res) => {
        this.tableData = res.data.dailypapers;
        this.unexpandrowkeys = [];
        this.tableDailypaperDetail = res.data.dailypaperdetails_business;
        this.tableDailypaperDetail.forEach((element) => {
          this.unexpandrowkeys.push(element.dailypaperid);
          if (element.businessid == -1) {
            element.businessname = "自我学习";
          }
        });
        res.data.dailypaperdetails_dev.forEach((element) => {
          this.unexpandrowkeys.push(element.dailypaperid);
          element["contactname"] = "";
          element["cost"] = "";
          if (element.projectscheduleid == -1) {
            element.businessname = "自我学习";
          } else {
            element.businessname = element.projectname;
          }
          this.tableDailypaperDetail.push(element);
        });
      });
    },
    datachange() {
      this.initdailypapers();
    },
    expandall() {
      if (this.expandrowkeys.length > 0) {
        this.expandrowkeys = [];
      } else {
        this.expandrowkeys = this.unexpandrowkeys;
        let param = new URLSearchParams();
        param.append("dailypaperids", this.unexpandrowkeys);
        axios({
          url: "dailypaper/readdailypaper_list/",
          method: "post",
          data: param,
        }).then((res) => {
          this.tableData.forEach((element) => {
            element.isread = 1;
            if (element.readreceptionists == null) {
              element.readreceptionists = sessionStorage.getItem("uname");
            } else {
              if (
                element.readreceptionists.indexOf(
                  sessionStorage.getItem("uname")
                ) > -1
              ) {
              } else {
                element.readreceptionists =
                  element.readreceptionists +
                  "," +
                  sessionStorage.getItem("uname");
              }
            }
          });
        });
      }
    },
    exChange(row, rowList) {
      if (row.isread == 0) {
        let param = new URLSearchParams();
        param.append("dailypaperid", row.dailypaperid);
        axios({
          url: "dailypaper/readdailypaper_byid/",
          method: "post",
          data: param,
        }).then((res) => {
          row.isread = 1;
          if (row.readreceptionists == null) {
            row.readreceptionists = sessionStorage.getItem("uname");
          } else {
            row.readreceptionists =
              row.readreceptionists + "," + sessionStorage.getItem("uname");
          }
        });
      }
    },
  },
};
</script>