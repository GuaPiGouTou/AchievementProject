import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {path: '/', redirect: '/manager/home'},
    {path: '/manager',  component: import('../views/Manager.vue'),
      children:[
        {path:'home',component:import('../views/Home.vue'),},
        {path:'about',component:import('../views/About.vue'),},
        {path:'user',component:import('../views/User.vue'),},
      ]},
    {path: '/login', component: import('../views/Login.vue'),},
    {path: '/notFound', component: import('../views/404.vue'),},
    {path: '/:pathMatch(.*)', redirect:'/notFound'},

  ],
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !localStorage.getItem('token')) {
    next('/login')
  } else {
    next()
  }
})

export default router
