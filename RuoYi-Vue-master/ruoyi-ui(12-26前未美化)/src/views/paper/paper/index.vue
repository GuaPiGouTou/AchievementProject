<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="研究方向" prop="researchDirection">
        <el-input
          v-model="queryParams.researchDirection"
          placeholder="请输入研究方向"
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
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}-{h}:{m}:{ss}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}-{h}:{m}:{ss}') }}</span>
        </template>
      </el-table-column>
       <el-table-column label="附件列表" align="center" prop="updatedAt" width="180">
              <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleAttachment(scope.row)"
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

   <!-- 添加或修改论文成果对话框 -->
       <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
         <el-form ref="form" :model="form" :rules="rules" label-width="80px">
           <el-form-item label="论文标题" prop="paperTitle">
             <el-input v-model="form.paperTitle" type="textarea" placeholder="请输入论文完整标题" />
           </el-form-item>
           <el-form-item label="论文类别" prop="paperCategory">
              <el-select v-model="form.paperCategory" placeholder="请选择论文类别"  style="width: 240px">
                  <el-option
                    v-for="item in paperCategorys"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  />
                </el-select>
             </el-form-item>

           <el-form-item label="研究方向" prop="researchDirection">
             <el-input v-model="form.researchDirection" placeholder="请输入研究方向（如：人工智能, 深度学习）" />
           </el-form-item>
           <el-form-item label="作者信息" prop="authorInformation">
             <el-input v-model="form.authorInformation" placeholder="请输入作者姓名，多人请用逗号分隔 (如: 张三, 李四)" />
           </el-form-item>
           <el-form-item label="期刊名称" prop="journal">
             <el-input v-model="form.journal" placeholder="请输入期刊/会议全称" />
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
             <el-input v-model="form.volume" placeholder="请输入卷号 (如: Vol. 1)" />
           </el-form-item>
           <el-form-item label="期号" prop="issue">
             <el-input v-model="form.issue" placeholder="请输入期号 (如: No. 2)" />
           </el-form-item>
           <el-form-item label="页码范围" prop="pageRange">
             <el-input v-model="form.pageRange" placeholder="请输入页码范围 (如: 100-105)" />
           </el-form-item>
           <el-form-item label="DOI号" prop="doi">
             <el-input v-model="form.doi" placeholder="请输入DOI号 (如: 10.1000/xyz123)" />
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
        attachment-type="paper"
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
               <el-badge :value="idsCount==0?paperList.length:idsCount" class="item"  >
                <el-button @click="DowExcel()" >导出</el-button>
               </el-badge>
      </el-dialog>
  </div>
</template>

<script>

import { listPaper, getPaper, delPaper, addPaper, updatePaper } from "@/api/paper/paper"

