<template>
  <div>
    <el-table
      :data="
        tableData.slice(
          (limitePage.page - 1) * limitePage.limit,
          limitePage.limit * limitePage.page
        )
      "
      style="width: 100%"
    >
      <el-table-column prop="leavetype" label="请假类型" width="180">
      </el-table-column>
      <el-table-column prop="applicant" label="请假人" width="180">
      </el-table-column>
      <el-table-column prop="leavereason" label="请假理由" width="180">
      </el-table-column>
      <el-table-column prop="starttime" label="开始日期" width="180">
        <template slot-scope="scope">{{
          scope.row.starttime | dateYMDHMSFormat
        }}</template>
      </el-table-column>
      <el-table-column prop="finishtime" label="结束日期" width="180">
        <template slot-scope="scope">{{
          scope.row.finishtime | dateYMDHMSFormat
        }}</template>
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
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleAudit(scope.$index, scope.row)"
            ><i class="el-icon-edit"></i>审批</el-button
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

    <el-dialog title="审批" :visible.sync="auditDialogVisible" width="550px">
      <table style="margin-left: 7px">
        <tr>
          <td>申请人:</td>
          <td>{{ auditformdata.uname }}</td>
        </tr>
        <tr>
          <td>请假理由:</td>
          <td>{{ auditformdata.leavereason }}</td>
        </tr>
        <tr>
          <td>请假时长:</td>
          <td>待开发</td>
        </tr>
        <tr>
          <td>开始时间:</td>
          <td>{{ auditformdata.starttime }}</td>
        </tr>
        <tr>
          <td>结束时间:</td>
          <td>{{ auditformdata.finishtime }}</td>
        </tr>
        <tr>
          <td colspan="2">
            <el-steps
              :active="auditformdata.active"
              finish-status="success"
              style="width: 500px"
            >
              <el-step
                v-for="(item, flownodeid) in auditformdata.flowuserlists"
                :key="flownodeid"
                :title="item.flownodename"
                :description="item.uname"
              ></el-step>
            </el-steps>
          </td>
        </tr>
        <tr><td colspan="2">
          <el-input
            type="textarea"
            placeholder="请填写审批意见"
            v-model="auditformdata.auditinfo"
          ></el-input>
          </td></tr>
      </table>
      <span slot="footer" class="dialog-footer">
        <el-button @click="auditDialogVisible = false">取 消</el-button>
        <el-button type="danger" @click="rejectleave()">驳 回</el-button>
        <el-button type="primary" @click="approveleave()">同 意</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "Default",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      //   positiontypeData: [],
      //   dialogVisible: false,
      auditDialogVisible: false,
      labelPosition: "right",
      //   multipleSelection: [],
      //   editformdata: {
      //     name: "",
      //     phone: "",
      //     email: "",
      //     isactive: 1,
      //     id: 0,
      //     positiontype: 0,
      //   },
      auditformdata: {
        leaveid:null,
        leavereason: "",
        leavetype: null,
        timerange: null,
        active: null,
        flowuserlists: [],
        currentnode:null,
        auditinfo:""
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    //console.log(this.permissions);
    this.initaudits(); //需要触发的函数
    // this.positiontypes();
  },
  methods: {
    initaudits() {
      axios({
        url: "audit/get_audits",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
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
    handleAudit(index, row) {
      this.auditDialogVisible = true;
      let param = new URLSearchParams();
      param.append("leaveid", row.leaveid);
      axios({
        url: "leaveflow/get_leave_byid/",
        method: "post",
        data: param,
      }).then((res) => {
        this.auditformdata = res.data[0];
      });
    },
    approveleave(){
      axios({
        url: "audit/approve_leave/",
        method: "post",
        data: this.auditformdata,
      }).then((res) => {
        this.initaudits();
      });
    },
    rejectleave(){
      axios({
        url: "audit/reject_leave/",
        method: "post",
        data: this.auditformdata,
      }).then((res) => {
        this.initaudits();
      });
    }
  },
};
</script>