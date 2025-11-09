<template>
  <div class="upload-file">
   待开发
    <file-upload ref="file" v-model="files"></file-upload>
   <button @click="opener"></button>

  </div>
</template>

<script>
export default {
  data() {
    return {
       paperId:1,
      files: "" ,// 文件数据,
      fileList: []
    }
  },
  methods: {
     submitFiles() {
          // 通过ref手动触发上传
          this.$refs.fileUploader.submitUpload(this.paperId)
        },
    opener() {
      // 确保DOM已更新后再调用refs
      this.$nextTick(() => {
        if (this.$refs.file && this.$refs.file.submitUpload) {
          this.$refs.file.submitUpload(18); // 18可能是paperId或其他参数
        } else {
          console.error("文件上传组件引用不存在或submitUpload方法未定义");
        }
      });
    }
  }
}
</script>

<style scoped lang="scss">

</style>
