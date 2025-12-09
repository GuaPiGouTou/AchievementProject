<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="获奖人" prop="awardWinner">
        <el-input
          v-model="queryParams.awardWinner"
          placeholder="请输入获奖人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="获奖时间" prop="awardDate">
        <el-date-picker clearable
          v-model="queryParams.awardDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择获奖时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="奖项类别" prop="awardCategory">
        <el-input
          v-model="queryParams.awardCategory"
          placeholder="请输入奖项类别"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="获奖等次" prop="awardRanking">
        <el-input
          v-model="queryParams.awardRanking"
          placeholder="请输入获奖等次"
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
          v-hasPermi="['award:award:add']"
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
          v-hasPermi="['award:award:edit']"
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
          v-hasPermi="['award:award:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['award:award:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="awardList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="奖项" align="center" prop="awardId" />
      <el-table-column label="奖项名称id" align="center" prop="awardName" />
      <el-table-column label="获奖人" align="center" prop="awardWinner" />
      <el-table-column label="颁奖单位" align="center" prop="awardUnit" />
      <el-table-column label="获奖时间" align="center" prop="awardDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.awardDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="奖项级别" align="center" prop="awardLevel" />
      <el-table-column label="奖项类别" align="center" prop="awardCategory" />
      <el-table-column label="获奖等次" align="center" prop="awardRanking" />
      <el-table-column label="颁奖典礼日期" align="center" prop="awardCeremonyDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.awardCeremonyDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="颁奖地点" align="center" prop="awardCeremonyPlace" />
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
            v-hasPermi="['award:award:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['award:award:remove']"
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
    <!-- 附件管理 -->
      <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="award"
        @update:visible="attachmentVisible = $event"
        @close="handleAttachmentClose"
        @load-success="handleAttachmentLoadSuccess"
        @download-success="handleDownloadSuccess"
        @delete-success="handleDeleteSuccess"
      />
    <!-- 添加或修改获奖成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="奖项名称" prop="awardName">
          <el-input v-model="form.awardName" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="获奖人" prop="awardWinner">
          <el-input v-model="form.awardWinner" placeholder="请输入获奖人" />
        </el-form-item>
        <el-form-item label="颁奖单位" prop="awardUnit">
          <el-input v-model="form.awardUnit" placeholder="请输入颁奖单位" />
        </el-form-item>
        <el-form-item label="获奖时间" prop="awardDate">
          <el-date-picker clearable
            v-model="form.awardDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择获奖时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="奖项级别" prop="awardLevel">
           <el-select v-model="form.awardLevel" placeholder="请选择">
               <el-option
                 v-for="item in awardLevels"
                 :key="item.value"
                 :label="item.label"
                 :value="item.value">
               </el-option>
             </el-select>
        </el-form-item>
        <el-form-item label="奖项类别" prop="awardCategory">
          <el-input v-model="form.awardCategory" placeholder="请输入奖项类别" />
        </el-form-item>
        <el-form-item label="获奖等次" prop="awardRanking">
          <el-input v-model="form.awardRanking" placeholder="请输入获奖等次" />
        </el-form-item>
        <el-form-item label="颁奖典礼日期" prop="awardCeremonyDate">
          <el-date-picker clearable
            v-model="form.awardCeremonyDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择颁奖典礼日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="颁奖地点" prop="awardCeremonyPlace">
          <el-input v-model="form.awardCeremonyPlace" placeholder="请输入颁奖地点" />
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
          <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.lable}}</el-checkbox>
        </el-checkbox-group>
        <el-button @click="DowExcel()" >导出</el-button>
    </el-dialog>
  </div>
</template>

<script>
import { listAward, getAward, delAward, addAward, updateAward } from "@/api/award/award"

