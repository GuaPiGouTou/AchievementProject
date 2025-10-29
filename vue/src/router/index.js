import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: '/manager/home' },
    {
      path: '/manager',
      component: () => import('../views/Manager.vue'),
      meta: { requiresAuth: true }, // 需要认证的页面
      children: [
        { 
		  name:'home',
          path: 'home', 
          component: () => import('../views/Home.vue'),
          meta: { title: '首页' } 
        },
        { 
          path: 'about', 
          component: () => import('../views/About.vue'),
          meta: { title: '关于我们' } 
        },
        { 
          path: 'user', 
          component: () => import('../views/User.vue'),
          meta: { title: '用户管理' } 
        },
      ]
    },
    { 
      path: '/login', 
      component: () => import('../views/Login.vue'),
      meta: { title: '用户登录' } 
    },
    { 
      path: '/notFound', 
      component: () => import('../views/404.vue'),
      meta: { title: '页面未找到' } 
    },
    { 
      path: '/:pathMatch(.*)', 
      redirect: '/notFound',
      meta: { title: '页面未找到' } 
    },
  ],
})

router.beforeEach((to, from, next) => {
  // 设置页面标题
  document.title = to.meta.title ? `${to.meta.title} - 系统名称` : '系统名称'
  
  // 检查路由是否需要认证
  if (to.meta.requiresAuth) {
    // 检查用户是否已经登录
    const token = localStorage.getItem('token')
    if (!token) {
      // 如果没有token，重定向到登录页面
      next('/login')
      return
    }
  }
  
  next()
})

export default router