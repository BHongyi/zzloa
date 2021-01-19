<template>
  <div>
    <el-calendar v-model="value">
    </el-calendar>
    </div>
</template>

<style>
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