import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import Index from '@/components/Index'
import UserManage from '@/components/UserManage'
import GroupManage from '@/components/GroupManage'
import PermissionManage from '@/components/PermissionManage'
import RoleManage from '@/components/RoleManage'
import Default from '@/components/Default'
import ProjectManage from '@/components/ProjectManage'
import DailyPaper from '@/components/DailyPaper'
import ReadDailyPaper from '@/components/ReadDailyPaper'

Vue.use(Router)
const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/index',
      name: 'Index',
      component: Index,
      children: [
        {
          path: '/',
          name: 'Default',
          component: Default
        },
        {
          path: '/usermanage',
          name: 'UserManage',
          component: UserManage
        },
        {
          path: '/groupmanage',
          name: 'GroupManage',
          component: GroupManage
        },
        {
          path: '/permissionmanage',
          name: 'PermissionManage',
          component: PermissionManage
        },
        {
          path: '/rolemanage',
          name: 'RoleManage',
          component: RoleManage
        },
        {
          path: '/projectmanage',
          name: 'ProjectManage',
          component: ProjectManage
        }
        ,
        {
          path: '/dailypaper',
          name: 'DailyPaper',
          component: DailyPaper
        },
        {
          path: '/readdailypaper',
          name: 'ReadDailyPaper',
          component: ReadDailyPaper
        }
      ]
    }
  ]
})
