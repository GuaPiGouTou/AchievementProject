<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目编号" prop="projectNumber">
        <el-input
          v-model="queryParams.projectNumber"
          placeholder="请输入项目编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="负责人" prop="principal">
        <el-input
          v-model="queryParams.principal"
          placeholder="请输入负责人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="总经费" prop="totalFunding">
        <el-input
          v-model="queryParams.totalFunding"
          placeholder="请输入总经费"
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
      <el-form-item label="更新时间" prop="updatedAt">
        <el-date-picker clearable
          v-model="queryParams.updatedAt"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择更新时间">
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
          v-hasPermi="['research:research:add']"
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
          v-hasPermi="['research:research:edit']"
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
          v-hasPermi="['research:research:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['research:research:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="researchList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="项目id" align="center" prop="researchId" />
      <el-table-column label="项目编号" align="center" prop="projectNumber" />
      <el-table-column label="项目类别" align="center" prop="projectCategory" />
      <el-table-column label="项目级别" align="center" prop="projectLevel" />
      <el-table-column label="项目类型" align="center" prop="projectType" />
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="负责人" align="center" prop="principal" />
      <el-table-column label="参与人" align="center" prop="participants" />
      <el-table-column label="立项单位" align="center" prop="organizingUnit" />
      <el-table-column label="总经费" align="center" prop="totalFunding" />
      <el-table-column label="已到账经费" align="center" prop="receivedFunding" />
      <el-table-column label="经费拨款单位" align="center" prop="fundingUnit" />
      <el-table-column label="开始时间" align="center" prop="startDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="实际结题时间" align="center" prop="actualEndDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.actualEndDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="项目状态" align="center" prop="projectStatus" />
      <el-table-column label="结题状态" align="center" prop="completionStatus" />
      <el-table-column label="研究领域" align="center" prop="researchField" />
      <el-table-column label="审核状态" align="center" prop="auditStatus" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}-{h}:{m}:{ss}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}-{h}:{m}:{ss}') }}</span>
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
            v-hasPermi="['research:research:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['research:research:remove']"
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

    <!-- 添加或修改项目成果对话框 -->
    <!-- 添加或修改项目成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="项目编号" prop="projectNumber">
          <el-input v-model="form.projectNumber" placeholder="请输入项目编号（字母、数字、横线）" />
        </el-form-item>

        <el-form-item label="项目类别" prop="projectCategory">
          <el-select v-model="form.projectCategory" placeholder="请选择项目类别" style="width: 100%">
            <el-option
              v-for="item in projectCategorys"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <!-- 修复点：prop 改为 projectLevel，之前写成了 projectCategory -->
        <el-form-item label="项目级别" prop="projectLevel">
          <el-select v-model="form.projectLevel" placeholder="请选择项目级别" style="width: 100%">
            <el-option
              v-for="item in projectLevels"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="项目类型" prop="projectType">
          <el-input v-model="form.projectType" placeholder="请输入项目类型" />
        </el-form-item>

        <!-- 修复点：prop 改为 projectStatus，之前写成了 projectCategory -->
        <el-form-item label="项目状态" prop="projectStatus">
          <el-select v-model="form.projectStatus" placeholder="请选择项目状态" style="width: 100%">
            <el-option
              v-for="item in projectStatuss"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="结题状态" prop="completionStatus">
          <el-select v-model="form.completionStatus" placeholder="请选择结题状态" style="width: 100%">
            <el-option
              v-for="item in completionStatuss"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" type="textarea" placeholder="请输入项目名称（支持中英文、数字及常用标点）" />
        </el-form-item>

        <el-form-item label="负责人" prop="principal">
          <el-input v-model="form.principal" placeholder="请输入负责人姓名（支持中英文）" />
        </el-form-item>

        <el-form-item label="参与人" prop="participants">
          <el-input v-model="form.participants" type="textarea" placeholder="请输入参与人信息" />
        </el-form-item>

        <el-form-item label="立项单位" prop="organizingUnit">
          <el-input v-model="form.organizingUnit" placeholder="请输入立项单位全称" />
        </el-form-item>

        <el-row>
          <el-col :span="12">
            <el-form-item label="总经费" prop="totalFunding">
              <el-input v-model="form.totalFunding" placeholder="例: 10.50">
                <template slot="append">万元</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="已到账经费" prop="receivedFunding">
              <el-input v-model="form.receivedFunding" placeholder="例: 5.00">
                <template slot="append">万元</template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="经费拨款单位" prop="fundingUnit">
          <el-input v-model="form.fundingUnit" placeholder="请输入经费拨款单位" />
        </el-form-item>

        <el-row>
          <el-col :span="12">
            <el-form-item label="开始时间" prop="startDate">
              <el-date-picker clearable
                style="width: 100%"
                v-model="form.startDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择开始时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="结束时间" prop="endDate">
              <el-date-picker clearable
                style="width: 100%"
                v-model="form.endDate"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择结束时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="实际结题时间" prop="actualEndDate">
          <el-date-picker clearable
            style="width: 100%"
            v-model="form.actualEndDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择实际结题时间">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="研究领域" prop="researchField">
          <el-input v-model="form.researchField" placeholder="请输入研究领域" />
        </el-form-item>

        <el-form-item label="上传文件">
          <file-upload ref="file" v-model="files"></file-upload>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="research"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
      <el-dialog
        :title="Exceltitle"
        :visible.sync="Excelopen"
        width="600px"
        append-to-body
        :close-on-click-modal="false">
         <el-checkbox-group  class="custom-checkbox-group" v-model="selectClist"  >
            <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.label}}</el-checkbox>
          </el-checkbox-group>
          <el-badge :value="idsCount==0?researchList.length:idsCount" class="item"  >
            <el-button @click="DowExcel()" >导出</el-button>
          </el-badge>
      </el-dialog>
  </div>
