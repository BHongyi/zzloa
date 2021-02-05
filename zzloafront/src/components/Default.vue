<template>
  <div>
    <el-calendar v-model="value">
    </el-calendar>
    </div>
</template>

<style>
.el-calendar-table td.is-selected{
  /* background-color: #F2F8FE; */
  background-color: #c5def7 !important;
}

.el-backtop, .el-calendar-table td.is-today{
  /* color: #409EFF; */
  color: #0d75dd !important;
}
</style>

<script>
export default {
  name: "Default",
  data() {
      return {
        value: new Date()
      }
  }
};
</script>