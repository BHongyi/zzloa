<template>
  <el-container>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<style>
</style>

<script>
export default {
  name: "DailyPaper",
  data() {
    return {
      positiontype: 0,
    };
  },
  mounted: function () {
    this.initpage();
  },
  methods: {
    initpage() {
      this.positiontype = sessionStorage.getItem('positiontype');
      if (this.positiontype == 1) {
        this.$router.push({ path: "developerpaper" });
      } else if (this.positiontype == 2) {
        this.$router.push({ path: "salepaper" });
      } else if (this.positiontype == 3) {
        this.$router.push({ path: "managerpaper" });
      }else{
          this.$router.push({ path: "developerpaper" });
      }
    },
  },
};
</script>