export default {
  name: "Award",
  data() {
    return {
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      //导出选择字段
      checkList:[
      {
        "value": "awardId",
        "lable": "奖项ID"
      },
      {
        "value": "userId",
        "lable": "用户ID"
      },
      {
        "value": "deptId",
        "lable": "部门ID"
      },
      {
        "value": "awardName",
        "lable": "奖项名称"
      },
      {
        "value": "awardWinner",
        "lable": "获奖人"
      },
      {
        "value": "awardUnit",
        "lable": "颁奖单位"
      },
      {
        "value": "awardDate",
        "lable": "获奖时间"
      },
      {
        "value": "awardLevel",
        "lable": "奖项级别"
      },
      {
        "value": "awardCategory",
        "lable": "奖项类别"
      },
      {
        "value": "awardRanking",
        "lable": "获奖等次"
      },
      {
        "value": "awardCeremonyDate",
        "lable": "颁奖典礼日期"
      },
      {
        "value": "awardCeremonyPlace",
        "lable": "颁奖地点"
      },
      {
        "value": "auditStatus",
        "lable": "审核状态"
      },
      {
        "value": "createdAt",
        "lable": "创建时间"
      },
      {
        "value": "updatedAt",
        "lable": "更新时间"
      }],
      selectClist:[],
      //上传文件组件
      files:[],
      //奖项级别
      awardLevels:[
        {
          value:'国家级',
          lable:'国家级'
        },{
          value:'省级',
          lable:'省级'
        },{
          value:'市级',
          lable:'市级'
        },{
          value:'校级',
          lable:'校级'
        },{
          value:'行业级',
          lable:'行业级'
        },{
          value:'国际级',
          lable:'国际级'
        },{
          value:'其他',
          lable:'其他'
        }
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
      // 获奖成果表格数据
      awardList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        awardName: null,
        awardWinner: null,
        awardDate: null,
        awardLevel: null,
        awardCategory: null,
        awardRanking: null,
        auditStatus: null,
        createdAt: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        awardName: [
          { required: true, message: "奖项名称不能为空", trigger: "blur" },
          { min: 1, max: 200, message: "长度不能超过 200 个字符", trigger: "blur" },
          // 允许中文、英文、数字、括号（中英文）、书名号、横杠、冒号、空格
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）《》\-\：:\s]+$/, message: "奖项名称包含非法字符", trigger: "blur" }
        ],
        awardWinner: [
          { required: true, message: "获奖人不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          // 允许中文、英文、点（用于缩写）、空格、逗号/分号（用于分隔多人）
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s,;，；\.]+$/, message: "请只输入姓名，多人可用逗号或分号分隔", trigger: "blur" }
        ],
        awardUnit: [
          { required: true, message: "颁奖单位不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          // 允许中文、英文、数字、括号、点
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\(\)（）\.\s]+$/, message: "颁奖单位名称格式不正确", trigger: "blur" }
        ],
        awardDate: [
          { required: true, message: "获奖时间不能为空", trigger: "blur" }
        ],
        awardLevel: [
          { required: true, message: "奖项级别不能为空", trigger: "change" }
        ],
        awardCategory: [
          { required: true, message: "奖项类别不能为空", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          // 允许中英文、数字
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s]+$/, message: "奖项类别只能包含中英文及数字", trigger: "blur" }
        ],
        awardRanking: [
          { required: false, message: "请输入获奖等次", trigger: "blur" },
          { max: 50, message: "长度不能超过 50 个字符", trigger: "blur" },
          // 允许：特等奖, 一等奖, 1st, Gold, Top 10
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\-\s]+$/, message: "获奖等次格式不正确", trigger: "blur" }
        ],
        awardCeremonyPlace: [
          { required: false, message: "请输入颁奖地点", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" },
          // 允许地址格式
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\-\s,，]+$/, message: "颁奖地点包含非法字符", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询获奖成果列表 */
    getList() {
      this.loading = true
      listAward(this.queryParams).then(response => {
        this.awardList = response.rows
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
        awardId: null,
        userId: null,
        deptId: null,
        awardName: null,
        awardWinner: null,
        awardUnit: null,
        awardDate: null,
        awardLevel: null,
        awardCategory: null,
        awardRanking: null,
        awardCeremonyDate: null,
        awardCeremonyPlace: null,
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
      this.ids = selection.map(item => item.awardId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加获奖成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const awardId = row.awardId || this.ids
      getAward(awardId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改获奖成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
           const msg = ""
          if (this.form.awardId != null) {
            updateAward(this.form).then(response => {
              if(response.awardId!=null)
              {
                 this.$refs.file.submitUpload(response.awardId,"award");
              }
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addAward(this.form).then(response => {

              if(response.awardId!=null)
              {
                 this.$refs.file.submitUpload(response.awardId,"award");
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
      const awardIds = row.awardId || this.ids
      this.$modal.confirm('是否确认删除获奖成果编号为"' + awardIds + '"的数据项？').then(function() {
        return delAward(awardIds)
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
        this.currentPaperId = row.awardId
        this.currentPaper = row
        this.attachmentTitle = `附件管理 - ${row.awardName || '竞赛'}`
        this.attachmentVisible = true
      },

    /** 附件弹窗关闭 */
    handleAttachmentClose() {
      this.currentPaperId = null
      this.currentPaper = null
    },

    /** 附件加载成功 */
    handleAttachmentLoadSuccess(fileList) {
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
    /*导出方法*/
    DowExcel(){
      console.log('查询条件:', this.queryParams);
       console.log('隐藏列:', this.selectClist);
       const requestData = {
         showColumns: this.selectClist || [],
         data: {
           ...this.queryParams
         }
       };
       const jsonRequestBody = JSON.stringify(requestData);
       this.exceldownload('award/award/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`);
    },
    //
    }
}
</script>
