<template>
</template>

<script>
import { getUserProfile } from "@/api/system/user"
import Cookies from "js-cookie"
export default{
 created() {
   getUserProfile().then((res)=>{

      const hasAdmin = res.data.roles.some(item =>
        item.roleId === 1 || item.roleId === 101
      )
       Cookies.set("adminFlag",hasAdmin)
       })
 }
}
</script>

<style>
</style>
