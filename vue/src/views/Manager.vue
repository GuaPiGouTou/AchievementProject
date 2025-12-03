<template>
  <div>
    <!-- 头部区域 -->
    <div style="height: 60px; display: flex; position: fixed; top: 0; left: 0; right: 0; z-index: 1002; background-color: white;">
      <div style="width: 15%; display: flex; align-items: center; padding-left: 20px; background-color: #2c82ff">
        <img style="width: 90%; height: 60%" src="@/assets/imgs/logo.png" alt="" />
      </div>
      <div style="flex: 1; display: flex; align-items: center; padding-left: 20px; border-bottom: 1px solid #ddd">
        首页/数据分析
      </div>
      <div style="flex: 1"></div>
      <div style="width: fit-content; display: flex; align-items: center; padding-right: 15px">
        <el-dropdown>
          <div style="display: flex; align-items: center">
            <img style="width: 40px; height: 40px; border-radius: 50%" src="@/assets/imgs/njp9mnwLp9.png" alt="" />
            <span style="margin-left: 5px">{{ account }}</span>
          </div>
          <template #dropdown>
            <el-dropdown-item @click="goToPersonalCenter">个人信息</el-dropdown-item>
            <el-dropdown-item @click="goToPasswordChange">修改密码</el-dropdown-item>
            <el-dropdown-item @click="handleLogout">退出登录</el-dropdown-item>
          </template>
        </el-dropdown>
      </div>
    </div>
    <!-- 头部区域结束 -->

    <!-- 下方区域开始 -->
    <div style="display: flex; margin-top: 60px;">
      <!-- 菜单区域开始 -->
      <div style="position: fixed; top: 60px; left: 0; bottom: 0; width: 15%; background-color: #2c82ff; z-index: 1001;">
        <el-menu
            :default-openeds="['1']"
            default-active="home"
            style="height: 100%; border: none;"
            unique-opened
        >
          <!-- 首页（固定路由） -->
          <el-menu-item index="home" @click="goToHome">
            <el-icon><House /></el-icon>
            <span>首页</span>
          </el-menu-item>

          <!-- 数据管理（固定子菜单） -->
          <el-sub-menu index="1">
            <template #title>
              <el-icon><Location /></el-icon>
              <span>数据管理</span>
            </template>
            <el-menu-item index="about" @click="goToAbout">二级菜单</el-menu-item>
          </el-sub-menu>

          <el-menu-item @click="goToPersonalCenter">
            <el-icon><User /></el-icon>
            <span>个人中心</span>
          </el-menu-item>
        </el-menu>
      </div>
      <!-- 菜单区域结束 -->

      <!-- 数据渲染区域开始 -->
      <div style="flex: 1; width: 0; padding: 10px; background-color: #e4edf1; margin-left: 15%; min-height: calc(100vh - 80px);">
        <RouterView />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { removeToken } from '@/utils/auth'
import { House, Location, User } from '@element-plus/icons-vue'

const router = useRouter()
const account = ref("无用户")

// 页面加载时：显示用户名+身份（可选，提升体验）
onMounted(() => {
  const username = localStorage.getItem('username')
  const isTeacher = localStorage.getItem('isTeacherIdentity') === 'true'
  account.value = isTeacher ? `老师：${username}` : `学生：${username}`
})

// 跳转到首页（固定路由）
const goToHome = () => {
  router.push({ name: 'home' })
}

// 跳转到关于我们（固定路由）
const goToAbout = () => {
  router.push({ name: 'about' })
}

// 跳转到修改密码（固定路由）
const goToPasswordChange = () => {
  router.push({ name: 'passwordchange' })
}

// 核心：根据身份动态跳转到对应个人中心（关键方法）
const goToPersonalCenter = () => {
  const isTeacher = localStorage.getItem('isTeacherIdentity') === 'true'
  if (isTeacher) {
    // 老师身份：跳转到教师个人中心
    router.push({ name: 'teacheruser' })
  } else {
    // 学生身份：跳转到学生个人中心
    router.push({ name: 'studentuser' })
  }
}

// 退出登录：清除所有本地存储
const handleLogout = () => {
  removeToken()
  localStorage.removeItem('username')
  localStorage.removeItem('initial')
  localStorage.removeItem('isTeacherIdentity') // 清除身份标识
  localStorage.removeItem('savedUser') // 清除记住的账号密码
  router.push('/login')
  ElMessage.success('已成功退出登录')
}
</script>

<style>
.el-menu {
  background-color: transparent;
}

.el-sub-menu__title,
.el-menu-item {
  color: #ffffff;
  padding-left: 20px !important;
}

.el-sub-menu .el-menu {
  padding-left: 0 !important;
}

.el-sub-menu .el-menu-item {
  padding-left: 54px !important;
}

.el-menu .is-active {
  background-color: #1a66d5 !important;
  color: #fff;
}

.el-sub-menu__title:hover,
.el-menu-item:hover {
  background-color: #1a66d5 !important;
  color: #fff !important;
}

.el-sub-menu__icon-arrow {
  color: #ddd !important;
}
</style>