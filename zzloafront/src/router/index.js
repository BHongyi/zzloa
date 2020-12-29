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
import DeveloperPaper from '@/components/dailypapercomponents/DeveloperPaper'
import SalePaper from '@/components/dailypapercomponents/SalePaper'
import ManagerPaper from '@/components/dailypapercomponents/ManagerPaper'

Vue.use(Router)

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
          component: DailyPaper,
          children: [
            {
              path: '/developerpaper',
              name: 'DeveloperPaper',
              component: DeveloperPaper
            },
            {
              path: '/salepaper',
              name: 'SalePaper',
              component: SalePaper
            },
            {
              path: '/managerpaper',
              name: 'ManagerPaper',
              component: ManagerPaper
            }
          ]
        }
      ]
    }
  ]
})
