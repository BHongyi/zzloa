<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="6">
        <span style="font-size: 14px; color: darkgrey"
          >*新建部门后需修改保存才可以新建</span
        >
        <el-tree
          :data="treeData"
          node-key="id"
          default-expand-all
          :expand-on-click-node="false"
          :render-content="renderContent"
          @node-click="handleNodeClick"
        >
        </el-tree>
      </el-col>
      <el-col :span="12">
        <el-button
          @click="setmanager()"
          type="primary"
          v-if="this.permissions.indexOf('000009') != -1"
          ><i class="el-icon-s-custom"></i>设为部门经理</el-button
        >
        <el-transfer
          filterable
          :filter-method="filterMethod"
          filter-placeholder="请输入姓名"
          v-model="value"
          :titles="titles"
          :data="userlist"
          @change="handleChange"
          @left-check-change="leftcheckchange"
          ref="transfer"
        >
        </el-transfer>
      </el-col>
    </el-row>

    <el-dialog title="部门编辑" :visible.sync="dialogVisible" width="25%">
      <el-form name="editdeptform" ref="editdeptform" label-width="90px" :model="editformdata">
        <el-form-item
          label="部门名称"
          prop="deptname"
          :rules="[
            { required: true, message: '部门名不能为空', trigger: 'blur' },
          ]"
        >
          <el-input v-model="editformdata.deptname"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editgroup()">保 存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<style>
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
  name: "GroupManage",
  data() {
    return {
      treeData: [],
      editformdata: {
        parentid: "",
        deptname: "",
        id: 0,
      },
      dialogVisible: false,
      currentgroupid: 0,
      userlist: [],
      managerlist: [],
      value: [],
      valueleft: [],
      titles: ["部门用户", "非部门用户"],
      filterMethod(query, item) {
        return item.label.indexOf(query) > -1;
      },
    };
  },
  props: {
    permissions: String,
  },
  mounted: function () {
    this.initgroups(); //需要触发的函数
    this.initusers();
    this.setpermission();
  },
  methods: {
    initgroups() {
      axios({
        url: "groupmanage/get_groups/",
        method: "get",
        data: {},
      }).then((res) => {
        this.treeData = res.data.children;
      });
    },
    initusers() {
      axios({
        url: "usermanage/get_users/",
        method: "get",
        data: {},
      }).then((res) => {
        res.data.forEach((element) => {
          this.userlist.push({
            label: element.name,
            key: element.id,
          });
          this.value.push(element.id);
        });
      });
    },
    setpermission() {
      if (this.permissions.indexOf("000009") != -1) {
      } else {
        this.$refs.transfer.$children[1].$el.style.display = "none";
        this.$refs.transfer.$children[2].$el.style.display = "none";
        this.$refs.transfer.$children[3].$el.style.display = "none";
      }
    },
    handleChange(value, direction, movedKeys) {
      //console.log(value, direction, movedKeys);
      let param = new URLSearchParams();
      param.append("groupid", this.currentgroupid);
      param.append("movedKeys", movedKeys);

      if (direction == "left") {
        axios({
          url: "groupmanage/group_add_user/",
          method: "post",
          data: param,
        }).then((res) => {
          movedKeys.forEach((element) => {
            this.valueleft.push(element);
          });
        });
      } else {
        axios({
          url: "groupmanage/group_delete_user/",
          method: "post",
          data: param,
        }).then((res) => {
          movedKeys.forEach((element) => {
            for (var i; i < this.valueleft.length; i++) {
              if (element == this.valueleft[i]) {
                this.valueleft.splice(i, 1);
              }
            }
          });
        });
      }
    },
    handleNodeClick(data) {
      for (var i = 0; i < this.valueleft.length; i++) {
        this.value.push(this.valueleft[i]);
      }
      this.valueleft = [];
      let param = new URLSearchParams();
      param.append("groupid", data.groupid);
      this.currentgroupid = data.groupid;
      axios({
        url: "groupmanage/get_group_user/",
        method: "post",
        data: param,
      }).then((res) => {
        res.data.forEach((element) => {
          for (var i = 0; i < this.value.length; i++) {
            if (element.id == this.value[i]) {
              this.value.splice(i, 1);
              this.valueleft.push(element.id);
            }
          }
        });
      });
    },
    append(data) {
      const newChild = {
        label: "新建部门",
        parentid: data.groupid,
        children: [],
      };
      if (!data.children) {
        this.$set(data, "children", []);
      }
      data.children.push(newChild);
    },
    edit(data) {
      this.dialogVisible = true;
      this.editformdata.deptname = data.label.split('(')[0];
      this.editformdata.id = data.groupid;
      this.editformdata.parentid = data.parentid;
    },
    remove(node, data) {
      this.$confirm("确认删除？")
        .then((_) => {
          let param = new URLSearchParams();
          param.append("groupid", data.groupid);
          axios({
            url: "groupmanage/delete_group/",
            method: "post",
            data: param,
          }).then((res) => {
            this.initgroups();
          });
        })
        .catch((_) => {
          return;
        });
    },
    editgroup() {
      this.$refs["editdeptform"].validate((valid) => {
        if (valid) {
          let param = new URLSearchParams();
          param.append("groupid", this.editformdata.id);
          param.append("name", this.editformdata.deptname);
          param.append("parentid", this.editformdata.parentid);

          axios({
            url: "groupmanage/edit_group/",
            method: "post",
            data: param,
          }).then((res) => {
            this.dialogVisible = false;
            this.initgroups();
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    leftcheckchange(val) {
      this.managerlist = val;
    },
    setmanager() {
      if (this.managerlist.length < 1) {
        alert("请选择用户");
      } else if (this.managerlist.length == 1) {
        let param = new URLSearchParams();
        param.append("groupid", this.currentgroupid);
        param.append("userid", this.managerlist[0]);
        axios({
          url: "groupmanage/setmanager/",
          method: "post",
          data: param,
        }).then((res) => {
          this.initgroups();
        });
      } else {
        alert("部门经理只能为一人，请选择一个用户");
      }
    },
    renderContent(h, { node, data, store }) {
      return (
        <span class="custom-tree-node">
          <span>{node.label}</span>
          <span>
            <el-button
              size="mini"
              type="text"
              v-show={this.permissions.indexOf("000007") != -1 ? "ok" : ""}
              name="addgroup"
              on-click={() => this.append(data)}
            >
              <i class="el-icon-circle-plus-outline"></i>
            </el-button>
            <el-button
              size="mini"
              type="text"
              v-show={this.permissions.indexOf("000009") != -1 ? "ok" : ""}
              name="editgroup"
              on-click={() => this.edit(data)}
            >
              <i class="el-icon-edit"></i>
            </el-button>
            <el-button
              size="mini"
              type="text"
              v-show={this.permissions.indexOf("000008") != -1 & node.level != 1 ? "ok" : ""}
              name="deletegroup"
              on-click={() => this.remove(node, data)}
            >
              <i class="el-icon-delete"></i>
            </el-button>
          </span>
        </span>
      );
    },
  },
};
</script>