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
        >
          <el-table-column width="50">
            <i class="el-icon-folder-opened"></i>
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
  </div>
</template>

<style>
.el-badge__content.is-fixed {
  top: 5px;
  right: 5px;
}
.el-badge__content {
  font-size: 6px;
  height: 10px;
  line-height: 12px;
  padding: 0 2px;
}
</style>

<script>
import axios from "../utils/httpRequest";
export default {
  name: "ReadDailyPaper",
  data() {
    return {
      treeData: [],
      userlist: [],
      limitePage: {
        limit: 5,
        page: 1,
      },
      tableData: [],
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
            groupid: "user_" + element.id,
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
    handleSizeChange(val) {
      this.limitePage.limit = val;
    },
    handleCurrentChange(val) {
      this.limitePage.page = val;
    },
    handleNodeClick(data) {
      if ((data.groupid + "").indexOf("user") != -1) {
        let param = new URLSearchParams();
        param.append("userid", data.groupid.split('_')[1]);
        axios({
          url: "dailypaper/load_userdailypaper/",
          method: "post",
          data: param,
        }).then((res) => {
          //this.initgroups();
          this.tableData = res.data;
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
            v-show={(node.key + "").indexOf("user") != -1 ? "ok" : ""}
            value="5"
            size="mini"
            class="item"
          >
            {node.label}
          </el-badge>
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