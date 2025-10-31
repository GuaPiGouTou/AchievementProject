import { ElMessage, ElMessageBox } from 'element-plus'
import { createRouter, createWebHistory } from 'vue-router'
import {getToken} from '@/utils/auth'
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
          path: 'home/:initial?', 
          component: () => import('../views/Home.vue'),
          meta: { title: '首页' } 
        },
        { 
		  name:'about',
          path: 'about', 
          component: () => import('../views/About.vue'),
          meta: { title: '关于我们' } 
        },
        { 
		  name:'studentuser',
          path: 'studentuser',
          component: () => import('../views/User/StudentUser.vue'),
          meta: {
            title: '学生个人中心',
            requiredIdentity: 'student'
          }
        },
        { name:'teacheruser',
          path: 'teacheruser',
          component: () => import('../views/User/TeacherUser.vue'),
          meta: {
            title: '教师个人中心',
            requiredIdentity: 'teacher'
          }
        },
        {
		  name:'passwordchange',	
		  path: 'passwordchange',
		  component: () => import('../views/PasswordChange.vue'),
		  meta: { title: '修改密码' ,
			requiresAuth: true //必须的登录才可以访问
		  }
		}
		
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
  
  // // 检查路由是否需要认证
  // if (to.meta.requiresAuth) {
  //   // 检查用户是否已经登录
  //   const token = localStorage.getItem('token')
  //   if (!token) {
  //     // 如果没有token，重定向到登录页面
  //     next('/login')
  //     return
  //   }
  // }
  //
  // // 如果已经登录且访问的是登录页，重定向到首页
  //   if (to.path === '/login') {
  //     const token = localStorage.getItem('token')
  //     if (token) {
  //       next({ path: '/manager/home' })
  //       return
  //     }
  //   }
  //
	// console.log(to.params.initial)
  // // 如果初次登录重定向到修改密码界面
  //   const initial =  localStorage.getItem('initial')
  //  if (getToken()!=null&&initial === 'true'&&to.name!="passwordchange") {
	//  ElMessage.warning("初次登录，请修改密码后重新登录")
	//  next({ name: 'passwordchange' })
	//  return
  //  }
  
  next()
})

export default router