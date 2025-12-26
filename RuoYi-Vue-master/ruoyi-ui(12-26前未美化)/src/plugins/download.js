import axios from 'axios'
import {Loading, Message} from 'element-ui'
import { saveAs } from 'file-saver'
import { getToken } from '@/utils/auth'
import errorCode from '@/utils/errorCode'
import { blobValidate } from "@/utils/ruoyi"

const baseURL = process.env.VUE_APP_BASE_API
let downloadLoadingInstance

export default {
  name(name, isDelete = true) {
    var url = baseURL + "/common/download?fileName=" + encodeURIComponent(name) + "&delete=" + isDelete
    axios({
      method: 'get',
      url: url,
      responseType: 'blob',
      headers: { 'Authorization': 'Bearer ' + getToken() }
    }).then((res) => {
      const isBlob = blobValidate(res.data)
      if (isBlob) {
        const blob = new Blob([res.data])
        this.saveAs(blob, decodeURIComponent(res.headers['download-filename']))
      } else {
        this.printErrMsg(res.data)
      }
    })
  },
  resource(resource) {
    var url = baseURL + "/common/download/resource?resource=" + encodeURIComponent(resource)
    axios({
      method: 'get',
      url: url,
      responseType: 'blob',
      headers: { 'Authorization': 'Bearer ' + getToken() }
    }).then((res) => {
      const isBlob = blobValidate(res.data)
      if (isBlob) {
        const blob = new Blob([res.data])
        this.saveAs(blob, decodeURIComponent(res.headers['download-filename']))
      } else {
        this.printErrMsg(res.data)
      }
    })
  },
  zip(url, name) {
    var url = baseURL + url
    downloadLoadingInstance = Loading.service({ text: "正在下载数据，请稍候", spinner: "el-icon-loading", background: "rgba(0, 0, 0, 0.7)", })
    axios({
      method: 'get',
      url: url,
      responseType: 'blob',
      headers: { 'Authorization': 'Bearer ' + getToken() }
    }).then((res) => {
      const isBlob = blobValidate(res.data)
      if (isBlob) {
        const blob = new Blob([res.data], { type: 'application/zip' })
        this.saveAs(blob, name)
      } else {
        this.printErrMsg(res.data)
      }
      downloadLoadingInstance.close()
    }).catch((r) => {
      console.error(r)
      Message.error('下载文件出现错误，请联系管理员！')
      downloadLoadingInstance.close()
    })
  },
  saveAs(text, name, opts) {
    saveAs(text, name, opts)
  },
  async printErrMsg(data) {
    const resText = await data.text()
    const rspObj = JSON.parse(resText)
    const errMsg = errorCode[rspObj.code] || rspObj.msg || errorCode['default']
    Message.error(errMsg)
  },
  /**
   * 安全删除文件API
   * 提供安全的文件删除功能，包含权限验证和完整错误处理
   */
  delete(filePath) {
      // 参数验证
      if (!filePath || filePath.trim() === '') {
          this.printErrMsg("文件路径不能为空");
          return Promise.reject(new Error("文件路径不能为空"));
      }

      // 安全校验 - 防止路径遍历攻击
      if (filePath.includes('..') || filePath.includes('//') || filePath.includes('\\\\')) {
          this.printErrMsg("文件路径包含非法字符");
          return Promise.reject(new Error("文件路径非法"));
      }

      const url = baseURL + "/common/delete?filePath=" + encodeURIComponent(filePath);

      return axios({
          method: 'delete', // 改为DELETE方法
          url: url,
          responseType: 'json', // 删除操作返回JSON响应，不是blob
          headers: {
              'Authorization': 'Bearer ' + getToken(),
              'Content-Type': 'application/json'
          },
          timeout: 10000 // 添加超时设置
      }).then((res) => {
          // 处理删除成功的响应
          if (res.data && res.data.code === 200) {
              console.log("文件删除成功:", res.data.msg);
              // 可以添加成功回调或其他处理
              if (res.data.data) {
                  return {
                      success: true,
                      message: res.data.msg,
                      data: res.data.data
                  };
              }
              return { success: true, message: res.data.msg };
          } else {
              // 处理业务逻辑错误
              const errorMsg = res.data?.msg || "删除失败";
              this.printErrMsg(errorMsg);
              throw new Error(errorMsg);
          }
      }).catch((error) => {
          // 统一的错误处理
          let errorMessage = "文件删除失败";

          if (error.response) {
              // 服务器返回错误状态码
              const status = error.response.status;
              switch (status) {
                  case 400:
                      errorMessage = "请求参数错误";
                      break;
                  case 401:
                      errorMessage = "未授权访问，请重新登录";
                      break;
                  case 403:
                      errorMessage = "权限不足，无法删除文件";
                      break;
                  case 404:
                      errorMessage = "文件不存在";
                      break;
                  case 500:
                      errorMessage = "服务器内部错误";
                      break;
                  default:
                      errorMessage = `服务器错误: ${status}`;
              }

              // 尝试从响应数据获取详细错误信息
              if (error.response.data && error.response.data.msg) {
                  errorMessage = error.response.data.msg;
              }
          } else if (error.request) {
              // 请求未收到响应
              if (error.code === 'ECONNABORTED') {
                  errorMessage = "请求超时，请检查网络连接";
              } else {
                  errorMessage = "网络错误，请检查网络连接";
              }
          } else {
              // 其他错误
              errorMessage = error.message || "未知错误";
          }

          console.error("删除文件失败:", {
              filePath: filePath,
              error: errorMessage,
              fullError: error
          });

          this.printErrMsg(errorMessage);
          throw new Error(errorMessage);
      });
  }


}

