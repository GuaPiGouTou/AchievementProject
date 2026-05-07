<template>
  <div class="app-container">
     <el-form class="achievement-search-form patent-search-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="88px">
        <el-form-item label="专利名称" prop="patentName">
          <el-input v-model.trim="queryParams.patentName" placeholder="请输入专利名称关键词" clearable />
        </el-form-item>
        <el-form-item label="专利类型" prop="patentType">
          <el-select v-model="queryParams.patentType" placeholder="请选择专利类型" clearable filterable>
            <el-option
              v-for="item in patentTypes"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="专利状态" prop="patentStatus">
          <el-select v-model="queryParams.patentStatus" placeholder="请选择专利状态" clearable filterable>
            <el-option
              v-for="item in patentStatuss"
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
        <el-form-item label="技术领域" prop="technicalField">
          <el-input v-model.trim="queryParams.technicalField" placeholder="请输入技术领域关键词" clearable />
        </el-form-item>
        <el-form-item label="申请日期">
          <el-date-picker
            v-model="applicationDateRange"
            type="daterange"
            value-format="yyyy-MM-dd"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            clearable
          />
        </el-form-item>
        <el-form-item label="授权日期">
          <el-date-picker
            v-model="authorizationDateRange"
            type="daterange"
            value-format="yyyy-MM-dd"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            clearable
          />
        </el-form-item>
        <el-form-item label="公布日期">
          <el-date-picker
            v-model="publicationDateRange"
            type="daterange"
            value-format="yyyy-MM-dd"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            clearable
          />
        </el-form-item>
        <el-form-item label="有效期">
          <el-date-picker
            v-model="patentValidityRange"
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
      <el-table-column label="专利名称" align="center" prop="patentName" />
      <el-table-column label="专利号" align="center" prop="patentNo" />
      <el-table-column label="专利类型" align="center" prop="patentType" />
      <el-table-column label="发明人顺序" align="center" prop="authorOrder" />
      <el-table-column label="专利状态" align="center" prop="patentStatus" />
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
      <el-table-column label="授权号" align="center" prop="authorizationNo" min-width="140">
        <template slot-scope="scope">
          <span>{{ scope.row.authorizationNo }}</span>
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
      <el-table-column label="技术领域" align="center" prop="technicalField" />
      <el-table-column label="证书类型" align="center" prop="certificateType" :formatter="formatCertificateType" />
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
      <el-table-column v-if="$auth.hasPermi('patent:patent:edit')" label="审核" align="center" width="100">
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
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
      <el-form ref="form" :model="form" :rules="rules" text-align: right label-width="100px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
        <el-form-item label="专利名称" prop="patentName">
          <el-input v-model="form.patentName"  placeholder="请输入专利名称（支持中英文、数字、书名号及括号）" />
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
        <el-form-item label="公布日期" prop="publicationDate">
          <el-date-picker clearable
            v-model="form.publicationDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择公布日期">
          </el-date-picker>
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
<!--    <el-dialog
      :title="Exceltitle"
      :visible.sync="Excelopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">
       <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
        </el-checkbox-group>
       <el-badge :value="idsCount==0?patentList.length:idsCount" class="item"  >
        <el-button @click="DowExcel()" >导出</el-button>
       </el-badge>
    </el-dialog> -->

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
        attachment-type="patent"
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
import { listPatent, getPatent, delPatent, addPatent, updatePatent } from "@/api/patent/patent"
import Cookies from "js-cookie"
import { buildChangedPayload, cloneForm } from "@/utils/achievementUpdate"
import { buildDateRangeQuery } from "@/utils/dateRangeQuery"
export default {
  name: "Patent",
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
      applicationDateRange: [],
      publicationDateRange: [],
      authorizationDateRange: [],
      patentValidityRange: [],
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
      // 导出选择字段
      checkList: [
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
          value: 'patentStatus',
          label: '专利状态'
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
          value: 'authorizationNo',
          label: '授权号'
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
          value: 'technicalField',
          label: '技术领域'
        },
        {
          value: 'certificateType',
          label: '证书类型'
        },
        {
          value: 'auditStatus',
          label: '审核状态'
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
        { label: "公开状态", value: "公开状态" },
        { label: "实质审查", value: "实质审查" },
        { label: "已授权", value: "已授权" },
        { label: "已转让", value: "已转让" },
        { label: "已失效", value: "已失效" }
      ],

      // 3. 证书类型 (对应数据库 certificate_type)
      certificateTypes: [
        { label: "受理通知书", value: "application_notice" },
        { label: "发明专利申请公布通知书", value: "publication_notice" },
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
        patentId: null,
        patentName: null,
        patentType: null,
        patentStatus: null,
        certificateType: null,
        technicalField: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
      originalForm: {},
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
       patentStatus: [
         { required: true, message: "专利状态不能为空", trigger: "change" }
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
	      const recordIdField = query.recordIdField || "patentId"
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
      if(res=="updatedAt"||res=="createdAt"||res=="patentValidity"||res=="authorizationDate"||res=="publicationDate"||res=="applicationDate")
      {
        if(res=="patentValidity"||res=="authorizationDate"||res=="publicationDate"||res=="applicationDate")
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
      if (this.form.patentId != null) {
        this.form.auditStatus = audis
        updatePatent({
          patentId: this.form.patentId,
          auditStatus: audis
        }).then(response => {
          if(response.patentId!=null)
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
       const patentId = row.patentId || this.ids
       getPatent(patentId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询专利成果列表 */
    getList() {
      this.loading = true
      listPatent(this.buildQueryParams()).then(response => {
        this.patentList = (response.rows || []).map(this.normalizePatentRow)
        this.total = response.total
        this.loading = false
      })
    },
    buildQueryParams() {
      return buildDateRangeQuery(this.queryParams, {
        ApplicationDate: this.applicationDateRange,
        PublicationDate: this.publicationDateRange,
        AuthorizationDate: this.authorizationDateRange,
        PatentValidity: this.patentValidityRange
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
        authorizationNo: null,
        patentValidity: null,
        patentSubject: null,
        patentStatus: null,
        technicalField: null,
        certificateType: null,
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
      this.queryParams.patentId = null
      this.queryParams.patentName = null
      this.queryParams.patentType = null
      this.queryParams.patentStatus = null
      this.queryParams.certificateType = null
      this.queryParams.technicalField = null
      this.queryParams.auditStatus = null
      this.queryParams.params = {}
      this.applicationDateRange = []
      this.publicationDateRange = []
      this.authorizationDateRange = []
      this.patentValidityRange = []
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
        this.form = this.normalizePatentRow(response.data || {})
        this.originalForm = cloneForm(this.form)
        this.open = true
        this.title = "修改专利成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.patentId != null) {
            const updatePayload = buildChangedPayload(this.form, this.originalForm, "patentId", {
              excludeFields: ["legalStatus"]
            })
            if (Object.keys(updatePayload).length === 1) {
              this.$modal.msgWarning("没有检测到修改内容")
              return
            }
            updatePayload.patentStatus = this.form.patentStatus
            updatePatent(updatePayload).then(response => {
              if(response.patentId!=null)
              {
                 this.$refs.file.submitUpload(response.patentId,"patent");
                 this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            this.form.legalStatus = null
            addPatent(this.form).then(response => {
              if(response.patentId!=null)
              {
                 this.$refs.file.submitUpload(response.patentId,"patent");
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
    normalizePatentRow(row) {
      if (!row) {
        return row
      }
      const normalized = { ...row }
      normalized.authorizationNo = normalized.authorizationNo || normalized.authorization_no || ""
      return normalized
    },
    formatCertificateType(row, column, value) {
      const item = this.certificateTypes.find(option => option.value === value)
      return item ? item.label : value
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
          this.currentPaperId = row.patentId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.patentName || '专利'}`
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
            this.ids = this.patentList.map(item=>item.patentId)
          }
         const requestData = {
          idList:this.ids,
	           showColumns: this.selectClist || [],
	           data: {
	             ...this.buildQueryParams()
	           }
	          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('patent/patent/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
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
