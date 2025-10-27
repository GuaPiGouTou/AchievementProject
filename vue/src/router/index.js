import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { 
		path: '/', 
		redirect: '/manager/home' // 默认首页
	  },
    {path: '/manager',  component: import('../views/Manager.vue'),
      children:[
        {path:'home',component:import('../views/Home.vue'),},
        {path:'about',component:import('../views/About.vue'),},
      ]},
    {path: '/login', component: import('../views/Login.vue'),},
    {path: '/notFound', component: import('../views/404.vue'),},
    {path: '/:pathMatch(.*)', redirect:'/notFound'},

  ],
})

export default router