</template>

<script>
import AttachmentManagement from "@/components/AttManage/AttachmentManagement.vue"
import { listResearch, getResearch, delResearch, addResearch, updateResearch } from "@/api/research/research"

export default {
  name: "Research",
  data() {
        return {
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
            value: 'researchId',
            label: '项目id'
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
            value: 'projectNumber',
            label: '项目编号'
          },
          {
            value: 'projectCategory',
            label: '项目类别'
          },
          {
            value: 'projectLevel',
            label: '项目级别'
          },
          {
            value: 'projectType',
            label: '项目类型'
          },
          {
            value: 'projectName',
            label: '项目名称'
          },
          {
            value: 'principal',
            label: '负责人'
          },
          {
            value: 'participants',
            label: '参与人'
          },
          {
            value: 'organizingUnit',
            label: '立项单位'
          },
          {
            value: 'totalFunding',
            label: '总经费'
          },
          {
            value: 'receivedFunding',
            label: '已到账经费'
          },
          {
            value: 'fundingUnit',
            label: '经费拨款单位'
          },
          {
            value: 'startDate',
            label: '开始时间'
          },
          {
            value: 'endDate',
            label: '结束时间'
          },
          {
            value: 'actualEndDate',
            label: '实际结题时间'
          },
          {
            value: 'projectStatus',
            label: '项目状态'
          },
          {
            value: 'completionStatus',
            label: '结题状态'
          },
          {
            value: 'researchField',
            label: '研究领域'
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
       // 1. 项目类别 (对应数据库 enum: '纵向项目','横向项目')
        projectCategorys: [
          { label: "纵向项目", value: "纵向项目" },
          { label: "横向项目", value: "横向项目" }
        ],

        // 2. 项目级别 (对应数据库 enum: '国家级','省部级','市厅级','校级','企业级','国际合作')
        projectLevels: [
          { label: "国家级", value: "国家级" },
          { label: "省部级", value: "省部级" },
          { label: "市厅级", value: "市厅级" },
          { label: "校级", value: "校级" },
          { label: "企业级", value: "企业级" },
          { label: "国际合作", value: "国际合作" }
        ],

        // 3. 项目状态 (对应数据库 enum: '在研','已结题','延期','终止','验收中','申报中')
        projectStatuss: [
          { label: "在研", value: "在研" },
          { label: "已结题", value: "已结题" },
          { label: "延期", value: "延期" },
          { label: "终止", value: "终止" },
          { label: "验收中", value: "验收中" },
          { label: "申报中", value: "申报中" }
        ],

        // 4. 结题状态 (对应数据库 enum: '未结题','已结题','结题优秀','结题合格','结题不合格')
        completionStatuss: [
          { label: "未结题", value: "未结题" },
          { label: "已结题", value: "已结题" },
          { label: "结题优秀", value: "结题优秀" },
          { label: "结题合格", value: "结题合格" },
          { label: "结题不合格", value: "结题不合格" }
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
      // 项目成果表格数据
      researchList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectNumber: null,
        projectName: null,
        principal: null,
        totalFunding: null,
        projectStatus: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        projectNumber: [
          { required: true, message: "项目编号不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          {
            pattern: /^[A-Za-z0-9\-_]+$/,
            message: "项目编号仅支持字母、数字、下划线及中划线",
            trigger: "blur"
          }
        ],
        projectCategory: [
          { required: true, message: "请选择项目类别", trigger: "change" }
        ],
        projectLevel: [
          { required: true, message: "请选择项目级别", trigger: "change" }
        ],
        projectType: [
          { required: true, message: "项目类型不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        projectName: [
          { required: true, message: "项目名称不能为空", trigger: "blur" },
          { max: 500, message: "长度不能超过 500 个字符", trigger: "blur" },
          {
            // 允许中文、英文、数字、括号、书名号、破折号等常用符号
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\_\s\.]+$/,
            message: "项目名称包含非法字符",
            trigger: "blur"
          }
        ],
        principal: [
          { required: true, message: "负责人不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          {
            pattern: /^[\u4e00-\u9fa5a-zA-Z\.\·\s]+$/,
            message: "负责人姓名仅支持中文、英文、点和空格",
            trigger: "blur"
          }
        ],
        participants: [
          { required: false, message: "请输入参与人", trigger: "blur" },
          { max: 2000, message: "内容过长", trigger: "blur" }
        ],
        organizingUnit: [
          { required: true, message: "立项单位不能为空", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          {
            pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\-\s]+$/,
            message: "单位名称格式不正确",
            trigger: "blur"
          }
        ],
        totalFunding: [
          { required: true, message: "总经费不能为空", trigger: "blur" },
          {
            pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/,
            message: "请输入正确的金额，最多保留两位小数",
            trigger: "blur"
          }
        ],
        receivedFunding: [
          { required: false, message: "请输入已到账经费", trigger: "blur" },
          {
            pattern: /^(([1-9]\d*)|\d)(\.\d{1,2})?$/,
            message: "请输入正确的金额，最多保留两位小数",
            trigger: "blur"
          }
        ],
        fundingUnit: [
          { required: false, message: "请输入经费拨款单位", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        startDate: [
          { required: true, message: "开始时间不能为空", trigger: "blur" }
        ],
        endDate: [
          { required: true, message: "结束时间不能为空", trigger: "blur" }
        ],
        researchField: [
          { required: false, message: "请输入研究领域", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询项目成果列表 */
    getList() {
      this.loading = true
      listResearch(this.queryParams).then(response => {
        this.researchList = response.rows
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
        researchId: null,
        userId: null,
        deptId: null,
        projectNumber: null,
        projectCategory: null,
        projectLevel: null,
        projectType: null,
        projectName: null,
        principal: null,
        participants: null,
        organizingUnit: null,
        totalFunding: null,
        receivedFunding: null,
        fundingUnit: null,
        startDate: null,
        endDate: null,
        actualEndDate: null,
        projectStatus: null,
        completionStatus: null,
        researchField: null,
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
      this.ids = selection.map(item => item.researchId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加项目成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const researchId = row.researchId || this.ids
      getResearch(researchId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改项目成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.researchId != null) {
            updateResearch(this.form).then(response => {
              if(response.researchId!=null)
              {
                 this.$refs.file.submitUpload(response.researchId,"research");
                 this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }
              this.open = false
              this.getList()
            })
          } else {
            addResearch(this.form).then(response => {
              if(response.researchId!=null)
              {
                 this.$refs.file.submitUpload(response.researchId,"research");
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
      const researchIds = row.researchId || this.ids
      this.$modal.confirm('是否确认删除项目成果编号为"' + researchIds + '"的数据项？').then(function() {
        return delResearch(researchIds)
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
          this.currentPaperId = row.researchId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.projectName|| '项目'}`
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
            this.ids = this.researchList.map(item=>item.researchId)
          }
         const requestData = {
          idList:this.ids,
           showColumns: this.selectClist || [],
           data: {
             ...this.queryParams
           }
          };
           const jsonRequestBody = JSON.stringify(requestData);
           this.exceldownload('research/research/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
       }
  }
}
</script>
