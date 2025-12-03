<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="ISBN号" prop="isbnNumber">
        <el-input
          v-model="queryParams.isbnNumber"
          placeholder="请输入ISBN号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="出版时间" prop="publishDate">
        <el-date-picker clearable
          v-model="queryParams.publishDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择出版时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="版次" prop="edition">
        <el-input
          v-model="queryParams.edition"
          placeholder="请输入版次"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['textbook:textbook:add']"
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
          v-hasPermi="['textbook:textbook:edit']"
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
          v-hasPermi="['textbook:textbook:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport() "
          v-hasPermi="['textbook:textbook:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="textbookList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="教材id" align="center" prop="textbookId" />
      <el-table-column label="教材名称" align="center" prop="textbookName" />
      <el-table-column label="作者角色" align="center" prop="authorRole" />
      <el-table-column label="出版社" align="center" prop="pressName" />
      <el-table-column label="ISBN号" align="center" prop="isbnNumber" />
      <el-table-column label="出版时间" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="教材类型" align="center" prop="textbookType" />
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="字数" align="center" prop="wordCount" />
      <el-table-column label="使用院校" align="center" prop="usingInstitutions" />
      <el-table-column label="适用专业" align="center" prop="applicableMajor" />
      <el-table-column label="教材层次" align="center" prop="textbookLevel" />
      <el-table-column label="批准文号" align="center" prop="approvalNumber" />
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
            v-hasPermi="['textbook:textbook:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['textbook:textbook:remove']"
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

    <!-- 添加或修改教材著作对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="教材名称" prop="textbookName">
          <el-input v-model="form.textbookName" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="作者角色" prop="authorRole">
          <el-select v-model="form.authorRole" placeholder="请选择角色"  style="width: 240px">
              <el-option
                v-for="item in authorRoles"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
        </el-form-item>
        <el-form-item label="出版社" prop="pressName">
          <el-input v-model="form.pressName" placeholder="请输入出版社" />
        </el-form-item>
        <el-form-item label="ISBN号" prop="isbnNumber">
          <el-input v-model="form.isbnNumber" placeholder="请输入ISBN号" />
        </el-form-item>
        <el-form-item label="出版时间" prop="publishDate">
          <el-date-picker clearable
            v-model="form.publishDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择出版时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="教材类型" prop="textbookType">
          <el-select v-model="form.textbookType" placeholder="请选择教材类型"  style="width: 240px">
              <el-option
                v-for="item in textbookTypes"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
        </el-form-item>
        <el-form-item label="版次" prop="edition">
          <el-input v-model="form.edition" placeholder="请输入版次" />
        </el-form-item>
        <el-form-item label="字数" prop="wordCount">
          <el-input v-model="form.wordCount" placeholder="请输入字数" />
        </el-form-item>
        <el-form-item label="使用院校" prop="usingInstitutions">
          <el-input v-model="form.usingInstitutions" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="适用专业" prop="applicableMajor">
          <el-input v-model="form.applicableMajor" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="教材层次" prop="textbookLevel">
          <el-select v-model="form.textbookLevel" placeholder="请选择教材类型"  style="width: 240px">
              <el-option
                v-for="item in textbookLevels"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
        </el-form-item>
        <el-form-item label="批准文号" prop="approvalNumber">
          <el-input v-model="form.approvalNumber" placeholder="请输入批准文号" />
        </el-form-item>
        <el-form-item label="创建时间" prop="createdAt">
          <el-date-picker clearable
            v-model="form.createdAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择创建时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="更新时间" prop="updatedAt">
          <el-date-picker clearable
            v-model="form.updatedAt"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择更新时间">
          </el-date-picker>
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
    <AttachmentManagement
        :visible="attachmentVisible"
        :title="attachmentTitle"
        :resource-id="currentPaperId"
        attachment-type="textbook"
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
            <el-checkbox v-for="(item,index) in checkList " :label="item.value" :key="item.value " >{{item.lable}}</el-checkbox>
          </el-checkbox-group>
          <el-button @click="DowExcel()" >导出</el-button>
      </el-dialog>
  </div>
</template>

<script>
import { listTextbook, getTextbook, delTextbook, addTextbook, updateTextbook } from "@/api/textbook/textbook"

