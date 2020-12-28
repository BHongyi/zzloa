// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
Vue.prototype.$axios = axios

import moment from 'moment'
Vue.use(require('vue-moment'));
Vue.prototype.moment = moment
Vue.filter('dateYMDHMSFormat',function(dateStr,pattern='YYYY-MM-DD'){
  if(dateStr == null){

  }
  else{
    return moment(dateStr).format(pattern);
  }
})

Vue.use(ElementUI)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
