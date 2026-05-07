<template>
  <div class="app-container">
     <el-form class="achievement-search-form" :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="专著名称" prop="monographTitle">
        <el-input v-model.trim="queryParams.monographTitle" placeholder="请输入专著名称关键词" clearable />
      </el-form-item>
      <el-form-item label="作者角色" prop="authorRole">
        <el-select v-model="queryParams.authorRole" placeholder="请选择作者角色" clearable filterable>
          <el-option
            v-for="item in authorRoles"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="专著类型" prop="monographType">
        <el-select v-model="queryParams.monographType" placeholder="请选择专著类型" clearable filterable>
          <el-option
            v-for="item in monographTypes"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="著作语言" prop="language">
        <el-select v-model="queryParams.language" placeholder="请选择著作语言" clearable filterable>
          <el-option
            v-for="item in languages"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否收录" prop="isIncluded">
        <el-select v-model="queryParams.isIncluded" placeholder="请选择是否收录" clearable>
          <el-option
            v-for="item in isIncludedOptions"
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
      <el-form-item label="学科分类" prop="subjectCategory">
        <el-input v-model.trim="queryParams.subjectCategory" placeholder="请输入学科分类关键词" clearable />
      </el-form-item>
      <el-form-item label="出版时间">
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
          v-hasPermi="['monograph:monograph:add']"
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
          v-hasPermi="['monograph:monograph:edit']"
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
          v-hasPermi="['monograph:monograph:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['monograph:monograph:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="monographList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="专著名称" align="center" prop="monographTitle" />
      <el-table-column label="作者角色" align="center" prop="authorRole" />
      <el-table-column label="出版社" align="center" prop="pressName" />
      <el-table-column label="ISBN号" align="center" prop="isbnNumber" />
      <el-table-column label="出版时间" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="专著类型" align="center" prop="monographType" />
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="字数" align="center" prop="wordCount" />
      <el-table-column label="页数" align="center" prop="pageCount" />
      <el-table-column label="著作语言" align="center" prop="language" />
      <el-table-column label="学科分类" align="center" prop="subjectCategory" />
      <el-table-column label="是否被收录" align="center" prop="isIncluded" :formatter="formatIsIncluded" />
      <el-table-column label="收录数据库" align="center" prop="includedDatabase" />
      <el-table-column label="获奖情况" align="center" prop="awardSituation" />
      <el-table-column label="合著者信息" align="center" prop="coAuthors" />
      <el-table-column label="国际标准书号" align="center" prop="internationalStandardBookNumber" />
      <el-table-column label="中国分类号" align="center" prop="chinaClassificationNumber" />
            <el-table-column v-if="showArchivalTypeField" label="归档类别" align="center" prop="archivalType" :formatter="formatArchivalType" />
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

          <el-table-column v-if="$auth.hasPermi('monograph:monograph:edit')" label="审核" align="center" width="100">
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
            v-hasPermi="['monograph:monograph:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['monograph:monograph:remove']"
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
    <AttachmentManagement
      :visible="attachmentVisible"
      :title="attachmentTitle"
      :resource-id="currentPaperId"
      attachment-type="monograph"
      @update:visible="attachmentVisible = $event"
      @close="handleAttachmentClose"
      @load-success="handleAttachmentLoadSuccess"
      @download-success="handleDownloadSuccess"
      @delete-success="handleDeleteSuccess"
    />
    <!-- 添加或修改成果专著对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body:close-on-click-modal="false" @close="cancel">
          <el-form ref="form" :model="form" :rules="rules" text-align: right label-width="100px"style="max-height: 60vh; overflow-y: auto; padding-right: 10px;">
            <el-form-item label="专著名称" prop="monographTitle">
              <el-input v-model="form.monographTitle"  placeholder="请输入专著名称（支持书名号、括号、冒号及顿号）" />
            </el-form-item>
            <el-form-item label="出版社" prop="pressName">
              <el-input v-model="form.pressName" placeholder="请输入出版社全称（支持中英文括号及点号）" />
            </el-form-item>
            <el-form-item label="ISBN号" prop="isbnNumber">
              <el-input v-model="form.isbnNumber" placeholder="请输入ISBN号 (如: 978-7-123-45678-9)" />
            </el-form-item>
    		<el-form-item label="作者角色" prop="authorRole">
    		  <el-select v-model="form.authorRole" placeholder="请选择作者角色">
    		      <el-option
    		        v-for="item in authorRoles"
    		        :key="item.value"
    		        :label="item.label"
    		        :value="item.value">
    		      </el-option>
    		    </el-select>
            </el-form-item>
            <el-form-item label="出版时间" prop="publishDate">
              <el-date-picker clearable
                v-model="form.publishDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择出版时间">
              </el-date-picker>
            </el-form-item>
    		<el-form-item label="专著类型" prop="monographType">
    		  <el-select v-model="form.monographType" placeholder="请选择专著类型">
    		      <el-option
    		        v-for="item in monographTypes"
    		        :key="item.value"
    		        :label="item.label"
    		        :value="item.value">
    		      </el-option>
    		    </el-select>
    		</el-form-item>
    		<el-form-item label="著作语言" prop="language">
    		  <el-select v-model="form.language" placeholder="请选择著作语言">
    		      <el-option
    		        v-for="item in languages"
    		        :key="item.value"
    		        :label="item.label"
    		        :value="item.value">
    		      </el-option>
    		    </el-select>
    		</el-form-item>
            <el-form-item label="版次" prop="edition">
              <el-input v-model="form.edition" placeholder="请输入版次 (如: 第3版第2次印刷（2025年修订版）)" />
            </el-form-item>
            <el-form-item label="字数" prop="wordCount">
              <el-input v-model="form.wordCount" placeholder="请输入字数 (万字，支持小数)" />
            </el-form-item>
            <el-form-item label="页数" prop="pageCount">
              <el-input v-model="form.pageCount" placeholder="请输入页数 (正整数)" />
            </el-form-item>
            <el-form-item label="学科分类" prop="subjectCategory">
              <el-input v-model="form.subjectCategory" placeholder="请输入学科分类" />
            </el-form-item>
            <el-form-item label="是否被收录" prop="isIncluded">
              <el-select v-model="form.isIncluded" placeholder="请选择是否被收录" style="width: 100%">
                <el-option
                  v-for="item in isIncludedOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="收录数据库" prop="includedDatabase">
              <el-input v-model="form.includedDatabase" placeholder="请输入收录数据库" />
            </el-form-item>
            <el-form-item label="获奖情况" prop="awardSituation">
              <el-input v-model="form.awardSituation"  placeholder="请输入获奖情况描述" />
            </el-form-item>
            <el-form-item label="合著者信息" prop="coAuthors">
              <el-input v-model="form.coAuthors"  placeholder="请输入合著者姓名，多人请用逗号分隔" />
            </el-form-item>
            <el-form-item label="国际标准书号" prop="internationalStandardBookNumber">
              <el-input v-model="form.internationalStandardBookNumber" placeholder="请输入国际标准书号" />
            </el-form-item>
            <el-form-item label="中国分类号" prop="chinaClassificationNumber">
              <el-input v-model="form.chinaClassificationNumber" placeholder="请输入中国分类号 (如: TP311)" />
            </el-form-item>
            <el-form-item v-if="showArchivalTypeField" label="归档类别" prop="archivalType">
              <el-select v-model="form.archivalType" placeholder="请选择归档类别">
                  <el-option
                    v-for="item in archivalTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
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
                <el-badge :value="idsCount==0?monographList.length:idsCount" class="item"  >
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
            <el-button @click="AudisVisible = false">取 消</el-button>
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
import { listMonograph, getMonograph, delMonograph, addMonograph, updateMonograph } from "@/api/monograph/monograph"
import Cookies from "js-cookie"
import { buildDateRangeQuery } from "@/utils/dateRangeQuery"
export default {
  name: "Monograph",
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
      //审核选择项
      AudisStatis:"待审核",
      //审核选项列表 '通过','驳回','待审核','退回'
      audisItems: [
      '通过','驳回','待审核','退回'
      ],
      //审核弹窗
      AudisVisible:false,
      //管理员标识
      adminFlag:false,
      isStudentUser: false,
      //导出记录
      idsCount:0,
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      //导出选择字段
      checkList: [
              {
                value: 'monographId',
                label: '专著ID'
              }, {
                value: 'monographTitle',
                label: '专著名称'
              }, {
                value: 'authorRole',
                label: '作者角色'
              }, {
                value: 'pressName',
                label: '出版社'
              }, {
                value: 'isbnNumber',
                label: 'ISBN号'
              }, {
                value: 'publishDate',
                label: '出版时间'
              }, {
                value: 'monographType',
                label: '专著类型'
              }, {
                value: 'edition',
                label: '版次'
              }, {
                value: 'wordCount',
                label: '字数(万字)'
              }, {
                value: 'pageCount',
                label: '页数'
              }, {
                value: 'language',
                label: '著作语言'
              }, {
                value: 'subjectCategory',
                label: '学科分类'
              }, {
                value: 'isIncluded',
                label: '是否被收录'
              }, {
                value: 'includedDatabase',
                label: '收录数据库'
              }, {
                value: 'awardSituation',
                label: '获奖情况'
              }, {
                value: 'coAuthors',
                label: '合著者信息'
              }, {
                value: 'internationalStandardBookNumber',
                label: '国际标准书号'
              }, {
                value: 'chinaClassificationNumber',
                label: '中国分类号'
              }, {
        value:'archivalType',
        label:'归档类别'
      }, {
                value: 'auditStatus',
                label: '审核状态'
              }
            ],
      selectClist:[],
      archivalTypes: [
        { label: "教育教学改革", value: "teachingCategory" },
        { label: "课程设计", value: "researchOriented" }
      ],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
		//上传文件组件
		files:[],
	// 1. 作者角色 (对应数据库 author_role)
		authorRoles: [
		  { label: "独著", value: "独著" },
		  { label: "主编", value: "主编" },
		  { label: "副主编", value: "副主编" },
		  { label: "参编", value: "参编" },
		  { label: "译者", value: "译者" },
		  { label: "编者", value: "编者" }
		],

		// 2. 专著类型 (对应数据库 monograph_type)
		monographTypes: [
		  { label: "学术专著", value: "学术专著" },
		  { label: "教材", value: "教材" },
		  { label: "译著", value: "译著" },
		  { label: "编著", value: "编著" },
		  { label: "科普著作", value: "科普著作" },
		  { label: "工具书", value: "工具书" },
		  { label: "论文集", value: "论文集" }
		],

		// 3. 著作语言 (对应数据库 language)
		languages: [
		  { label: "中文", value: "中文" },
		  { label: "英文", value: "英文" },
		  { label: "其他", value: "其他" }
		],
      isIncludedOptions: [
        { label: "是", value: 1 },
        { label: "否", value: 0 }
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
      // 成果专著表格数据
      monographList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        monographId: null,
        monographTitle: null,
        authorRole: null,
        publishDate: null,
        monographType: null,
        language: null,
        isIncluded: null,
        subjectCategory: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      originalForm: {},
      // 表单校验
      rules: {
	        monographTitle: [
	          { required: true, message: "专著名称不能为空", trigger: "blur" },
	          { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
	          {
	            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9《》\(\)（）\：:，,。；;\-\s、·\.]+$/,
	            message: "专著名称格式错误（仅允许中英文、数字及常见中文标点）",
	            trigger: "blur"
	          }
	        ],
        authorRole: [
          { required: true, message: "作者角色不能为空", trigger: "change" }
        ],
	        pressName: [
	          { required: true, message: "出版社不能为空", trigger: "blur" },
	          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
	          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\-\s、·]+$/, message: "出版社名称格式错误（仅允许中英文、数字及常见标点）", trigger: "blur" }
	        ],
        isbnNumber: [
          { required: true, message: "ISBN号不能为空", trigger: "blur" },
          { pattern: /^[0-9\-\s]{9,17}[0-9xX]$/, message: "ISBN格式错误，示例: 978-7-123-45678-9", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "出版时间不能为空", trigger: "blur" }
        ],
        monographType: [
          { required: true, message: "专著类型不能为空", trigger: "change" }
        ],
	        edition: [
	          { required: false, message: "请输入版次", trigger: "blur" },
	          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
	          {
	            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s\.\-\(\)（）：:，,]+$/,
	            message: "版次格式错误，示例：第3版第2次印刷（2025年修订版）",
	            trigger: "blur"
	          }
        ],
        wordCount: [
          { required: false, message: "请输入字数", trigger: "blur" },
          { pattern: /^\d+(\.\d{1,4})?$/, message: "请输入有效的数字（支持小数）", trigger: "blur" }
        ],
        pageCount: [
          { required: false, message: "请输入页数", trigger: "blur" },
          { pattern: /^[1-9]\d*$/, message: "页数必须为正整数", trigger: "blur" }
        ],
        language: [
          { required: false, message: "请选择著作语言", trigger: "change" }
        ],
        subjectCategory: [
          { required: false, message: "请输入学科分类", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" }
        ],
        includedDatabase: [
          { required: false, message: "请输入收录数据库", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
	        coAuthors: [
	          { required: false, message: "请输入合著者信息", trigger: "blur" },
	          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s,;，；\.·]+$/, message: "格式错误，多个合著者请用逗号或分号分隔", trigger: "blur" }
	        ],
	        chinaClassificationNumber: [
	          { required: false, message: "请输入中国分类号", trigger: "blur" },
	          { pattern: /^[a-zA-Z][a-zA-Z0-9\.]*$/, message: "分类号格式错误 (例如: TP311)", trigger: "blur" }
	        ],
        internationalStandardBookNumber: [
          { required: false, message: "请输入国际标准书号", trigger: "blur" },
          { pattern: /^[0-9\-\s]{9,17}[0-9xX]$/, message: "标准书号格式不正确", trigger: "blur" }
        ]
      }
    }
  },
	  created() {
	    this.applyRouteQuery()
	    this.getList()
	    this.initUserRoleScope()
    /*管理权限标识符验证 显示隐藏组件*/
    const flag = Cookies.get("adminFlag")
    if(flag =="true")
    {
      this.adminFlag = true
    }
  },
  computed: {
    showArchivalTypeField() {
      return !this.isStudentUser
    },
    searchCheckList() {
      return this.checkList.filter((item) => {
        if (/id$/i.test(item.value)) {
          return false
        }
        if (item.value === "archivalType" && this.isStudentUser) {
          return false
        }
        if ((item.value === "updatedAt" || item.value === "createdAt") && !this.adminFlag) {
          return false
        }
        return true
      })
    }
  },
	  methods: {
	    applyRouteQuery() {
	      const query = this.$route.query || {}
	      const recordIdField = query.recordIdField || "monographId"
	      if (query.recordId && Object.prototype.hasOwnProperty.call(this.queryParams, recordIdField)) {
	        this.queryParams[recordIdField] = query.recordId
	      }
	      if (query.auditStatus) {
	        this.queryParams.auditStatus = query.auditStatus
	      }
	    },
		    formatArchivalType(row, column, value) {
	      const item = this.archivalTypes.find(option => option.value === value)
	      return item ? item.label : value
	    },
	    formatIsIncluded(row, column, value) {
	      const item = this.isIncludedOptions.find(option => String(option.value) === String(value))
	      return item ? item.label : value
	    },
		    initUserRoleScope() {
	      const roleKeys = (this.$store.getters.roles || []).map(item => String(item))
	      this.isStudentUser = roleKeys.includes("student") || roleKeys.includes("studentAdministrator")
	    },
	    handleApiError(error) {
	      console.error(error)
	    },
	    cloneForm(data) {
	      return JSON.parse(JSON.stringify(data || {}))
	    },
	    normalizeCompareValue(value) {
	      return value === undefined ? null : value
	    },
	    buildMonographUpdatePayload() {
	      const fields = [
	        "monographTitle",
	        "authorRole",
	        "pressName",
	        "isbnNumber",
	        "publishDate",
	        "monographType",
	        "edition",
	        "wordCount",
	        "pageCount",
	        "language",
	        "subjectCategory",
	        "isIncluded",
	        "includedDatabase",
	        "awardSituation",
	        "coAuthors",
	        "internationalStandardBookNumber",
	        "chinaClassificationNumber",
	        "auditStatus"
	      ]
	      const payload = { monographId: this.form.monographId }
	      fields.forEach(field => {
	        const currentValue = this.normalizeCompareValue(this.form[field])
	        const originalValue = this.normalizeCompareValue(this.originalForm[field])
	        if (String(currentValue) !== String(originalValue)) {
	          payload[field] = this.form[field]
	        }
	      })
	      return payload
	    },
	    showFirstValidationError(fields) {
	      const firstField = fields && Object.keys(fields)[0]
	      const firstError = firstField && fields[firstField] && fields[firstField][0]
	      if (firstError && firstError.message) {
	        this.$modal.msgError(firstError.message)
	      }
	    },
	    /*查询输入字段验证时间组件*/
	    changeQueryParams(res){
      this.SelectQueryParamsValue = null;
      if(res=="updatedAt"||res=="createdAt"||res=="competitionTime"||res=="awardDate")
      {
        if(res=="awardDate")
        {
          this.TimeFormat = "yyyy-MM-dd"
          this.TimeType = "date"
        }else{
           this.TimeFormat = "yyyy-MM-ddTHH:mm:ss"
           this.TimeType = "datetime"
        }
        this.TimeFlag = true
      }else{
         this.TimeFlag = false
      }
    },
    /*审核提交*/
    EditAudios(audis)
    {
	  if (this.form.monographId != null) {
	    this.form.auditStatus = audis
	    updateMonograph({
	      monographId: this.form.monographId,
	      auditStatus: audis
	    }).then(response => {
          if(response.monographId!=null)
          {
             this.$modal.msgSuccess("修改成功")
          }else{
              this.$modal.msgSuccess("修改成功，上传文件失败")
          }

	          this.AudisVisible = false
	          this.getList()
	        }).catch(error => this.handleApiError(error))
	      }
	    },
    /*审核批改*/
    handleAudis(row){
      this.AudisStatis=row.auditStatus
       this.reset()
       const monographId = row.monographId || this.ids
       getMonograph(monographId).then(response => {
         this.form = response.data
         this.AudisVisible=true
       })
    },
    /** 查询成果专著列表 */
    getList() {
      this.loading = true
      listMonograph(this.buildQueryParams()).then(response => {
        this.monographList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    buildQueryParams() {
      return buildDateRangeQuery(this.queryParams, {
        PublishDate: this.publishDateRange
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
        monographId: null,
        userId: null,
        deptId: null,
        monographTitle: null,
        authorRole: null,
        pressName: null,
        isbnNumber: null,
        publishDate: null,
        monographType: null,
        edition: null,
        wordCount: null,
        pageCount: null,
        language: null,
        subjectCategory: null,
        isIncluded: null,
        includedDatabase: null,
        awardSituation: null,
        coAuthors: null,
        internationalStandardBookNumber: null,
        chinaClassificationNumber: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null,
	        archivalType: null
	      }
	      this.originalForm = {}
	      this.files = []; // 清空绑定的文件数组
	      this.resetForm("form")
    },
    clearCurrentSearch() {
      if (this.SelectQueryParams) {
        this.queryParams[this.SelectQueryParams] = null
      }
      this.SelectQueryParamsValue = null
      this.TimeFlag = false
    },

   /** 搜索按钮操作 */
     handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
     },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.queryParams.monographId = null
      this.queryParams.monographTitle = null
      this.queryParams.authorRole = null
      this.queryParams.publishDate = null
      this.queryParams.monographType = null
      this.queryParams.language = null
      this.queryParams.isIncluded = null
      this.queryParams.subjectCategory = null
      this.queryParams.auditStatus = null
      this.queryParams.params = {}
      this.publishDateRange = []
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.monographId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加成果专著"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
	      const monographId = row.monographId || this.ids
	      getMonograph(monographId).then(response => {
	        this.form = response.data
	        this.originalForm = this.cloneForm(response.data)
	        this.open = true
	        this.title = "修改成果专著"
	      })
    },
	    /** 提交按钮 */
	    submitForm() {
	      this.$refs["form"].validate((valid, fields) => {
	        if (!valid) {
	          this.showFirstValidationError(fields)
	          return
	        }
	          if (!this.showArchivalTypeField) {
	            this.form.archivalType = null
	          } else {
            if (!this.form.archivalType) {
              this.$modal.msgError("归档类别为必填项")
              return
            }
            if (!this.archivalTypes.find(item => item.value === this.form.archivalType)) {
              this.$modal.msgError("归档类别无效，请重新选择")
              return
            }
          }
	              if (this.form.monographId != null) {
	              const updatePayload = this.buildMonographUpdatePayload()
	              if (Object.keys(updatePayload).length === 1) {
	                this.$modal.msgWarning("没有检测到修改内容")
	                return
	              }
	              updateMonograph(updatePayload).then(response => {
              if(response.monographId!=null)
              {
                  this.$refs.file.submitUpload(response.monographId,"monograph");
                  this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }

	              this.open = false
	              this.getList()
	            }).catch(error => this.handleApiError(error))
	          } else {
	            addMonograph(this.form).then(response => {
              if(response.monographId!=null)
              {
                 this.$refs.file.submitUpload(response.monographId,"monograph");
                  this.$modal.msgSuccess("新增成功")
              }else{
                  this.$modal.msgSuccess("新增成功,上传文件失败")
              }

	              this.open = false
	              this.getList()
	            }).catch(error => this.handleApiError(error))
	          }
	      })
	    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const monographIds = row.monographId || this.ids
      this.$modal.confirm('是否确认删除成果专著编号为"' + monographIds + '"的数据项？').then(function() {
        return delMonograph(monographIds)
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
          this.currentPaperId = row.monographId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.monographTitle || '专著'}`
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
            this.ids = this.monographList.map(item=>item.monographId)
          }
         const requestData = {
          idList:this.ids,
	           showColumns: this.selectClist || [],
	           data: {
	             ...this.buildQueryParams()
	           }
	          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('monograph/monograph/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       },

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
