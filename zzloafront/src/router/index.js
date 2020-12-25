import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import Index from '@/components/Index'
import UserManage from '@/components/UserManage'
import GroupManage from '@/components/GroupManage'
import PermissionManage from '@/components/PermissionManage'
import RoleManage from '@/components/RoleManage'
import Default from '@/components/Default'

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
        }
      ]
    }
  ]
})
