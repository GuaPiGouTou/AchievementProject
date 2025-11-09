<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="用户ID"
          clearable
          disabled
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="研究方向" prop="researchDirection">
        <el-input
          v-model="queryParams.researchDirection"
          placeholder="请输入研究方向"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="期刊名称" prop="journal">
        <el-input
          v-model="queryParams.journal"
          placeholder="请输入期刊名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发表时间" prop="publishDate">
        <el-date-picker clearable
          v-model="queryParams.publishDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择发表时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="卷号" prop="volume">
        <el-input
          v-model="queryParams.volume"
          placeholder="请输入卷号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="期号" prop="issue">
        <el-input
          v-model="queryParams.issue"
          placeholder="请输入期号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="页码范围" prop="pageRange">
        <el-input
          v-model="queryParams.pageRange"
          placeholder="请输入页码范围"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="DOI号" prop="doi">
        <el-input
          v-model="queryParams.doi"
          placeholder="请输入DOI号"
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
          v-hasPermi="['paper:paper:add']"
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
          v-hasPermi="['paper:paper:edit']"
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
          v-hasPermi="['paper:paper:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['paper:paper:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="paperList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="论文id" align="center" prop="paperId" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="论文标题" align="center" prop="paperTitle" />
      <el-table-column label="论文类别" align="center" prop="paperCategory" />
      <el-table-column label="研究方向" align="center" prop="researchDirection" />
      <el-table-column label="作者信息" align="center" prop="authorInformation" />
      <el-table-column label="期刊名称" align="center" prop="journal" />
      <el-table-column label="发表时间" align="center" prop="publishDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.publishDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="卷号" align="center" prop="volume" />
      <el-table-column label="期号" align="center" prop="issue" />
      <el-table-column label="页码范围" align="center" prop="pageRange" />
      <el-table-column label="DOI号" align="center" prop="doi" />
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
      <el-table-column label="附件列表" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
        <el-button
          size="mini"
          type="text"
          icon="el-icon-edit"
          @click="att(scope.row)"
          v-hasPermi="['paper:paper:edit']"
        >附件</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['paper:paper:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['paper:paper:remove']"
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
    <!-- 附件管理弹窗 -->
    <el-dialog
      :title="atttitle"
      :visible.sync="attopen"
      width="600px"
      append-to-body
      :close-on-click-modal="false">

      <!-- 文件列表展示 -->
      <div class="file-list-container">
        <el-table
          :data="fileList"
          empty-text="暂无文件"
          v-loading="loading">
          <el-table-column
            prop="fileName"
            label="文件名"
            min-width="200"
            show-overflow-tooltip>
            <template slot-scope="{ row }">
              <div class="file-name-cell">
               <!-- <i :class="getFileIcon(row.fileExtension)" class="file-icon"></i> -->
                <span class="file-name-text">
                  {{ row.fileName || '未命名文件' }}
                </span>
                <span class="file-extension">.{{ row.fileExtension }}</span>
              </div>
            </template>
          </el-table-column>

          <el-table-column
            prop="fileSize"
            label="大小"
            width="100"
            align="right">
            <template slot-scope="{ row }">
              {{ formatFileSize(row.fileSize) }}
            </template>
          </el-table-column>

          <el-table-column
            label="操作"
            width="240"
            align="center"
            fixed="right">
            <template slot-scope="{ row, $index }">

              <el-button @click="DownloadFile(row, $index)">下载</el-button>
              <el-button type="danger" @click="DeletedelAttachment(row, $index)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>


      </div>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="attopen = false">关闭</el-button>
        </span>
      </template>
    </el-dialog>
    <!-- 添加或修改论文成果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户ID" prop="userId">
          <el-input disabled v-model="form.userId"  placeholder="请输入用户ID" />
        </el-form-item>
        <el-form-item label="论文标题" prop="paperTitle">
          <el-input v-model="form.paperTitle" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="论文类别" prop="paperCategory">
         <el-select v-model="form.paperCategory" placeholder="请选择论文类别"  style="width: 240px">
             <el-option
               v-for="item in paperCategory"
               :key="item.value"
               :label="item.label"
               :value="item.value"
             />
           </el-select>
        </el-form-item>
        <el-form-item label="研究方向" prop="researchDirection">
          <el-input v-model="form.researchDirection" placeholder="请输入研究方向" />
        </el-form-item>
        <el-form-item label="作者信息" prop="authorInformation">
          <el-input v-model="form.authorInformation" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="期刊名称" prop="journal">
          <el-input v-model="form.journal" placeholder="请输入期刊名称" />
        </el-form-item>
        <el-form-item label="发表时间" prop="publishDate">
          <el-date-picker clearable
            v-model="form.publishDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择发表时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="卷号" prop="volume">
          <el-input v-model="form.volume" placeholder="请输入卷号" />
        </el-form-item>
        <el-form-item label="期号" prop="issue">
          <el-input v-model="form.issue" placeholder="请输入期号" />
        </el-form-item>
        <el-form-item label="页码范围" prop="pageRange">
          <el-input v-model="form.pageRange" placeholder="请输入页码范围" />
        </el-form-item>
        <el-form-item label="DOI号" prop="doi">
          <el-input v-model="form.doi" placeholder="请输入DOI号" />
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
  </div>
</template>

<script>
import { listPaper, getPaper, delPaper, addPaper, updatePaper } from "@/api/paper/paper"
import { listAttachmentidAndType,DowAttachmentcheck,delAttachment } from "@/api/attachment/attachment"
import Cookies from "js-cookie"

export default {
  name: "Paper",
  data() {
    return {
      files:"",
      paperCategory:[
  {
    value: 'A1',
    label: 'A1',
  },
  {
    value: 'A2',
    label: 'A2',
  },
  {
    value: 'B1',
    label: 'B1',
  },
  {
    value: 'B2',
    label: 'B2',
  },
  {
    value: 'C',
    label: 'C',
  },
  {
    value: 'D',
    label: 'D',
  }
],
    disabled: false, // 添加disabled属性
    attopen: false, // 弹窗显示状态
    atttitle: '附件管理', // 弹窗标题
    fileList: [], // 附件列表
    currentUserId: null, // 当前用户ID
    currentType: 'paper', // 当前附件类型
      idAndTypefrom:{
        userId:null,
        attachmentType:""
      },
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
      // 论文成果表格数据
      paperList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        paperTitle: null,
        paperCategory:null,
        researchDirection: null,
        authorInformation: null,
        journal: null,
        publishDate: null,
        volume: null,
        issue: null,
        pageRange: null,
        doi: null,
        auditStatus: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "用户ID不能为空", trigger: "blur" }
        ],
        paperTitle: [
          { required: true, message: "论文标题不能为空", trigger: "blur" }
        ],
        paperCategory: [
          { required: true, message: "论文类别不能为空", trigger: "change" }
        ],
        authorInformation: [
          { required: true, message: "作者信息不能为空", trigger: "blur" }
        ],
        journal: [
          { required: true, message: "期刊名称不能为空", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "发表时间不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getusername(){
      const username = Cookies.get('username')
      this.form.userId = username
    },
    /** 查询论文成果列表 */
    getList() {
      this.loading = true
      listPaper(this.queryParams).then(response => {
        this.paperList = response.rows
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
        paperId: null,
        userId: null,
        paperTitle: null,
        paperCategory: null,
        researchDirection: null,
        authorInformation: null,
        journal: null,
        publishDate: null,
        volume: null,
        issue: null,
        pageRange: null,
        doi: null,
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
      this.ids = selection.map(item => item.paperId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.getusername()
      this.open = true
      this.title = "添加论文成果"
    },
    /** 附件操作 */
  /** 打开附件弹窗 */
    handleAttachment(row) {
      this.currentPaperId = row.paperId
      this.atttitle = `附件管理 - ${row.paperTitle || '论文'}`
      this.attopen = true
    },

    /** 弹窗打开时触发 */
    handleAttachmentOpen() {
      // 确保DOM渲染完成后再获取数据[5](@ref)
      // this.$nextTick(() => {
      //   this.getFileList()
      // })
    },

    /** 弹窗关闭时触发 */
    handleAttachmentClose() {
      this.fileList = []
      this.currentPaperId = null
       this.attopen = false
    },
    formatFileSize(bytes) {
          if (!bytes || bytes === 0) return '0 B';
          const k = 1024;
          const sizes = ['B', 'KB', 'MB', 'GB'];
          const i = Math.floor(Math.log(bytes) / Math.log(k));
          return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        },
    att(row) {
      console.log(row)
      this.attopen = true
      this.atttitle = "附件"
      this.idAndTypefrom.userId = row.paperId
      this.idAndTypefrom.attachmentType ="paper"
      listAttachmentidAndType(this.idAndTypefrom).then(response => {
      console.log(response)
       this.fileList =response.data
              console.log(this.fileList)
      })

    },
    DeletedelAttachment(row,index){
      delAttachment(row.attachmentId).then(res=>{
        console.log(res)
        if(res.code=200)
        {
          this.$modal.msgSuccess(res.msg)
         const p =  this.refreshAttachmentList()
          console.log(p)
            this.$download.delete(row.filePath)
        }else{
            this.$modal.msgSuccess("删除文件失败："+res.msg)
        }
      })
    },
    DownloadFile(row,index){
      const url = row.filePath
     DowAttachmentcheck({resource:url}).then(res=>{
       if(res.code = 200)
       {
            this.$download.resource(url);
              this.$modal.msgSuccess("下载文件成功")
       }else{
           this.$modal.msgSuccess("下载文件失败")
       }
     })

     // this.$download.name();

    },
    /** 刷新附件列表 */
    refreshAttachmentList() {
      if (!this.idAndTypefrom.userId || !this.idAndTypefrom.attachmentType) {
        console.warn("刷新附件列表失败：缺少查询参数")
        return
      }

      this.loading = true
      listAttachmentidAndType(this.idAndTypefrom).then(response => {
        this.fileList = response.data || []
        console.log("附件列表刷新成功，当前文件数:", this.fileList.length)
      }).catch(error => {
        console.error("刷新附件列表失败:", error)
        this.$modal.msgError("刷新失败")
      }).finally(() => {
        this.loading = false
      })
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()

      const paperId = row.paperId || this.ids
      getPaper(paperId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改论文成果"
        console.log(this.form)
      })
      this.getusername()
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.paperId != null) {
            updatePaper(this.form).then(response => {
              if(response.paperId!=null)
              {
                console.log(response.paperId)
                console.log("response.paperId")
                 this.$refs.file.submitUpload(response.paperId,"paper");
              }else{
                  this.$modal.msgSuccess("上传文件失败")
              }
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPaper(this.form).then(response => {
              console.log("新增成功+response")
              if(response.paperId!=null)
              {
                console.log(response.paperId)
                 this.$refs.file.submitUpload(response.paperId,"paper");
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
      const paperIds = row.paperId || this.ids
      this.$modal.confirm('是否确认删除论文成果编号为"' + paperIds + '"的数据项？').then(function() {
        return delPaper(paperIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('paper/paper/export', {
        ...this.queryParams
      }, `paper_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
