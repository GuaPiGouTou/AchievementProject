<template>
  <div>
<!--头部区域-->
    <div style="height:60px;display: flex">
      <div style="width:12%;display: flex;align-items: center;padding-left:20px;background-color:#2c82ff">
        <img style="width:90%;height:60%" src="@/assets/imgs/logo.png" alt=""  />
      </div>
      <div style="flex: 1;display:flex;align-items: center;padding-left: 20px;border-bottom: 1px solid #ddd">
        首页/数据分析
      </div>
      <div style="flex: 1"></div>
      <div style="width: fit-content;display: flex;align-items: center;padding-right: 15px">
        <el-dropdown>
          <div style="display: flex;align-items: center">
            <img style="width: 40px;height: 40px;border-radius: 50%" src="@/assets/imgs/njp9mnwLp9.png" alt="">
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
<!--头部区域结束-->

<!--下方区域开始-->
      <div style="display: flex">
<!--菜单区域开始-->
        <div style="width: 12%">
          <el-menu router :default-openends="['1']" default-active="/manager/home" style="min-height: calc(100vh - 60px)">
            <el-menu-item index="/manager/home">
              <el-icon><House /></el-icon>
              <span>首页</span>
            </el-menu-item>
            <el-sub-menu index="1">
              <template #title>
                <el-icon><location /></el-icon>
                <span>数据管理</span>
              </template>
              <el-menu-item index="/manager/about">二级菜单</el-menu-item>
              </el-sub-menu>
          </el-menu>
        </div>
<!--菜单区域结束-->

<!--        数据渲染区域开始-->
        <div style="flex: 1;width: 0; padding: 10px;background-color: #e4edf1">
          <RouterView />
        </div>
<!--        数据渲染区域结束-->

      </div>
    </div>
</template>

<script setup>

</script>

<style >
.el-menu {
  background-color: #2c82ff;
  border:none;
}

.el-sub-menu__title{
  color: #ddd;
}

.el-menu-item {
  color: #ddd;
}
.el-menu .is-active {
  background-color: #2c82ff;
  color: #fff;
}
.el-sub-menu__title:hover {
  background-color: #2c82ff;
}

</style>