export default {
  name: "Paper",
  data() {
    return {
      //导出记录
      idsCount:0,
      //导出弹窗
      Exceltitle:"选择导出的字段",
      Excelopen:false,
      // 论文成果选择字段数组
          checkList: [
            {
              value: 'paperId',
              lable: '论文id'
            }, {
              value: 'deptId',
              lable: '部门id'
            }, {
              value: 'userId',
              lable: '用户ID'
            }, {
              value: 'paperTitle',
              lable: '论文标题'
            }, {
              value: 'paperCategory',
              lable: '论文类别'
            }, {
              value: 'researchDirection',
              lable: '研究方向'
            }, {
              value: 'authorInformation',
              lable: '作者信息'
            }, {
              value: 'journal',
              lable: '期刊名称'
            }, {
              value: 'publishDate',
              lable: '发表时间'
            }, {
              value: 'volume',
              lable: '卷号'
            }, {
              value: 'issue',
              lable: '期号'
            }, {
              value: 'pageRange',
              lable: '页码范围'
            }, {
              value: 'doi',
              lable: 'DOI号'
            }, {
              value: 'auditStatus',
              lable: '审核状态'
            }, {
              value: 'createdAt',
              lable: '创建时间'
            }, {
              value: 'updatedAt',
              lable: '更新时间'
            }
          ],
      //导出选择字段
      selectClist:[],
      //上传文件组件
      files:[],
      //附件弹窗参数
      currentPaperId:null,
      currentPaper:"",
      attachmentTitle:"",
      attachmentVisible:false,
      paperCategorys:[
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
      //上传文件组件
      files:[],
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
        paperTitle: null,
        paperCategory: null,
        researchDirection: null,
        publishDate: null,
        auditStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        paperTitle: [
          { required: true, message: "论文标题不能为空", trigger: "blur" },
          { min: 1, max: 300, message: "标题长度不能超过 300 个字符", trigger: "blur" }
        ],
        paperCategory: [
          { required: true, message: "论文类别不能为空", trigger: "change" }
        ],
        researchDirection: [
          { required: false, message: "请输入研究方向", trigger: "blur" },
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9\s,;，；]+$/, message: "仅允许中文、英文、数字及分隔符", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        authorInformation: [
          { required: true, message: "作者信息不能为空", trigger: "blur" },
          // 允许中文、英文、点（用于缩写）、逗号、空格
          { pattern: /^[\u4e00-\u9fa5a-zA-Z\s·\.]+(,\s*[\u4e00-\u9fa5a-zA-Z\s·\.]+)*$/, message: "格式错误，多人请用逗号分隔，如：张三, 李四", trigger: "blur" },
          { max: 200, message: "长度不能超过 200 个字符", trigger: "blur" }
        ],
        journal: [
          { required: true, message: "期刊名称不能为空", trigger: "blur" },
          { max: 100, message: "长度不能超过 100 个字符", trigger: "blur" }
        ],
        publishDate: [
          { required: true, message: "发表时间不能为空", trigger: "blur" }
        ],
        volume: [
          { pattern: /^[a-zA-Z0-9\-\.\s]+$/, message: "卷号格式错误 (可包含数字、字母、点、横杠及空格)", trigger: "blur" },
          { max: 20, message: "长度不能超过 20 个字符", trigger: "blur" }
        ],
        issue: [
          { pattern: /^[a-zA-Z0-9\-\(\)\.\s]+$/, message: "期号格式错误 (可包含数字、字母、括号、横杠及空格)", trigger: "blur" },
          { max: 20, message: "长度不能超过 20 个字符", trigger: "blur" }
        ],
        pageRange: [
          { pattern: /^[Pp]?[0-9]+(\-[Pp]?[0-9]+)?$/, message: "页码格式应为 '100-120' 或 '25'", trigger: "blur" },
          { max: 20, message: "长度过长", trigger: "blur" }
        ],
        doi: [
          { pattern: /^10\.\d{4,9}\/[-._;()/:a-zA-Z0-9]+$/, message: "请输入标准的DOI格式，例如 10.1000/xyz123", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
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
        updatedAt: null,
        deptId: null
      }
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
      this.open = true
      this.title = "添加论文成果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const paperId = row.paperId || this.ids
      getPaper(paperId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改论文成果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.paperId != null) {
            updatePaper(this.form).then(response => {
              console.log(response)
              if(response.paperId!=null)
              {
                this.$modal.msgSuccess("修改成功")
                 this.$refs.file.submitUpload(response.paperId,"paper");

              }else{
                  this.$modal.msgSuccess("修改成功,上传文件失败")
              }

              this.open = false
              this.getList()
            })
          } else {
            addPaper(this.form).then(response => {
              if(response.paperId!=null)
              {

                 this.$refs.file.submitUpload(response.paperId,"paper");
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
       this.Excelopen = true
    },
     /*导出*/
  async  DowExcel(){
      if(this.ids.length==0)
      {
        this.ids = this.paperList.map(item=>item.paperId)
      }
       const requestData = {
        idList:this.ids,
        showColumns: this.selectClist || [],
        data: {
          ...this.queryParams
        }
       };
      const jsonRequestBody = JSON.stringify(requestData);
      this.exceldownload('paper/paper/export', jsonRequestBody, `competition_${new Date().getTime()}.xlsx`)
    },
    /*
    附件弹窗方法
    */
      handleAttachment(row) {
          this.currentPaperId = row.paperId
          this.currentPaper = row
          this.attachmentTitle = `附件管理 - ${row.paperTitle || '论文'}`
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
  }
}
</script>
