<template>
  <div class="app-container">
     <el-form class="achievement-search-form software-search-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="软件名称" prop="softwareName">
        <el-input v-model.trim="queryParams.softwareName" placeholder="请输入软件名称关键词" clearable />
      </el-form-item>
      <el-form-item label="软件类型" prop="softwareType">
        <el-select v-model="queryParams.softwareType" placeholder="请选择软件类型" clearable filterable>
          <el-option
            v-for="item in softwareTypes"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="软著等级" prop="softwareCopyrightCertificateLevel">
        <el-select v-model="queryParams.softwareCopyrightCertificateLevel" placeholder="请选择软著等级" clearable filterable>
          <el-option
            v-for="item in softwareCopyrightCertificateLevels"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="证书类型" prop="certificateType">
        <el-select v-model="queryParams.certificateType" placeholder="请选择证书类型" clearable filterable>
          <el-option
            v-for="item in certificateTypes"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="审核状态" prop="auditStatus">
        <el-select v-model="queryParams.auditStatus" placeholder="请选择审核状态" clearable filterable>
          <el-option
            v-for="item in audisItems"
            :key="item"
            :label="item"
            :value="item"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="应用领域" prop="applicationField">
        <el-input v-model.trim="queryParams.applicationField" placeholder="请输入应用领域关键词" clearable />
      </el-form-item>
      <el-form-item label="发表日期">
        <el-date-picker
          v-model="publishDateRange"
          type="daterange"
          value-format="yyyy-MM-dd"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          clearable
        />
      </el-form-item>
      <el-form-item label="登记日期">
        <el-date-picker
          v-model="registerDateRange"
          type="daterange"
          value-format="yyyy-MM-dd"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          clearable
        />
      </el-form-item>
      <el-form-item label="完成日期">
        <el-date-picker
          v-model="developmentDateRange"
          type="daterange"
          value-format="yyyy-MM-dd"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          clearable
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">清空</el-button>
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
      <el-table-column label="附件列表" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-paperclip"
                @click="handleAttachment(scope.row)"
                v-hasPermi="['attachment:attachment:query']"
              >
                附件
              </el-button>
            </template>
          </el-table-column>
      <el-table-column v-if="$auth.hasPermi('software:software:edit')" label="审核" align="center" width="100">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-more"
              @click="handleAudis(scope.row)"
            >
              标注
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
       <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
         <el-form ref="form" :model="form" :rules="rules" text-align: right  label-width="120px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
           <el-form-item label="软件名称" prop="softwareName">
             <el-input v-model="form.softwareName" placeholder="请输入软件名称（支持中英文、数字、书名号及括号）" />
           </el-form-item>
           <el-form-item label="软件版本" prop="softwareVersion">
             <el-input v-model="form.softwareVersion" placeholder="请输入软件版本 (如: V1.0.1)" />
           </el-form-item>
           <el-form-item label="登记号" prop="certificateNo">
             <el-input v-model="form.certificateNo" placeholder="请输入登记号 (如: 2023SR123456)" />
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
             <el-input v-model="form.programmingLanguage" placeholder="请输入编程语言 (如: Java, C++, Python)" />
           </el-form-item>
           <el-form-item label="软件类型" prop="softwareType">
             <el-select v-model="form.softwareType" placeholder="请选择软件类型">
                 <el-option
                   v-for="item in softwareTypes"
                   :key="item.value"
                   :label="item.label"
                   :value="item.value">
                 </el-option>
               </el-select>
               </el-form-item>

           <el-form-item label="软著等级" prop="softwareCopyrightCertificateLevel">
             <el-select v-model="form.softwareCopyrightCertificateLevel" placeholder="请选择软著等级">
                 <el-option
                   v-for="item in softwareCopyrightCertificateLevels"
                   :key="item.value"
                   :label="item.label"
                   :value="item.value">
                 </el-option>
               </el-select>
               </el-form-item>
           <el-form-item label="主要功能" prop="mainFunction">
             <el-input v-model="form.mainFunction" placeholder="请输入软件主要功能描述" />
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
      width="720px"
      append-to-body
      :close-on-click-modal="false"
    >
      <!-- 导出字段选择区 -->
      <div class="export-container">
        <el-checkbox-group
          v-model="selectClist"
          class="export-checkbox-group"
        >
          <!-- 修复1：item.lable → item.label -->
          <el-checkbox
            v-for="item in checkList"
            :key="item.value"
            :label="item.value"
            class="export-checkbox"
          >
            {{ item.label }}
          </el-checkbox>
        </el-checkbox-group>
      </div>

      <!-- 底部操作按钮（修复2：用 div 包裹 slot，避免样式冲突） -->
      <div slot="footer" class="export-dialog-footer">
        <el-button @click="Excelopen = false">取 消</el-button>
        <el-button
          type="primary"
          icon="el-icon-download"
          @click="DowExcel"
        >
          导 出
        </el-button>
      </div>
    </el-dialog>
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="software"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
      <!--审核弹窗  -->
      <el-dialog
        title="审核审批"
        :visible.sync="AudisVisible"
        width="720px"
        append-to-body
        :close-on-click-modal="false"
      >
        <el-radio-group v-model="AudisStatis">
          <el-radio v-for="item in audisItems" :key="item" :label="item">{{item}}</el-radio>
        </el-radio-group>

        <div slot="footer" class="export-dialog-footer">
          <el-button @click="Excelopen = false">取 消</el-button>
          <el-button
            type="primary"
            icon="el-icon-edit"
            @click="EditAudios(AudisStatis)"
          >
            修改
          </el-button>
        </div>
      </el-dialog>
  </div>
