<template>
  <div>
    <!-- 头部区域 -->
    <div style="height: 60px; display: flex">
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
            <span style="margin-left: 5px">admin</span>
          </div>
          <template #dropdown>
            <el-dropdown-item>个人信息</el-dropdown-item>
            <el-dropdown-item>修改密码</el-dropdown-item>
            <el-dropdown-item>退出登录</el-dropdown-item>
          </template>
        </el-dropdown>
      </div>
    </div>
    <!-- 头部区域结束 -->

    <!-- 下方区域开始 -->
    <div style="display: flex">
      <!-- 菜单区域开始 -->
      <div style="width: 15%">
        <!-- 关键改进：添加 unique-opened 确保只有一个子菜单展开，优化视觉效果 -->
        <el-menu
            router
            :default-openeds="['1']"
            default-active="/manager/home"
            style="min-height: calc(100vh - 60px)"
            unique-opened
        >
          <el-menu-item index="/manager/home">
            <el-icon><House /></el-icon>
            <span>首页</span>
          </el-menu-item>

          <el-sub-menu index="1">
            <template #title>
              <el-icon><Location /></el-icon>
              <span>数据管理</span>
            </template>
            <el-menu-item index="/manager/about">二级菜单</el-menu-item>

          </el-sub-menu>

          <el-menu-item index="/manager/user">
            <template #title>
            <el-icon><User /></el-icon>
            <span>个人中心</span>
            </template>

          </el-menu-item>
        </el-menu>
      </div>
      <!-- 菜单区域结束 -->

      <!-- 数据渲染区域开始 -->
      <div style="flex: 1; width: 0; padding: 10px; background-color: #e4edf1">
        <RouterView />
      </div>

    </div>
  </div>
</template>

<script setup>

</script>

<style>
.el-menu {
  background-color: #2c82ff;
  border: none;
}


.el-sub-menu__title,
.el-menu-item {
  color: #ddd;
  padding-left: 20px !important;
}


.el-sub-menu .el-menu {
  padding-left: 0 !important;
}

.el-sub-menu .el-menu-item {
  padding-left: 54px !important;
}

.el-menu .is-active {
  background-color: #1a66d5 !important; /* 稍微加深激活状态的背景色，增强区分度 */
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