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
import PersonalPage from '@/components/PersonalPage'
import ClientManage from '@/components/ClientManage'
import BusinessManage from '@/components/BusinessManage'
import DailyPaperSale from '@/components/DailyPaperSale'
import LeaveFlow from '@/components/LeaveFlow'
import Audit from '@/components/Audit'
import ReadDailypaperBydate from '@/components/ReadDailypaperBydate'

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
          path: '/default',
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
        },
        {
          path: '/personalpage',
          name: 'PersonalPage',
          component: PersonalPage
        },
        {
          path: '/clientmanage',
          name: 'ClientManage',
          component: ClientManage
        },
        {
          path: '/businessmanage',
          name: 'BusinessManage',
          component: BusinessManage
        },
        {
          path: '/dailypapersale',
          name: 'DailyPaperSale',
          component: DailyPaperSale
        },
        {
          path: '/leaveflow',
          name: 'LeaveFlow',
          component: LeaveFlow
        },
        {
          path: '/audit',
          name: 'Audit',
          component: Audit
        },
        {
          path: '/readdailypaperbydate',
          name: 'ReadDailypaperBydate',
          component: ReadDailypaperBydate
        }
      ]
    }
  ]
})