</template>

<script>
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listSoftware, getSoftware, delSoftware, addSoftware, updateSoftware } from "@/api/software/software"
import Cookies from "js-cookie"
import { buildChangedPayload, cloneForm } from "@/utils/achievementUpdate"
import { buildDateRangeQuery } from "@/utils/dateRangeQuery"
export default {
  name: "Software",
  data() {
    return {
      //日期选择类型
      TimeType:"datetime",
      TimeFormat:"yyyy-MM-ddTHH:mm:ss",
      //是否为时间字段
      TimeFlag:false,
      //搜索内容
      SelectQueryParamsValue:null,
      //搜索字段
      SelectQueryParams:null,
      publishDateRange: [],
      registerDateRange: [],
      developmentDateRange: [],
      //审核选择项
      AudisStatis:"待审核",
      //审核选项列表 '通过','驳回','待审核','退回'
      audisItems: [
        '通过','驳回','待审核','退回'
      ],
      //审核弹窗
      AudisVisible:false,
      //管理员标识
      andminFlag:false,
      //导出记录
      idsCount:0,
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
        softwareId: null,
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
      originalForm: {},
      // 表单校验
      rules: {
        softwareName: [
          { required: true, message: "软件名称不能为空", trigger: "blur" },
          { min: 1, max: 100, message: "长度在 1 到 100 个字符", trigger: "blur" },
          {
            // 支持中英文、数字、书名号、括号、点、下划线及横杠
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s\.]+$/,
            message: "软件名称格式错误（支持中英文、数字、书名号、括号、点、下划线及横杠）",
            trigger: "blur"
          }
        ],
        softwareVersion: [
          { required: true, message: "软件版本不能为空", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          // 允许 V/v 开头，包含数字、点、横杠、下划线
          { pattern: /^[a-zA-Z0-9\.\-\_\s]+$/, message: "版本号格式错误，示例: V1.0.1", trigger: "blur" }
        ],
        certificateNo: [
          { required: true, message: "登记号不能为空", trigger: "blur" },
          // 软著登记号通常是年份+SR+数字，如 2023SR123456
          { pattern: /^[a-zA-Z0-9]+$/, message: "登记号格式错误（仅允许字母和数字）", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" }
        ],
        registerDate: [
          { required: true, message: "登记日期不能为空", trigger: "blur" }
        ],
        developmentDate: [
          { required: true, message: "开发完成日期不能为空", trigger: "blur" }
        ],
        programmingLanguage: [
          { required: true, message: "编程语言不能为空", trigger: "blur" },
          // 支持特殊字符：C++, C#, HTML/CSS, Node.js (需要支持 +, #, /, ., 空格)
          { pattern: /^[a-zA-Z0-9\+\#\.\/\s,;]+$/, message: "格式错误，示例: Java, C++, Python", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
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
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s,;，；]+$/, message: "格式错误，只能包含中英文、数字及分隔符", trigger: "blur" },
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
	    this.applyRouteQuery()
	    this.getList()
    /*管理权限标识符验证 显示隐藏组件*/
    const flag = Cookies.get("adminFlag")
    if(flag =="true")
    {
      this.andminFlag = true
    }
  },
	  methods: {
	    applyRouteQuery() {
	      const query = this.$route.query || {}
	      const recordIdField = query.recordIdField || "softwareId"
	      if (query.recordId && Object.prototype.hasOwnProperty.call(this.queryParams, recordIdField)) {
	        this.queryParams[recordIdField] = query.recordId
	      }
	      if (query.auditStatus) {
	        this.queryParams.auditStatus = query.auditStatus
	      }
	    },
	    /*查询输入字段验证时间组件*/
    changeQueryParams(res){
      console.log(res)
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt"||res=="publishDate"||res=="registerDate"||res=="developmentDate")
      {
        if(res=="publishDate"||res=="registerDate"||res=="developmentDate")
        {
          this.TimeFormat = "yyyy-MM-dd"
          this.TimeType = "date"
        }else{
           this.TimeFormat = "yyyy-MM-ddTHH:mm:ss"
           this.TimeType = "datetime"
        }
        console.log(this.TimeFormat)
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /*审核提交*/
    EditAudios(audis)
    {
      if (this.form.softwareId != null) {
        this.form.auditStatus = audis
        updateSoftware({
          softwareId: this.form.softwareId,
          auditStatus: audis
        }).then(response => {
          if(response.softwareId!=null)
          {
             this.$modal.msgSuccess("修改成功")
          }else{
              this.$modal.msgSuccess("修改成功，上传文件失败")
          }

          this.AudisVisible = false
          this.getList()
        })
      }
    },
    /*审核批改*/
    handleAudis(row){
      this.AudisStatis=row.auditStatus
       this.reset()
       const softwareId = row.softwareId || this.ids
       getSoftware(softwareId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询软著成果列表 */
    getList() {
      this.loading = true
      listSoftware(this.buildQueryParams()).then(response => {
        this.softwareList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    buildQueryParams() {
      return buildDateRangeQuery(this.queryParams, {
        PublishDate: this.publishDateRange,
        RegisterDate: this.registerDateRange,
        DevelopmentDate: this.developmentDateRange
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
      this.originalForm = {}
      this.files = []; // 清空绑定的文件数组
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
      this.queryParams.softwareId = null
      this.queryParams.softwareName = null
      this.queryParams.publishDate = null
      this.queryParams.softwareType = null
      this.queryParams.softwareCopyrightCertificateLevel = null
      this.queryParams.certificateType = null
      this.queryParams.applicationField = null
      this.queryParams.auditStatus = null
      this.queryParams.params = {}
      this.publishDateRange = []
      this.registerDateRange = []
      this.developmentDateRange = []
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
        this.originalForm = cloneForm(response.data)
        this.open = true
        this.title = "修改软著成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.softwareId != null) {
            const updatePayload = buildChangedPayload(this.form, this.originalForm, "softwareId")
            if (Object.keys(updatePayload).length === 1) {
              this.$modal.msgWarning("没有检测到修改内容")
              return
            }
            updateSoftware(updatePayload).then(response => {
              console.log(response)
              if(response.softwareId!=null)
              {
                 this.$refs.file.submitUpload(response.softwareId,"software");
                 this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            addSoftware(this.form).then(response => {

              if(response.softwareId!=null)
              {
                 this.$refs.file.submitUpload(response.softwareId,"software");
                 this.$modal.msgSuccess("新增成功")
              }else{
                  this.$modal.msgSuccess("新增成功,上传文件失败")
              }

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
          this.currentPaperId = row.softwareId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.softwareName || '软著'}`
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
         if(this.ids.length==0)
           {
             this.ids = this.softwareList.map(item=>item.softwareId)
           }
          const requestData = {
           idList:this.ids,
	          showColumns: this.selectClist || [],
	          data: {
	             ...this.buildQueryParams()
	          }
	         };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('software/software/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
<style scoped>
/* ================= 整体说明 ================= */
/* 该样式为导出功能弹窗的专属样式，使用 scoped 确保样式仅作用于当前组件
   基于 Element Plus 组件库的样式扩展，主要包含弹窗容器、复选框网格、底部按钮区样式
*/

/* ===== 导出弹窗主体容器 ===== */
.export-container {
  padding: 20px 24px;        /* 内边距：上下16px 左右20px，保证内容与边框间距 */
  background: #fafbfc;       /* 浅灰背景色，提升视觉层次感 */
  border-radius: 6px;        /* 圆角设计，统一产品视觉风格 */
  margin-bottom: 10px;       /* 新增：与底部按钮区分隔 */
}

/* ===== 复选框组 - 网格布局 ===== */
.export-checkbox-group {
  display: grid;                              /* 使用网格布局实现多列排列 */
  grid-template-columns: repeat(4, 1fr);      /* 平均分成4列，注释标注"4列最舒服"为视觉体验最优选择 */
  column-gap: 24px;                           /* 列之间的间距 24px，保证列间不拥挤 */
  row-gap: 14px;                              /* 行之间的间距 14px，平衡行高与紧凑度 */
}

/* ===== 单个复选框容器 ===== */
.export-checkbox {
  display: flex;               /* 弹性布局，使复选框与文字垂直居中对齐 */
  align-items: center;         /* 垂直居中，优化视觉对齐效果 */
  white-space: nowrap;         /* 文字不换行，避免标签文字被截断 */
}

/* 修复3：使用 ::v-deep 穿透 scoped（Vue2），Vue3 用 :deep() */
::v-deep .export-checkbox .el-checkbox__label {
  font-size: 14px;             /* 文字大小 14px，符合中台产品字体规范 */
  color: #303133;              /* 深灰色文字，保证可读性 */
  padding-left: 6px;           /* 与复选框保持6px间距，提升点击体验 */
}

/* ===== 弹窗底部按钮区域 ===== */
.export-dialog-footer {
  display: flex;               /* 弹性布局，控制按钮对齐方式 */
  justify-content: flex-end;   /* 按钮右对齐，符合弹窗交互习惯 */
  padding: 10px 20px;          /* 调整内边距，适配弹窗默认padding */
  border-top: 1px solid #ebeef5; /* 顶部分隔线，视觉区分内容区与操作区 */
  margin: 0 -20px -10px;       /* 抵消弹窗默认的padding，使分隔线全屏 */
}

/* ===== 主按钮（导出按钮）样式定制 ===== */
/* 修复4：提高优先级，覆盖Element默认样式 */
::v-deep .export-dialog-footer .el-button--primary {
  background-color: #409eff !important;   /* 定制主按钮背景色，统一品牌色调 */
  border-color: #409eff !important;       /* 定制边框色，与背景色一致 */
}

/* 主按钮 hover 状态 */
::v-deep .export-dialog-footer .el-button--primary:hover {
  background-color: #66b1ff !important;   /* hover 时浅化背景色，提供交互反馈 */
  border-color: #66b1ff !important;       /* 边框色同步变化 */
}

/* 主按钮 active 状态 */
::v-deep .export-dialog-footer .el-button--primary:active {
  background-color: #337ecc !important;   /* 点击时加深背景色，模拟按压效果 */
  border-color: #337ecc !important;       /* 边框色同步加深 */
}
</style>
