import Vue from 'vue'
import VueRouter from 'vue-router'
import mysql from '../views/table/index'

import user from '../views/user/router'
import admin from '../views/admin/router'
Vue.use(VueRouter)

const routes = [
  {
    path:'/',
    redirect:'/home'
  },
    ...user,
    ...admin,
  {
    path:'/mysql',
    name: 'mysql',
    component: mysql
  },
  {
    path: '*',
    name: 'notFound',
    component: () => import(/* webpackChunkName: "about" */ '../views/notFound.vue')
  }
]

const router = new VueRouter({
  routes
})

export default router
