<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="专利局" prop="patentOffice">
        <el-input
          v-model="queryParams.patentOffice"
          placeholder="请输入专利局"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="技术领域" prop="technicalField">
        <el-input
          v-model="queryParams.technicalField"
          placeholder="请输入技术领域"
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
          v-hasPermi="['patent:patent:add']"
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
          v-hasPermi="['patent:patent:edit']"
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
          v-hasPermi="['patent:patent:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['patent:patent:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="patentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="专利id" align="center" prop="patentId" />
      <el-table-column label="专利名称" align="center" prop="patentName" />
      <el-table-column label="专利号" align="center" prop="patentNo" />
      <el-table-column label="专利类型" align="center" prop="patentType" />
      <el-table-column label="发明人顺序" align="center" prop="authorOrder" />
      <el-table-column label="申请日期" align="center" prop="applicationDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.applicationDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="授权日期" align="center" prop="authorizationDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.authorizationDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="公布日期" align="center" prop="publicationDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publicationDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="公布号" align="center" prop="publicationNo" />
      <el-table-column label="专利有效期" align="center" prop="patentValidity" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.patentValidity, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="专利所属学科" align="center" prop="patentSubject" />
      <el-table-column label="专利状态" align="center" prop="patentStatus" />
      <el-table-column label="专利局" align="center" prop="patentOffice" />
      <el-table-column label="技术领域" align="center" prop="technicalField" />
      <el-table-column label="专利法律状态" align="center" prop="legalStatus" />
      <el-table-column label="证书类型" align="center" prop="certificateType" />
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
            v-hasPermi="['patent:patent:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['patent:patent:remove']"
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
<!-- 添加或修改专利成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="专利名称" prop="patentName">
          <el-input v-model="form.patentName" type="textarea" placeholder="请输入专利名称（支持中英文、数字、书名号及括号）" />
        </el-form-item>
        <el-form-item label="专利号" prop="patentNo">
          <el-input v-model="form.patentNo" placeholder="请输入专利号 (如: ZL202310123456.X)" />
        </el-form-item>
        <el-form-item label="专利类型" prop="patentType">
          <el-select v-model="form.patentType" placeholder="请选择专利类型">
              <el-option
                v-for="item in patentTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="专利状态" prop="patentStatus">
          <el-select v-model="form.patentStatus" placeholder="请选择专利状态">
              <el-option
                v-for="item in patentStatuss"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="专利法律状态" prop="legalStatus">
          <el-select v-model="form.legalStatus" placeholder="请选择专利法律状态">
              <el-option
                v-for="item in legalStatuss"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="证书类型" prop="certificateType">
          <el-select v-model="form.certificateType" placeholder="请选择证书类型">
              <el-option
                v-for="item in certificateTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="发明人顺序" prop="authorOrder">
                  <el-input
                    v-model="form.authorOrder"
                    placeholder="请输入发明人姓名，按顺序用逗号分隔 (如: 张三, 李四)"
                  />
                </el-form-item>
        <el-form-item label="申请日期" prop="applicationDate">
          <el-date-picker clearable
            v-model="form.applicationDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择申请日期">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="公布日期" prop="publicationDate">
          <el-date-picker clearable
            v-model="form.publicationDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择公布日期">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="授权日期" prop="authorizationDate">
          <el-date-picker clearable
            v-model="form.authorizationDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择授权日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="授权号" prop="authorizationNo">
          <el-input v-model="form.authorizationNo" placeholder="请输入授权号 (如: CN101234567A)" />
        </el-form-item>
        <el-form-item label="公布号" prop="publicationNo">
          <el-input v-model="form.publicationNo" placeholder="请输入公布号 (如: CN101234567A)" />
        </el-form-item>
        <el-form-item label="专利有效期" prop="patentValidity">
          <el-date-picker clearable
            v-model="form.patentValidity"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择专利有效期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="专利所属学科" prop="patentSubject">
          <el-input v-model="form.patentSubject" placeholder="请输入专利所属学科" />
        </el-form-item>
        <el-form-item label="技术领域" prop="technicalField">
          <el-input v-model="form.technicalField" placeholder="请输入技术领域 (如: G06F 3/0481 或 人工智能)" />
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
        attachment-type="patent"
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
import { listPatent, getPatent, delPatent, addPatent, updatePatent } from "@/api/patent/patent"