export default {
  name: "Textbook",
  data() {
    return {
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      //导出选择字段
      selectClist:[],
      //导出选择字段列表
      checkList:[
      {
        value: 'textbookId',
        lable: '教材id'
      },{
        value: 'userId',
        lable: '用户ID'
      },{
        value: 'deptId',
        lable: '部门ID'
      },{
        value: 'textbookName',
        lable: '教材名称'
      },{
        value: 'authorRole',
        lable: '作者角色'
      },{
        value: 'pressName',
        lable: '出版社'
      },{
        value: 'isbnNumber',
        lable: 'ISBN号'
      },{
        value: 'publishDate',
        lable: '出版时间'
      },{
        value: 'textbookType',
        lable: '教材类型'
      },{
        value: 'edition',
        lable: '版次'
      },{
        value: 'wordCount',
        lable: '字数（万字）'
      },{
        value: 'usingInstitutions',
        lable: '使用院校'
      },{
        value: 'applicableMajor',
        lable: '适用专业'
      },{
        value: 'textbookLevel',
        lable: '教材层次'
      },{
        value: 'approvalNumber',
        lable: '批准文号'
      },{
        value: 'auditStatus',
        lable: '审核状态'
      },{
        value: 'createdAt',
        lable: '创建时间'
      },{
        value: 'updatedAt',
        lable: '更新时间'
      }
      ],
      //上传文件组件
      files:[],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      //教材层次
      textbookLevels:[{
        value:'本科',
        lable:'本科'
      },{
        value:'专科',
        lable:'专科'
      },{
        value:'研究生',
        lable:'研究生'
      },{
        value:'职业教育',
        lable:'职业教育'
      }],
      //教材类型
      textbookTypes:[{
        value:'规划教材',
        lable:'规划教材'
      },{
        value:'校本教材',
        lable:'校本教材'
      },{
        value:'国家级规划',
        lable:'国家级规划'
      },{
        value:'省部级规划',
        lable:'省部级规划'
      },{
        value:'行业规划',
        lable:'行业规划'
      }],
      //作者角色
      authorRoles:[{
        value:'主编',
        lable:'主编'
      },{
        value:'副主编',
        lable:'副主编'
      },{
        value:'参编',
        lable:'参编'
      },{
        value:'独著',
        lable:'独著'
      }],
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
      // 教材著作表格数据
      textbookList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        textbookName: null,
        isbnNumber: null,
        publishDate: null,
        textbookType: null,
        edition: null,
        usingInstitutions: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        textbookName: [
          { required: true, message: "教材名称不能为空", trigger: "blur" }
        ],
        authorRole: [
          { required: true, message: "作者角色不能为空", trigger: "change" }
        ],
        pressName: [
          { required: true, message: "出版社不能为空", trigger: "blur" }
        ],
        isbnNumber: [
          { required: true, message: "ISBN号不能为空", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "出版时间不能为空", trigger: "blur" }
        ],
        textbookType: [
          { required: true, message: "教材类型不能为空", trigger: "change" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询教材著作列表 */
    getList() {
      this.loading = true
      listTextbook(this.queryParams).then(response => {
        this.textbookList = response.rows
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
        textbookId: null,
        userId: null,
        deptId: null,
        textbookName: null,
        authorRole: null,
        pressName: null,
        isbnNumber: null,
        publishDate: null,
        textbookType: null,
        edition: null,
        wordCount: null,
        usingInstitutions: null,
        applicableMajor: null,
        textbookLevel: null,
        approvalNumber: null,
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
      this.ids = selection.map(item => item.textbookId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加教材著作"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const textbookId = row.textbookId || this.ids
      getTextbook(textbookId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改教材著作"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.textbookId != null) {
            updateTextbook(this.form).then(response => {
              if(response.textbookId!=null)
              {

                 this.$refs.file.submitUpload(response.textbookId,"textbook");
                  this.$modal.msgSuccess("修改成功")
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            addTextbook(this.form).then(response => {
              if(response.textbookId!=null)
              {
                 this.$refs.file.submitUpload(response.textbookId,"textbook");
                  this.$modal.msgSuccess("新增成功")
              }else{
                  this.$modal.msgSuccess("上传文件失败")
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
      const textbookIds = row.textbookId || this.ids
      this.$modal.confirm('是否确认删除教材著作编号为"' + textbookIds + '"的数据项？').then(function() {
        return delTextbook(textbookIds)
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
          this.currentPaperId = 1001
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.textbookName || '教材'}`
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
         this.exceldownload('textbook/textbook/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`);
      },
  }
}
</script>
