<template>
  <div>
    <el-row>
      <el-button
        @click="dialogVisible = true"
        v-if="this.permissions.indexOf('000002') != -1"
        ><i class="el-icon-plus"></i>请假</el-button
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
      <el-table-column prop="leavetype" label="请假类别" width="180">
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

    <el-dialog title="请假申请" :visible.sync="dialogVisible" width="550px">
      <el-form
        name="createleaveform"
        :label-position="labelPosition"
        label-width="90px"
        :model="createformdata"
        ref="createleaveform"
      >
        <el-form-item
          label="岗位类别"
          prop="leavetype"
          :rules="[
            { required: true, message: '岗位类别不能为空', trigger: 'blur' },
          ]"
        >
          <el-select v-model="createformdata.leavetype" placeholder="请选择">
            <el-option
              v-for="item in leavetypeData"
              :key="item.typeid"
              :label="item.typename"
              :value="item.typeid"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="请假时间"
          prop="timerange"
          :rules="[
            { required: true, message: '请假时间不能为空', trigger: 'blur' },
          ]"
        >
          <el-date-picker
            v-model="createformdata.timerange"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item
          label="请假理由"
          prop="leavereason"
          :rules="[
            { required: true, message: '请假理由不能为空', trigger: 'blur' },
          ]"
        >
          <el-input
            type="textarea"
            v-model="createformdata.leavereason"
          ></el-input>
        </el-form-item>
      </el-form>

      <el-steps :active="0" finish-status="success">
        <el-step
          v-for="(item, flownodeid) in createformdata.flowuserlists"
          :key="flownodeid"
          :title="item.flownodename"
          :description="item.uname"
        ></el-step>
      </el-steps>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="createleave()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "LeaveFlow",
  data() {
    return {
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      leavetypeData: [],
      dialogVisible: false,
      //   editDialogVisible: false,
      labelPosition: "right",
      multipleSelection: [],
      //   editformdata: {
      //     name: "",
      //     phone: "",
      //     email: "",
      //     isactive: 1,
      //     id: 0,
      //     positiontype: 0,
      //   },
      createformdata: {
        leavereason: "",
        leavetype: null,
        timerange:null,
        flowuserlists: [],
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.leaves(); //需要触发的函数
    this.leavetypes();
    this.initflow();
  },
  methods: {
    leaves() {
      axios({
        url: "leaveflow/get_leaves/",
        method: "get",
        data: {},
      }).then((res) => {
        this.tableData = res.data;
        this.total = res.data.length;
      });
    },
    leavetypes() {
      axios({
        url: "leaveflow/get_leavetypes/",
        method: "get",
        data: {},
      }).then((res) => {
        this.leavetypeData = res.data;
      });
    },
    initflow() {
      axios({
        url: "leaveflow/get_flowuserlists/",
        method: "get",
        data: {},
      }).then((res) => {
        this.createformdata.flowuserlists = res.data;
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    createleave(){
        this.$refs["createleaveform"].validate((valid) => {
        if (valid) {
          axios({
            url: "leaveflow/create_leave/",
            method: "post",
            data: this.createformdata,
          }).then((res) => {
            this.dialogVisible = false;
            this.leaves();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    }
  },
};
</script>