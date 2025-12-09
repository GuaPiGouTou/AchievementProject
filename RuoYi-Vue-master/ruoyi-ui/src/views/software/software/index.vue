<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="软件名称" prop="softwareName">
        <el-input
          v-model="queryParams.softwareName"
          placeholder="请输入软件名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="软件版本" prop="softwareVersion">
        <el-input
          v-model="queryParams.softwareVersion"
          placeholder="请输入软件版本"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发表日期" prop="publishDate">
        <el-date-picker clearable
          v-model="queryParams.publishDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择发表日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="编程语言" prop="programmingLanguage">
        <el-input
          v-model="queryParams.programmingLanguage"
          placeholder="请输入编程语言"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间" prop="createdAt">
        <el-date-picker clearable
          v-model="queryParams.createdAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['software:software:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['software:software:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['software:software:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['software:software:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="softwareList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="软著id" align="center" prop="softwareId" />
      <el-table-column label="软件名称" align="center" prop="softwareName" />
      <el-table-column label="软件版本" align="center" prop="softwareVersion" />
      <el-table-column label="登记号" align="center" prop="certificateNo" />
      <el-table-column label="发表日期" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="登记日期" align="center" prop="registerDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.registerDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="开发完成日期" align="center" prop="developmentDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.developmentDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="编程语言" align="center" prop="programmingLanguage" />
      <el-table-column label="软件类型" align="center" prop="softwareType" />
      <el-table-column label="软著等级" align="center" prop="softwareCopyrightCertificateLevel" />
      <el-table-column label="证书类型" align="center" prop="certificateType" />
      <el-table-column label="主要功能" align="center" prop="mainFunction" />
      <el-table-column label="应用领域" align="center" prop="applicationField" />
      <el-table-column label="审核状态" align="center" prop="auditStatus" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="附件列表" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-paperclip"
                @click="handleAttachment(scope.row)"
              >
                附件
              </el-button>
            </template>
          </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['software:software:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['software:software:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改软著成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="软件名称" prop="softwareName">
          <el-input v-model="form.softwareName" placeholder="请输入软件名称" />
        </el-form-item>
        <el-form-item label="软件版本" prop="softwareVersion">
          <el-input v-model="form.softwareVersion" placeholder="请输入软件版本" />
        </el-form-item>
        <el-form-item label="登记号" prop="certificateNo">
          <el-input v-model="form.certificateNo" placeholder="请输入登记号" />
        </el-form-item>
        <el-form-item label="发表日期" prop="publishDate">
          <el-date-picker clearable
            v-model="form.publishDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发表日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="登记日期" prop="registerDate">
          <el-date-picker clearable
            v-model="form.registerDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择登记日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="开发完成日期" prop="developmentDate">
          <el-date-picker clearable
            v-model="form.developmentDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择开发完成日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="编程语言" prop="programmingLanguage">
          <el-input v-model="form.programmingLanguage" placeholder="请输入编程语言" />
        </el-form-item>
        <el-form-item label="软件类型" prop="softwareType">
          <el-select v-model="form.softwareType" placeholder="请选择">
              <el-option
                v-for="item in softwareTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>

        <el-form-item label="软著等级" prop="softwareCopyrightCertificateLevel">
          <el-select v-model="form.softwareCopyrightCertificateLevel" placeholder="请选择">
              <el-option
                v-for="item in softwareCopyrightCertificateLevels"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
            </el-form-item>
        <el-form-item label="主要功能" prop="mainFunction">
          <el-input v-model="form.mainFunction" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="应用领域" prop="applicationField">
          <el-input v-model="form.applicationField" placeholder="请输入应用领域" />
        </el-form-item>
        <el-form-item label="上传文件" prop="updatedAt">
        	<file-upload ref="file" v-model="files"></file-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
        </el-checkbox-group>
        <el-button @click="DowExcel()" >导出</el-button>
    </el-dialog>
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="competition"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
  </div>
</template>

<script>
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listSoftware, getSoftware, delSoftware, addSoftware, updateSoftware } from "@/api/software/software"

