<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="6">
        <el-tree
          :data="treeData"
          node-key="groupid"
          ref="tree"
          default-expand-all
          :expand-on-click-node="false"
          :render-content="renderContent"
          @node-click="handleNodeClick"
        >
        </el-tree>
      </el-col>
      <el-col :span="14">
        <el-table
          :data="
            tableData.slice(
              (limitePage.page - 1) * limitePage.limit,
              limitePage.limit * limitePage.page
            )
          "
          style="width: 100%"
          @row-click="openDetails"
        >
          <el-table-column width="50">
            <template slot-scope="scope">
              <i v-if="scope.row.isread == 1" class="el-icon-folder-opened"></i>
              <i v-else class="el-icon-folder"></i>
            </template>
            <i v-if="tableData.isread == 1" class="el-icon-folder-opened"></i>
            <i v-else class="el-icon-folder"></i>
          </el-table-column>
          <el-table-column prop="dailypaperdate" label="日报日期" width="180">
            <template slot-scope="scope">{{
              scope.row.dailypaperdate | dateYMDHMSFormat
            }}</template>
          </el-table-column>
          <el-table-column prop="createtime" label="提交日期" width="180">
            <template slot-scope="scope">{{
              scope.row.createtime | dateYMDHMSFormat
            }}</template>
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
      </el-col>
    </el-row>

    <el-dialog title="日报查看" :visible.sync="dialogVisible" width="40%">
      <table style="margin-left: 7px">
        <tr>
          <td>接收人:</td>
          <td>{{ dailypaperdata.receptionists }}</td>
        </tr>
        <tr>
          <td>日报日期:</td>
          <td>{{ dailypaperdata.dailypaperdate | dateYMDHMSFormat }}</td>
        </tr>
        <tr>
          <td>创建日期:</td>
          <td>{{ dailypaperdata.createdate }}</td>
        </tr>
      </table>
      <el-table :data="dailypaperdetail" style="width: 100%">
        <el-table-column prop="projectname" label="项目-阶段名" width="180">
        </el-table-column>
        <el-table-column prop="worktime" label="工时(单位:h)" width="180">
        </el-table-column>
        <el-table-column prop="workcontent" label="工作内容" width="300">
        </el-table-column>
      </el-table>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">关 闭</el-button>
      </span>
    </el-dialog>

    <el-dialog title="日报查看" :visible.sync="saleDialogVisible" width="50%">
      <table style="margin-left: 7px">
        <tr>
          <td>接收人:</td>
          <td>{{ dailypaperdata.receptionists }}</td>
        </tr>
        <tr>
          <td>日报日期:</td>
          <td>{{ dailypaperdata.dailypaperdate | dateYMDHMSFormat }}</td>
        </tr>
        <tr>
          <td>创建日期:</td>
          <td>{{ dailypaperdata.createdate }}</td>
        </tr>
      </table>
      <el-table :data="dailypaperdetail" style="width: 100%">
        <el-table-column prop="businessname" label="商机名" width="180">
        </el-table-column>
        <el-table-column prop="worktime" label="工时(单位:h)" width="120">
        </el-table-column>
        <el-table-column prop="contactid" label="联系人" width="100">
        </el-table-column>
        <el-table-column prop="cost" label="费用(单位:元)" width="120">
        </el-table-column>
        <el-table-column prop="workcontent" label="工作内容" width="280">
        </el-table-column>
      </el-table>
      <span slot="footer" class="dialog-footer">
        <el-button @click="saleDialogVisible = false">关 闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
.el-badge__content.is-fixed {
  top: 5px !important;
  right: 5px !important;
}
.el-badge__content {
  font-size: 6px !important;
  height: 10px !important;
  line-height: 12px !important;
  padding: 0 2px !important;
}

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-right: 8px;
}