export default {
  name: "Patent",
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
      // 导出选择字段
      checkList: [
        {
          value: 'patentId',
          label: '专利id'
        },
        {
          value: 'userId',
          label: '用户ID'
        },
        {
          value: 'deptId',
          label: '部门ID'
        },
        {
          value: 'patentName',
          label: '专利名称'
        },
        {
          value: 'patentNo',
          label: '专利号'
        },
        {
          value: 'patentType',
          label: '专利类型'
        },
        {
          value: 'authorOrder',
          label: '发明人顺序'
        },
        {
          value: 'applicationDate',
          label: '申请日期'
        },
        {
          value: 'authorizationDate',
          label: '授权日期'
        },
        {
          value: 'publicationDate',
          label: '公布日期'
        },
        {
          value: 'publicationNo',
          label: '公布号'
        },
        {
          value: 'patentValidity',
          label: '专利有效期'
        },
        {
          value: 'patentSubject',
          label: '专利所属学科'
        },
        {
          value: 'patentStatus',
          label: '专利状态'
        },
        {
          value: 'authorizationNo',
          label: '授权号'
        },
        {
          value: 'technicalField',
          label: '技术领域'
        },
        {
          value: 'legalStatus',
          label: '专利法律状态'
        },
        {
          value: 'certificateType',
          label: '证书类型'
        },
        {
          value: 'auditStatus',
          label: '审核状态'
        },
        {
          value: 'createdAt',
          label: '创建时间'
        },
        {
          value: 'updatedAt',
          label: '更新时间'
        }
      ],
      selectClist:[],
      //1. 专利类型 (对应数据库 patent_type)
      patentTypes: [
        { label: "发明专利", value: "发明专利" },
        { label: "实用新型", value: "实用新型" },
        { label: "外观设计", value: "外观设计" }
      ],

      // 2. 专利状态 (对应数据库 patent_status)
      patentStatuss: [
        { label: "申请中", value: "申请中" },
        { label: "实质审查", value: "实质审查" },
        { label: "已授权", value: "已授权" },
        { label: "已转让", value: "已转让" },
        { label: "已失效", value: "已失效" }
      ],

      // 3. 专利法律状态 (对应数据库 legal_status)
      legalStatuss: [
        { label: "申请中", value: "申请中" },
        { label: "已授权", value: "已授权" },
        { label: "有效", value: "有效" },
        { label: "失效", value: "失效" },
        { label: "终止", value: "终止" }
      ],

      // 4. 证书类型 (对应数据库 certificate_type)
      certificateTypes: [
        { label: "受理通知书", value: "application_notice" },
        { label: "授权证书", value: "authorization_certificate" }
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
      // 专利成果表格数据
      patentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        patentName: null,
        patentType: null,
        patentStatus: null,
        patentOffice: null,
        technicalField: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
     // 表单校验
     rules: {
       patentName: [
         { required: true, message: "专利名称不能为空", trigger: "blur" },
         { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
         {
           // 允许：中文、英文、数字、中英文括号、书名号、横杠、下划线、空格
           pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s\.]+$/,
           message: "专利名称格式错误（支持中英文、数字、书名号、括号、点、下划线及横杠）",
           trigger: "blur"
         }
       ],
       patentNo: [
         { required: true, message: "专利号不能为空", trigger: "blur" },
         { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
         // 专利号核心校验：允许字母(ZL/CN)、数字、点(.)。
         { pattern: /^[a-zA-Z0-9\.\s]+$/, message: "专利号格式错误，示例: ZL202310123456.X", trigger: "blur" }
       ],
       patentType: [
         { required: true, message: "专利类型不能为空", trigger: "change" }
       ],
       authorOrder: [
         { required: true, message: "发明人顺序不能为空", trigger: "blur" },
         // 修改点：允许输入多人，使用逗号或分号分隔
         {
           pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s\.]+([,;，；][\u4e00-\u9fa5a-zA-Z0-9\s\.]+)*$/,
           message: "格式错误，多人请用逗号或分号分隔 (如: 张三, 李四)",
           trigger: "blur"
         },
         { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" }
       ],
       applicationDate: [
         { required: true, message: "申请日期不能为空", trigger: "blur" }
       ],
       certificateType: [
         { required: true, message: "证书类型不能为空", trigger: "change" }
       ],
       publicationNo: [
         { required: false, message: "请输入公布号", trigger: "blur" },
         // 公布号通常是 CN + 数字 + 字母后缀
         { pattern: /^[a-zA-Z0-9]+$/, message: "公布号格式错误（仅允许字母和数字）", trigger: "blur" }
       ],
       authorizationNo: [
         { required: false, message: "请输入授权号", trigger: "blur" },
         // 公布号通常是 CN + 数字 + 字母后缀
         { pattern: /^[a-zA-Z0-9]+$/, message: "授权号格式错误（仅允许字母和数字）", trigger: "blur" }
       ],
       patentSubject: [
         { required: false, message: "请输入专利所属学科", trigger: "blur" },
         { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
       ],
       technicalField: [
          { required: false, message: "请输入技术领域", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          {
            // 允许：中文、英文、数字、空格、斜杠(/)、逗号、点、横杠
            // 斜杠 / 是 IPC分类号 (G06F 3/0481) 的核心符号
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s\/,，\-\.]+$/,
            message: "格式错误，支持IPC分类号(如 G06F 3/0481)或中文描述",
            trigger: "blur"
          }
        ]
     }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询专利成果列表 */
    getList() {
      this.loading = true
      listPatent(this.queryParams).then(response => {
        this.patentList = response.rows
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
        patentId: null,
        userId: null,
        deptId: null,
        patentName: null,
        patentNo: null,
        patentType: null,
        authorOrder: null,
        applicationDate: null,
        authorizationDate: null,
        publicationDate: null,
        publicationNo: null,
        patentValidity: null,
        patentSubject: null,
        patentStatus: null,
        patentOffice: null,
        technicalField: null,
        legalStatus: null,
        certificateType: null,
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
      this.ids = selection.map(item => item.patentId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加专利成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const patentId = row.patentId || this.ids
      getPatent(patentId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改专利成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.patentId != null) {
            updatePatent(this.form).then(response => {
              if(response.patentId!=null)
              {
                 this.$refs.file.submitUpload(response.patentId,"patent");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPatent(this.form).then(response => {
              if(response.patentId!=null)
              {
                 this.$refs.file.submitUpload(response.patentId,"patent");
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
      const patentIds = row.patentId || this.ids
      this.$modal.confirm('是否确认删除专利成果编号为"' + patentIds + '"的数据项？').then(function() {
        return delPatent(patentIds)
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
          this.attachmentTitle = `附件管理 - ${row.competitionName || '专利'}`
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
           this.exceldownload('patent/patent/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