export default {
  name: "Software",
  data() {
    return {
      //上传文件组件
      files:[],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      //导出选择字段
       checkList: [
             {
               value: 'softwareId',
               label: '软著id'
             }, {
               value: 'softwareName',
               label: '软件名称'
             }, {
               value: 'softwareVersion',
               label: '软件版本'
             }, {
               value: 'certificateNo',
               label: '登记号'
             }, {
               value: 'publishDate',
               label: '发表日期'
             }, {
               value: 'registerDate',
               label: '登记日期'
             }, {
               value: 'developmentDate',
               label: '开发完成日期'
             }, {
               value: 'programmingLanguage',
               label: '编程语言'
             }, {
               value: 'softwareType',
               label: '软件类型'
             }, {
               value: 'softwareCopyrightCertificateLevel',
               label: '软著等级'
             }, {
               value: 'certificateType',
               label: '证书类型'
             }, {
               value: 'mainFunction',
               label: '主要功能'
             }, {
               value: 'applicationField',
               label: '应用领域'
             }, {
               value: 'auditStatus',
               label: '审核状态'
             }, {
               value: 'createdAt',
               label: '创建时间'
             }, {
               value: 'updatedAt',
               label: '更新时间'
             }
           ],
      selectClist:[],
     // 1. 软件类型 (对应数据库 software_type)
        softwareTypes: [
          { label: "系统软件", value: "系统软件" },
          { label: "应用软件", value: "应用软件" },
          { label: "嵌入式软件", value: "嵌入式软件" },
          { label: "其他", value: "其他" }
        ],

        // 2. 软著等级 (对应数据库 software_copyright_certificate_level)
        softwareCopyrightCertificateLevels: [
          { label: "一级", value: "一级" },
          { label: "二级", value: "二级" },
          { label: "三级", value: "三级" },
          { label: "其他", value: "其他" }
        ],

        // 3. 证书类型 (对应数据库 certificate_type) - 建议补充
        certificateTypes: [
          { label: "申请证书", value: "申请证书" },
          { label: "授权证书", value: "授权证书" }
        ],
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 软著成果表格数据
      softwareList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        softwareName: null,
        softwareVersion: null,
        publishDate: null,
        programmingLanguage: null,
        softwareType: null,
        softwareCopyrightCertificateLevel: null,
        certificateType: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
      // 表单校验
        rules: {
          softwareName: [
            { required: true, message: "软件名称不能为空", trigger: "blur" },
            { min: 1, max: 100, message: "长度在 1 到 100 个字符", trigger: "blur" },
            // 允许中文、英文、数字、括号（中英文）、横杠、下划线、空格
            { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\-\_\s]+$/, message: "软件名称只能包含中英文、数字、括号、下划线及横杠", trigger: "blur" }
          ],
          softwareVersion: [
            { required: true, message: "软件版本不能为空", trigger: "blur" },
            { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
            // 允许 V/v 开头，包含数字、点、横杠、下划线。例如: V1.0, 1.0.1, 2023-Release
            { pattern: /^[a-zA-Z0-9\.\-\_\s]+$/, message: "版本号格式不正确 (如: V1.0, 1.0.1)", trigger: "blur" }
          ],
          certificateNo: [
            { required: true, message: "登记号不能为空", trigger: "blur" },
            // 软著登记号通常是年份+SR+数字，如 2023SR123456，或者是纯数字/字母组合
            { pattern: /^[a-zA-Z0-9]+$/, message: "登记号只能包含字母和数字", trigger: "blur" },
            { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" }
          ],
          registerDate: [
            { required: true, message: "登记日期不能为空", trigger: "blur" }
          ],
          developmentDate: [
            { required: true, message: "开发完成日期不能为空", trigger: "blur" }
          ],
          programmingLanguage: [
            // 虽然原代码没必填，但建议加上格式限制
            { required: true, message: "编程语言不能为空", trigger: "blur" },
            // 必须支持特殊字符：C++, C#, HTML/CSS, Node.js (需要支持 +, #, /, ., 空格)
            { pattern: /^[a-zA-Z0-9\+\#\.\/\s,;]+$/, message: "格式不正确，请填写如: Java, C++, Python", trigger: "blur" },
            { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" }
          ],
          softwareType: [
            { required: true, message: "软件类型不能为空", trigger: "change" }
          ],
          softwareCopyrightCertificateLevel: [
            { required: true, message: "软著等级不能为空", trigger: "change" }
          ],
          certificateType: [
            { required: true, message: "证书类型不能为空", trigger: "change" }
          ],
          applicationField: [
            { required: false, message: "请输入应用领域", trigger: "blur" },
            // 允许中英文、数字、逗号分隔
            { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s,;，；]+$/, message: "只能包含中英文、数字及分隔符", trigger: "blur" },
            { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
          ],
          mainFunction: [
            { required: false, message: "请输入主要功能", trigger: "blur" },
            { max: 500, message: "主要功能描述不能超过 500 个字符", trigger: "blur" }
          ]
        }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询软著成果列表 */
    getList() {
      this.loading = true
      listSoftware(this.queryParams).then(response => {
        this.softwareList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        softwareId: null,
        userId: null,
        deptId: null,
        softwareName: null,
        softwareVersion: null,
        certificateNo: null,
        publishDate: null,
        registerDate: null,
        developmentDate: null,
        programmingLanguage: null,
        softwareType: null,
        softwareCopyrightCertificateLevel: null,
        certificateType: null,
        mainFunction: null,
        applicationField: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.softwareId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加软著成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const softwareId = row.softwareId || this.ids
      getSoftware(softwareId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改软著成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.softwareId != null) {
            updateSoftware(this.form).then(response => {
              if(response.softwareId!=null)
              {
                 this.$refs.file.submitUpload(response.softwareId,"software");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addSoftware(this.form).then(response => {
              if(response.softwareId!=null)
              {
                 this.$refs.file.submitUpload(response.softwareId,"software");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const softwareIds = row.softwareId || this.ids
      this.$modal.confirm('是否确认删除软著成果编号为"' + softwareIds + '"的数据项？').then(function() {
        return delSoftware(softwareIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.Excelopen = true
    },
    /*
    附件弹窗方法
    */
      handleAttachment(row) {
          this.currentPaperId = row.competitionId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.competitionName || '软著'}`
          this.attachmentVisible = true
        },

      /** 附件弹窗关闭 */
      handleAttachmentClose() {
        this.currentPaperId = null
        this.currentPaper = null
      },

      /** 附件加载成功 */
      handleAttachmentLoadSuccess(fileList) {
        console.log(`加载了 ${fileList.length} 个附件`)
        // 可以在这里更新论文的附件数量显示
        if (this.currentPaper) {
          this.$set(this.currentPaper, 'attachmentCount', fileList.length)
        }
      },

      /** 下载成功 */
      handleDownloadSuccess(file) {
        this.$message.success(`文件"${file.fileName}"下载成功`)
      },

      /** 删除成功 */
      handleDeleteSuccess(file) {
        this.$message.success(`文件"${file.fileName}"删除成功`)
      },
      /*导出*/
      async DowExcel(){
          const requestData = {
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('software/software/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