.el-tree-node.is-current > .el-tree-node__content {
  background-color: #c2d6ea !important;
}
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "ReadDailyPaper",
  data() {
    return {
      dialogVisible: false,
      saleDialogVisible:false,
      treeData: [],
      userlist: [],
      positiontype: null,
      limitePage: {
        limit: 10,
        page: 1,
      },
      tableData: [],
      dailypaperdata: {
        receptionists: null,
        dailypaperdate: "",
        createdate: "",
      },
      dailypaperdetail: [],
    };
  },
  mounted: function () {
    this.initorganization();
  },
  methods: {
    initorganization() {
      axios({
        url: "dailypaper/get_organization/",
        method: "get",
      }).then((res) => {
        this.treeData = res.data.grouptree.children;
        this.userlist = res.data.users;
        this.recursion(this.treeData[0]);
      });
    },
    recursion(node) {
      this.userlist.forEach((element) => {
        if (element.groupid == node.groupid) {
          let newChild = {
            label: element.name,
            parentid: node.groupid,
            groupid: "user_" + element.id + "_" + element.count,
            children: [],
          };
          node.children.unshift(newChild);
        }
      });
      if (!node.children) {
        //先判断 node节点是否含有children节点，为true 为最后一级，取id ，push到arr数组中
        //arr.push(node.id);
      } else {
        // false时 非最后一级，含有children，则继续循环children

        node.children.forEach((item) => this.recursion(item));
      }
    },
    openDetails(row) {
      row.isread = 1;
      let param = new URLSearchParams();
      param.append("dailypaperid", row.dailypaperid);

      if (this.positiontype == 1) {
        axios({
          url: "dailypaper/read_dailypaperdetail/",
          method: "post",
          data: param,
        }).then((res) => {
          this.dialogVisible = true;
          res.data.forEach((element) => {
            if (element.projectscheduleid == -1) {
              element.projectname = "自我学习";
            }
          });
          this.dailypaperdetail = res.data;
          this.dailypaperdata.receptionists = res.data[0].receptionists;
          this.dailypaperdata.dailypaperdate = res.data[0].dailypaperdate;
          this.dailypaperdata.createdate = res.data[0].createtime.replace(
            "T",
            " "
          );
          this.initorganization();
        });
      }
      else if(this.positiontype == 2){
        axios({
          url: "dailypapersale/read_dailypaperdetail/",
          method: "post",
          data: param,
        }).then((res) => {
          this.saleDialogVisible = true;
          res.data.forEach((element) => {
            if (element.businessid == -1) {
              element.businessname = "自我学习";
            }
          });
          this.dailypaperdetail = res.data;
          this.dailypaperdata.receptionists = res.data[0].receptionists;
          this.dailypaperdata.dailypaperdate = res.data[0].dailypaperdate;
          this.dailypaperdata.createdate = res.data[0].createtime.replace(
            "T",
            " "
          );
          this.initorganization();
        });
      }
    },
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleNodeClick(data) {
      if ((data.groupid + "").indexOf("user") != -1) {
        let param = new URLSearchParams();
        param.append("userid", data.groupid.split("_")[1]);
        axios({
          url: "dailypaper/load_userdailypaper/",
          method: "post",
          data: param,
        }).then((res) => {
          this.tableData = res.data.dailypapers;
          this.positiontype = res.data.positiontype;
        });
      }
    },
    renderContent(h, { node, data, store }) {
      return (
        <span>
          <i
            v-show={(node.key + "").indexOf("user") != -1 ? "ok" : ""}
            class="el-icon-user"
          ></i>
          <el-badge
            v-show={
              ((node.key + "").indexOf("user") != -1) &
              ((node.key + "").split("_")[2] != 0)
                ? "ok"
                : ""
            }
            value={(node.key + "").split("_")[2]}
            size="mini"
            class="item"
          >
            {node.label}
          </el-badge>
          <span
            v-show={
              ((node.key + "").indexOf("user") != -1) &
              ((node.key + "").split("_")[2] == 0)
                ? "ok"
                : ""
            }
          >
            {node.label}
          </span>
          <i
            v-show={(node.key + "").indexOf("user") == -1 ? "ok" : ""}
            class="el-icon-s-home"
          ></i>
          <span v-show={(node.key + "").indexOf("user") == -1 ? "ok" : ""}>
            {node.label}
          </span>
        </span>
      );
    },
  },
};
</script>