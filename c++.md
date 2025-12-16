## 论文成果管理接口文档

### 查询论文列表

```
GET /api/selectPaperList
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`: `Long`类型，分页页码
- `pageSize`: `Long`类型，分页大小

##### 查询数据字段

数据库ry-vue中achievements_paper的全部字段

##### 请求参数示例

复制

```
GET /api/selectPaperList?userId=1&deptId=100&pageNum=1&pageSize=10
```

##### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

sql

复制

```
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

sql

```
SELECT * FROM achievements_paper;  (data_scope = "1")

SELECT * FROM achievements_paper WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_paper WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_paper WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_paper WHERE user_id = userId;(data_scope = "5")
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，论文列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "paperId": 1001,
      "userId": 1,
      "deptId": 101,
      "paperTitle": "人工智能在教育领域的应用研究",
      "paperCategory": "期刊论文",
      "researchDirection": "人工智能",
      "authorInformation": "第一作者",
      "journal": "计算机科学",
      "publishDate": "2024-10-15",
      "volume": "50",
      "issue": "10",
      "pageRange": "100-110",
      "doi": "10.1234/abc.2024.10.001",
      "auditStatus": "待审核",
      "createdAt": "2025-11-07",
      "updatedAt": "2025-11-10"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询论文记录详细信息

```
GET /api/selectPaperById
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `paperId`: `Long`类型，论文ID（用于查询论文表的具体记录）

##### 查询数据字段

数据库ry-vue中achievements_paper的指定ID记录

##### 请求参数示例

复制

```
GET /api/selectPaperById?userId=1&deptId=100&paperId=1
```

需要进行权限检查原理同**查询论文列表**

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，论文详细信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "data": {
    "paperId": 1001,
    "userId": 1,
    "deptId": 101,
    "paperTitle": "人工智能在教育领域的应用研究",
    "paperCategory": "期刊论文",
    "researchDirection": "人工智能",
    "authorInformation": "第一作者",
    "journal": "计算机科学",
    "publishDate": "2024-10-15",
    "volume": "50",
    "issue": "10",
    "pageRange": "100-110",
    "doi": "10.1234/abc.2024.10.001",
    "auditStatus": "待审核",
    "createdAt": "2025-11-07",
    "updatedAt": "2025-11-10"
  },
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增论文成果

```
POST /api/insertPaper
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `paperTitle`: `String`类型，论文标题
- `paperCategory`: `String`类型，论文类别
- `researchDirection`: `String`类型，研究方向
- `authorInformation`: `String`类型，作者信息（1:第一作者,2:第二作者等）
- `journal`: `String`类型，期刊名称
- `publishDate`: `Date`类型，发表时间
- `volume`: `String`类型，卷号
- `issue`: `String`类型，期号
- `pageRange`: `String`类型，页码范围
- `doi`: `String`类型，DOI号
- `auditStatus`: `String`类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "paperTitle": "人工智能在教育领域的应用研究",
  "paperCategory": "期刊论文",
  "researchDirection": "人工智能",
  "authorInformation": "第一作者",
  "journal": "计算机科学",
  "publishDate": "2024-10-15",
  "volume": "50",
  "issue": "10",
  "pageRange": "100-110",
  "doi": "10.1234/abc.2024.10.001",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的论文记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "paperId": 1007,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "paperId": null,
  "msg":"论文信息插入失败"    
}
```

### 更新论文记录

```
POST /api/updatePaper
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `paperId`: `Long`类型，论文ID
- `paperTitle`: `String`类型，论文标题
- `paperCategory`: `String`类型，论文类别
- `researchDirection`: `String`类型，研究方向
- `authorInformation`: `String`类型，作者信息（1:第一作者,2:第二作者等）
- `journal`: `String`类型，期刊名称
- `publishDate`: `Date`类型，发表时间
- `volume`: `String`类型，卷号
- `issue`: `String`类型，期号
- `pageRange`: `String`类型，页码范围
- `doi`: `String`类型，DOI号
- `auditStatus`: `String`类型，审核状态

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "paperId": 1001,
  "paperTitle": "人工智能在教育领域的应用研究（修订版）",
  "paperCategory": "期刊论文",
  "researchDirection": "人工智能",
  "authorInformation": "第一作者",
  "journal": "计算机科学",
  "publishDate": "2024-10-15",
  "volume": "50",
  "issue": "10",
  "pageRange": "100-110",
  "doi": "10.1234/abc.2024.10.001",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的论文记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "paperId": 1001,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "paperId": null,
  "msg":"论文信息更新失败"    
}
```

### 删除论文记录

```
POST /api/deletePapers
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的论文记录ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的论文记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "删除成功",
  "competitionIds": [1001, 1002, 1003],
  "code": 200
}
```

##### 请求失败结果

```json
{
  "msg": "删除失败",
  "paperId": null,
  "code": 200
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectPaperByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
    "paperId": 1001,
    "userId": 1,
    "deptId": 101,
    "paperTitle": "人工智能在教育领域的应用研究",
    "paperCategory": "期刊论文",
    "researchDirection": "人工智能",
    "authorInformation": "第一作者",
    "journal": "计算机科学",
    "publishDate": "2024-10-15",
    "volume": "50",
    "issue": "10",
    "pageRange": "100-110",
    "doi": "10.1234/abc.2024.10.001",
    "auditStatus": "待审核",
    "createdAt": "2025-11-07",
    "updatedAt": "2025-11-10"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```

........其他错误

## 成果附件管理接口文档

### 查询附件列表

```
GET /api/selectAttachmentList
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`: `Long`类型，分页页码
- `pageSize`: `Long`类型，分页大小
- `resourceId`: `Long`类型，关联的子表ID（可选，用于筛选特定成果的附件）
- `attachmentType`: `String`类型，附件类型（可选，用于筛选特定类型的附件）

##### 查询数据字段

数据库ry-vue中achievements_attachment的全部字段

##### 请求参数示例

```
GET /api/selectAttachmentList?userId=1&deptId=100&pageNum=1&pageSize=10&resourceId=1001&attachmentType=paper
```

##### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

sql

```sql
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

sql

```sql
----------------------------示例----------------------------
SELECT * FROM achievements_attachment;  (data_scope = "1")

SELECT * FROM achievements_attachment WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_attachment WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_attachment WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_attachment WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

注意：如果提供了`resourceId`和`attachmentType`，则需要在SQL中添加条件：`WHERE resource_id = #{resourceId} AND attachment_type = #{attachmentType}`

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，附件列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "attachmentId": 1001,
      "userId": 1,
      "deptId": 101,
      "attachmentType": "paper",
      "fileName": "论文原文.pdf",
      "filePath": "/uploads/2025/11/26/abc.pdf",
      "fileSize": 2048,
      "fileExtension": "pdf",
      "fileCategory": "文档",
      "description": "论文原文",
      "uploadTime": "2025-11-26 10:00:00",
      "uploadUserId": "1",
      "downloadCount": 10,
      "resourceId": 1001
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询附件记录详细信息

```
GET /api/selectAttachmentById
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `attachmentId`: `Long`类型，附件ID（用于查询附件表的具体记录）

##### 查询数据字段

数据库ry-vue中achievements_attachment的指定ID记录

##### 请求参数示例

```
GET /api/selectAttachmentById?userId=1&deptId=100&attachmentId=1
```

需要进行权限检查原理同**查询附件列表**

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，附件详细信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "data": {
    "attachmentId": 1001,
    "userId": 1,
    "deptId": 101,
    "attachmentType": "paper",
    "fileName": "论文原文.pdf",
    "filePath": "/uploads/2025/11/26/abc.pdf",
    "fileSize": 2048,
    "fileExtension": "pdf",
    "fileCategory": "文档",
    "description": "论文原文",
    "uploadTime": "2025-11-26 10:00:00",
    "uploadUserId": "1",
    "downloadCount": 10,
    "resourceId": 1001
  },
  "msg": "查询成功"
}
```

##### 请求失败结果

json

复制

```
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增附件记录

```
POST /api/insertAttachment
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `attachmentType`: `String`类型，附件类型（例如：paper、contest、textbook等）
- `fileName`: `String`类型，文件名称
- `filePath`: `String`类型，文件路径
- `fileSize`: `Long`类型，文件大小（字节）
- `fileExtension`: `String`类型，文件扩展名
- `fileCategory`: `String`类型，文件分类
- `description`: `String`类型，文件描述
- `uploadUserId`: `String`类型，上传用户ID
- `resourceId`: `Long`类型，关联的子表ID

上传时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "attachmentType": "paper",
  "fileName": "论文原文.pdf",
  "filePath": "/uploads/2025/11/26/abc.pdf",
  "fileSize": 2048,
  "fileExtension": "pdf",
  "fileCategory": "文档",
  "description": "论文原文",
  "uploadUserId": "1",
  "resourceId": 1001
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的附件记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "attachmentId": 1007,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "msg": "附件信息插入失败",
  "attachmentId": null,
  "code": 200
}
```

### 更新附件记录

```
POST /api/updateAttachment
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `attachmentId`: `Long`类型，附件ID
- `attachmentType`: `String`类型，附件类型（例如：paper、contest、textbook等）
- `fileName`: `String`类型，文件名称
- `filePath`: `String`类型，文件路径
- `fileSize`: `Long`类型，文件大小（字节）
- `fileExtension`: `String`类型，文件扩展名
- `fileCategory`: `String`类型，文件分类
- `description`: `String`类型，文件描述
- `uploadUserId`: `String`类型，上传用户ID
- `resourceId`: `Long`类型，关联的子表ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "attachmentId": 1001,
  "attachmentType": "paper",
  "fileName": "论文原文（修订版）.pdf",
  "filePath": "/uploads/2025/11/26/abc.pdf",
  "fileSize": 2048,
  "fileExtension": "pdf",
  "fileCategory": "文档",
  "description": "论文原文",
  "uploadUserId": "1",
  "resourceId": 1001
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的附件记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "attachmentId": 1001,
  "msg": "更新成功"
}
```

##### 请求失败结果

```json
{
  "code": 200,
  "attachmentId": null,
  "msg": "附件信息更新失败"
}
```

### 删除附件记录

```
POST /api/deleteAttachments
```

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的附件记录ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的附件记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [1001, 1002, 1003],
  "msg": "删除成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"附件信息删除失败"    
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectAttachmentByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
      "attachmentId": 1001,
      "userId": 1,
      "deptId": 101,
      "attachmentType": "paper",
      "fileName": "论文原文.pdf",
      "filePath": "/uploads/2025/11/26/abc.pdf",
      "fileSize": 2048,
      "fileExtension": "pdf",
      "fileCategory": "文档",
      "description": "论文原文",
      "uploadTime": "2025-11-26 10:00:00",
      "uploadUserId": "1",
      "downloadCount": 10,
      "resourceId": 1001
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```

........其他错误

## 竞赛管理接口文档

### 查询竞赛列表

`GET /api/selectContestList`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `pageNum`:`Long `类型，分页页码
- `pageSize`:`Long `类型, 分页大小


##### 查询数据字段

数据库ry-vue中achievements_competition的全部字段


##### 请求参数示例

```json
GET /api/selectContestList?userId=1&deptId=100&pageNum=1&pageSize=10
```

sql示例
根据user_id查出role_id，在角色表中根据role_id查出 dataScope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
```

- `dataScope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql
SELECT * FROM achievements_competition;  (dataScope = "1")

SELECT * FROM achievements_competition WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(dataScope = "2")

SELECT * FROM achievements_competition WHERE dept_id = deptId;  (dataScope = "3")

SELECT * FROM achievements_competition WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (dataScope = "4")

SELECT * FROM achievements_competition WHERE user_id = userId;(dataScope = "5")	
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，竞赛列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "createBy": null,
      "createTime": null,
      "updateBy": null,
      "updateTime": null,
      "remark": null,
      "competitionId": 1001,
      "userId": 1,
      "deptId": 101,
      "competitionName": "全国大学生程序设计大赛",
      "competitionLevel": "国家级",
      "competitionType": "算法编程类",
      "competitionTime": "2024-10-15",
      "roleType": "指导老师",
      "awardLevel": "一等奖",
      "awardDate": "2024-10-20",
      "organizer": "教育部高等教育司",
      "competitionCategory": "学科竞赛",
      "teamSize": 3,
      "teamName": "创新之星团队",
      "studentParticipants": "[\"张三\", \"李四\", \"王五\"]",
      "awardCertificateNo": "CERT20241020001",
      "competitionWebsite": "https://acm.contest.edu.cn",
      "auditStatus": "待审核",
      "createdAt": "2025-11-07",
      "updatedAt": "2025-11-10"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```



请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

........其他错误

### 查询竞赛记录详细信息

`GET` /api/selectContestById

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `competitionId`:`Long`类型，竞赛ID（用于查询竞赛表的具体记录）


##### 查询数据字段

数据库ry-vue中achievements_competition的指定ID记录


##### 请求参数示例

```json
GET /api/selectContestById?userId=1&deptId=100&competitionId=1
```

需要进行权限检查原理同**查询竞赛列表**


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的用户信息
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "msg": "操作成功",
  "code": 200,
  "data": {
    "createBy": null,
    "createTime": null,
    "updateBy": null,
    "updateTime": null,
    "remark": null,
    "competitionId": 1001,
    "userId": 1,
    "deptId": 101,
    "competitionName": "全国大学生程序设计大赛",
    "competitionLevel": "国家级",
    "competitionType": "算法编程类",
    "competitionTime": "2024-10-15",
    "roleType": "指导老师",
    "awardLevel": "一等奖",
    "awardDate": "2024-10-20",
    "organizer": "教育部高等教育司",
    "competitionCategory": "学科竞赛",
    "teamSize": 3,
    "teamName": "创新之星团队",
    "studentParticipants": "[\"张三\", \"李四\", \"王五\"]",
    "awardCertificateNo": "CERT20241020001",
    "competitionWebsite": "https://acm.contest.edu.cn",
    "auditStatus": "待审核",
    "createdAt": "2025-11-07",
    "updatedAt": "2025-11-10"
  }
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

........其他错误

### 新增竞赛成果

`POST` /api/insertContest

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
-  `competitionName`: `String`类型，竞赛名称
-   `competitionLevel`: `String`类型，竞赛级别
-   `competitionType`: `String`类型，竞赛类型
- `competitionTime`: `Date`类型，竞赛时间
- `roleType`: `String `类型，角色类型
- `awardLevel`: `String `类型，获奖等级
- `awardDate`: `Date `类型，获奖日期
- `organizer`: `String`类型，主办单位
- `competitionCategory`: `String`类型，竞赛类别
- `teamSize`: `Long `类型，团队人数
- `teamName`: `String  `类型，团队名称
- `studentParticipants`: `String  `类型，指导的学生参赛
- `awardCertificateNo`: `String  `类型，获奖证书编号
- `competitionWebsite`: `String  `类型，竞赛官网
- `auditStatus`: `String  `类型，审核状态

##### 创建时间，更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
    "userId": 1,
    "deptId": 100,
    "competitionName": "全国大学生程序设计大赛",
    "competitionLevel": "国家级",
    "competitionType": "学科竞赛",
    "competitionTime": "2024-10-15 09:00:00",
    "roleType": "指导老师",
    "awardLevel": "一等奖",
    "awardDate": "2024-12-20",
    "organizer": "教育部高等学校计算机类专业教学指导委员会",
    "competitionCategory": "科技创新",
    "teamSize": 3,
    "teamName": "星辰之光",
    "studentParticipants": "张三;李四;王五",
    "awardCertificateNo": "NCPC202410001",
    "competitionWebsite": "https://example.ncpc.org",
    "auditStatus": "审核通过"
  }
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的竞赛记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "msg": "操作成功",
  "competitionId": 1007,
  "code": 200
}
```

请求失败结果

```json
{
  "code": 501,
  "competitionId": null,
  "msg":"竞赛信息插入失败"    
}
```

........其他错误

### 更新竞赛记录

`POST` /api/updateContest

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `competitionId`:`Long `类型,竞赛ID
-  `competitionName`: `String`类型，竞赛名称
-   `competitionLevel`: `String`类型，竞赛级别
-   `competitionType`: `String`类型，竞赛类型
- `competitionTime`: `Date`类型，竞赛时间
- `roleType`: `String `类型，角色类型
- `awardLevel`: `String `类型，获奖等级
- `awardDate`: `Date `类型，获奖日期
- `organizer`: `String`类型，主办单位
- `competitionCategory`: `String`类型，竞赛类别
- `teamSize`: `Long `类型，团队人数
- `teamName`: `String  `类型，团队名称
- `studentParticipants`: `String  `类型，指导的学生参赛
- `awardCertificateNo`: `String  `类型，获奖证书编号
- `competitionWebsite`: `String  `类型，竞赛官网
- `auditStatus`: `String  `类型，审核状态

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
    "userId": 1,
    "deptId": 100,
    "competitionId": 1,
    "competitionName": "全国大学生程序设计大赛",
    "competitionLevel": "国家级",
    "competitionType": "学科竞赛",
    "competitionTime": "2024-10-15 09:00:00",
    "roleType": "指导老师",
    "awardLevel": "一等奖",
    "awardDate": "2024-12-20",
    "organizer": "教育部高等学校计算机类专业教学指导委员会",
    "competitionCategory": "科技创新",
    "teamSize": 3,
    "teamName": "星辰之光",
    "studentParticipants": "张三;李四;王五",
    "awardCertificateNo": "NCPC202410001",
    "competitionWebsite": "https://example.ncpc.org",
    "auditStatus": "通过"
  }
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的竞赛记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "msg": "操作成功",
  "competitionId": 1001,
  "code": 200
}
```

请求失败结果

```json
{
  "code": 501,
  "competitionId": null,
  "msg":"竞赛信息更新失败"    
}
```

........其他错误

### 删除竞赛记录

`POST`  /api/deleteContests

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `competitionIds`:`Long[]`类型，删除的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的竞赛记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "msg": "删除成功",
  "competitionId": [1001, 1002, 1003],
  "code": 200
}
```

请求失败结果

```json
{
  "msg": "删除失败",
  "competitionId": null,
  "code": 200
}
```

........其他错误

### 根据id列表查询竞赛记录

`POST`  /api/selectContestByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "total": 1,
  "rows": [
    {
      "createBy": null,
      "createTime": null,
      "updateBy": null,
      "updateTime": null,
      "remark": null,
      "competitionId": 1001,
      "userId": 1,
      "deptId": 101,
      "competitionName": "全国大学生程序设计大赛",
      "competitionLevel": "国家级",
      "competitionType": "算法编程类",
      "competitionTime": "2024-10-15",
      "roleType": "指导老师",
      "awardLevel": "一等奖",
      "awardDate": "2024-10-20",
      "organizer": "教育部高等教育司",
      "competitionCategory": "学科竞赛",
      "teamSize": 3,
      "teamName": "创新之星团队",
      "studentParticipants": "[\"张三\", \"李四\", \"王五\"]",
      "awardCertificateNo": "CERT20241020001",
      "competitionWebsite": "https://acm.contest.edu.cn",
      "auditStatus": "待审核",
      "createdAt": "2025-11-07",
      "updatedAt": "2025-11-10"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

........其他错误

## 教材著作管理接口文档

### 查询教材列表

`GET /api/selectTextbookList`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`:`Long `类型，分页页码
- `pageSize`:`Long `类型, 分页大小

#### 查询数据字段

数据库ry-vue中achievements_textbook的全部字段

#### 请求参数示例

```
GET /api/selectTextbookList?userId=1&deptId=100&pageNum=1&pageSize=10
```

#### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql

----------------------------示例----------------------------
SELECT * FROM achievements_textbook;  (data_scope = "1")

SELECT * FROM achievements_textbook WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_textbook WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_textbook WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_textbook WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，教材列表
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
  "textbookId": 1001,
  "userId": 24306010534,
  "deptId": 101,
  "textbookName": "人工智能导论",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-1",
  "publishDate": "2024-05-20",
  "textbookType": "规划教材",
  "edition": "第一版",
  "wordCount": null,
  "usingInstitutions": null,
  "applicableMajor": null,
  "textbookLevel": "本科",
  "approvalNumber": null,
  "auditStatus": "待审核",
  "createdAt": "2025-11-07T10:53:26",
  "updatedAt": "2025-11-07T10:53:26"
}
  ],
  "code": 200,
  "msg": "查询成功"
}
```

#### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询教材记录详细信息

`GET /api/selectTextbookById`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `textbookId`: `Long`类型，教材ID（用于查询教材表的具体记录）

#### 查询数据字段

数据库ry-vue中achievements_textbook的指定ID记录

#### 请求参数示例

```
GET /api/selectTextbookById?userId=1&deptId=100&textbookId=1001
```

需要进行权限检查原理同**查询教材列表**

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，教材详细信息
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "data": {
  "textbookId": 1001,
  "userId": 24306010534,
  "deptId": 101,
  "textbookName": "人工智能导论",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-1",
  "publishDate": "2024-05-20",
  "textbookType": "规划教材",
  "edition": "第一版",
  "wordCount": null,
  "usingInstitutions": null,
  "applicableMajor": null,
  "textbookLevel": "本科",
  "approvalNumber": null,
  "auditStatus": "待审核",
  "createdAt": "2025-11-07T10:53:26",
  "updatedAt": "2025-11-07T10:53:26"
},
  "msg": "查询成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增教材成果

`POST /api/insertTextbook`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `textbookName`: `String`类型，教材名称
- `authorRole`: `String`类型，作者角色（主编/副主编/参编/独著）
- `pressName`: `String`类型，出版社
- `isbnNumber`: `String`类型，ISBN号
- `publishDate`: `Date`类型，出版时间
- `textbookType`: `String`类型，教材类型（规划教材/校本教材/国家级规划/省部级规划/行业规划）
- `edition`: `String`类型，版次
- `wordCount`: `Integer`类型，字数（万字）
- `usingInstitutions`: `String`类型，使用院校（JSON格式）
- `applicableMajor`: `String`类型，适用专业
- `textbookLevel`: `String`类型，教材层次（本科/专科/研究生/职业教育）
- `approvalNumber`: `String`类型，批准文号
- `auditStatus`: `String`类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "textbookName": "人工智能导论",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-1",
  "publishDate": "2024-05-20",
  "textbookType": "规划教材",
  "edition": "第一版",
  "wordCount": 50,
  "usingInstitutions": "[\"清华大学\", \"北京大学\"]",
  "applicableMajor": "计算机科学与技术,人工智能",
  "textbookLevel": "本科",
  "approvalNumber": "JY2024001",
  "auditStatus": "待审核"
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "msg": "操作成功",
  "textbookId": 1007,
  "code": 200
}
```

#### 请求失败结果

```json
{
  "msg": "教材信息插入失败",
  "textbookId": null,
  "code": 200
}
```

### 更新教材记录

`POST /api/updateTextbook`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `textbookId`: `Long`类型，教材ID
- `textbookName`: `String`类型，教材名称
- `authorRole`: `String`类型，作者角色（主编/副主编/参编/独著）
- `pressName`: `String`类型，出版社
- `isbnNumber`: `String`类型，ISBN号
- `publishDate`: `Date`类型，出版时间
- `textbookType`: `String`类型，教材类型（规划教材/校本教材/国家级规划/省部级规划/行业规划）
- `edition`: `String`类型，版次
- `wordCount`: `Integer`类型，字数（万字）
- `usingInstitutions`: `String`类型，使用院校（JSON格式）
- `applicableMajor`: `String`类型，适用专业
- `textbookLevel`: `String`类型，教材层次（本科/专科/研究生/职业教育）
- `approvalNumber`: `String`类型，批准文号
- `auditStatus`: `String`类型，审核状态

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "textbookId": 1001,
  "textbookName": "人工智能导论（第二版）",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-2",
  "publishDate": "2025-05-20",
  "textbookType": "国家级规划",
  "edition": "第二版",
  "wordCount": 55,
  "usingInstitutions": "[\"清华大学\", \"北京大学\", \"浙江大学\"]",
  "applicableMajor": "计算机科学与技术,人工智能,软件工程",
  "textbookLevel": "本科",
  "approvalNumber": "JY2025001",
  "auditStatus": "待审核"
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "textbookId": 1001,
  "msg": "更新成功"
}
```

#### 请求失败结果

```json
{
  "code": 200,
  "textbookId": null,
  "msg": "教材信息更新失败"
}
```

### 删除教材记录

`POST /api/deleteTextbooks`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的教材记录ID

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [1001, 1002, 1003],
  "msg": "删除成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"教材信息删除失败"    
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectTextbookByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
  "textbookId": 1001,
  "userId": 24306010534,
  "deptId": 101,
  "textbookName": "人工智能导论",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-1",
  "publishDate": "2024-05-20",
  "textbookType": "规划教材",
  "edition": "第一版",
  "wordCount": null,
  "usingInstitutions": null,
  "applicableMajor": null,
  "textbookLevel": "本科",
  "approvalNumber": null,
  "auditStatus": "待审核",
  "createdAt": "2025-11-07T10:53:26",
  "updatedAt": "2025-11-07T10:53:26"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```

........其他错误

## 获奖管理接口文档

### 查询获奖列表

`GET /api/selectAwardList`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`:`Long `类型，分页页码
- `pageSize`:`Long `类型, 分页大小

#### 查询数据字段

数据库ry-vue中achievements_award的全部字段

#### 请求参数示例

```
GET /api/selectAwardList?userId=1&deptId=100&pageNum=1&pageSize=10
```

#### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql
----------------------------示例----------------------------
SELECT * FROM achievements_textbook;  (data_scope = "1")

SELECT * FROM achievements_textbook WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_textbook WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_textbook WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_textbook WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，教材列表
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "total": 1,
  "rows": [
        {
        "awardId": 1,
        "userId": 1001,
        "deptId": 2001,
        "awardName": "优秀项目奖",
        "awardWinner": "张三",
        "awardUnit": "技术部",
        "awardDate": "2025-11-20",
        "awardLevel": "国家级",
        "awardCategory": "科学技术奖",
        "awardRanking": "一等奖",
        "awardCeremonyDate": "2025-12-10",
        "awardCeremonyPlace": "北京国家会议中心",
        "auditStatus": "0",
        "createdAt": "2025-11-20T10:00:00",
        "updatedAt": "2025-11-20T10:00:00"
        }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

#### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询获奖记录详细信息

`GET /api/selectAwardById`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `awardId: `Long`类型，获奖ID（用于查询教材表的具体记录）

#### 查询数据字段

数据库ry-vue中achievements_award的指定ID记录

#### 请求参数示例

```
GET /api/selectAwardById?userId=1&deptId=100&textbookId=1001
```

需要进行权限检查原理同**查询教材列表**

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，教材详细信息
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "data":{
    "awardId": 1,
    "userId": 1001,
    "deptId": 2001,
    "awardName": "优秀项目奖",
    "awardWinner": "张三",
    "awardUnit": "技术部",
    "awardDate": "2025-11-20",
    "awardLevel": "国家级",
    "awardCategory": "科学技术奖",
    "awardRanking": "一等奖",
    "awardCeremonyDate": "2025-12-10",
    "awardCeremonyPlace": "北京国家会议中心",
    "auditStatus": "0",
    "createdAt": "2025-11-20T10:00:00",
    "updatedAt": "2025-11-20T10:00:00"
    },
  "msg": "查询成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增获奖记录

`POST /api/insertAward`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

| 字段名            | 类型 (Java) | 是否必填 | 描述                                                 | 示例值                    |
| ----------------- | ----------- | -------- | ---------------------------------------------------- | ------------------------- |
| **userId**        | `Long`      | 是       | 用户ID                                               | `2143`                    |
| **deptId**        | `Long`      | 是       | 部门ID（用于部门权限隔离）                           | `103`                     |
| **awardId**       | `Long`      | 是       | 奖项唯一标识（主键），建议设置为自增或使用UUID。     | `1`                       |
| **awardName**     | `String`    | 是       | 奖项或成果的具体名称。                               | `"优秀项目奖"`            |
| **awardWinner**   | `String`    | 是       | 获奖个人或团队名称。                                 | `"张三"`或 `"创新项目组"` |
| **awardUnit**     | `String`    | 是       | 颁奖单位或机构。                                     | `"教育部"`                |
| **awardDate**     | `Date`      | 是       | 获奖日期。                                           | `"2025-11-20"`            |
| **awardLevel**    | `String`    | 是       | 奖项级别（如校级、市级、国家级、国际级等）。         | `"国家级"`                |
| **awardCategory** | `String`    | 是       | 奖项类别（如科学技术奖、学科竞赛、管理成果等）。     | `"科学技术奖"`            |
| **awardRanking**  | `String`    | 否       | 获奖等次（如一等奖、金奖）。                         | `"一等奖"`                |
| **userId**        | `Long`      | 是       | 提交或关联的用户ID，用于权限控制。                   | `1001`                    |
| **deptId**        | `Long`      | 是       | 所属部门ID，用于数据权限隔离。                       | `2001`                    |
| **auditStatus**   | `String`    | 是       | 审核状态（如：0-待审核, 1-审核通过, 2-审核不通过）。 | `"1"`                     |
| **createdAt**     | `Date`      | 是       | 记录创建时间。                                       | `"2025-11-20 10:00:00"`   |
| **updatedAt**     | `Date`      | 是       | 记录最后更新时间。                                   | `"2025-11-20 10:00:00"`   |

创建时间，更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "awardId": 1,
  "userId": 1001,
  "deptId": 2001,
  "awardName": "优秀项目奖",
  "awardWinner": "张三",
  "awardUnit": "技术部",
  "awardDate": "2025-11-20",
  "awardLevel": "国家级",
  "awardCategory": "科学技术奖",
  "awardRanking": "一等奖",
  "awardCeremonyDate": "2025-12-10",
  "awardCeremonyPlace": "北京国家会议中心",
  "auditStatus": "0",
  "createdAt": "2025-11-20T10:00:00",
  "updatedAt": "2025-11-20T10:00:00"
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "msg": "操作成功",
  "awardId": 1007,
  "code": 200
}
```

#### 请求失败结果

```json
{
  "msg": "教材信息插入失败",
  "awardId": null,
  "code": 200
}
```

### 更新获奖记录

`POST /api/updateAward`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

| 字段名            | 类型 (Java) | 是否必填 | 描述                                                 | 示例值                    |
| ----------------- | ----------- | -------- | ---------------------------------------------------- | ------------------------- |
| **userId**        | `Long`      | 是       | 用户ID                                               | `2143`                    |
| **deptId**        | `Long`      | 是       | 部门ID（用于部门权限隔离）                           | `103`                     |
| **awardId**       | `Long`      | 是       | 奖项唯一标识（主键），建议设置为自增或使用UUID。     | `1`                       |
| **awardName**     | `String`    | 是       | 奖项或成果的具体名称。                               | `"优秀项目奖"`            |
| **awardWinner**   | `String`    | 是       | 获奖个人或团队名称。                                 | `"张三"`或 `"创新项目组"` |
| **awardUnit**     | `String`    | 是       | 颁奖单位或机构。                                     | `"教育部"`                |
| **awardDate**     | `Date`      | 是       | 获奖日期。                                           | `"2025-11-20"`            |
| **awardLevel**    | `String`    | 是       | 奖项级别（如校级、市级、国家级、国际级等）。         | `"国家级"`                |
| **awardCategory** | `String`    | 是       | 奖项类别（如科学技术奖、学科竞赛、管理成果等）。     | `"科学技术奖"`            |
| **awardRanking**  | `String`    | 否       | 获奖等次（如一等奖、金奖）。                         | `"一等奖"`                |
| **userId**        | `Long`      | 是       | 提交或关联的用户ID，用于权限控制。                   | `1001`                    |
| **deptId**        | `Long`      | 是       | 所属部门ID，用于数据权限隔离。                       | `2001`                    |
| **auditStatus**   | `String`    | 是       | 审核状态（如：0-待审核, 1-审核通过, 2-审核不通过）。 | `"1"`                     |
| **createdAt**     | `Date`      | 是       | 记录创建时间。                                       | `"2025-11-20 10:00:00"`   |
| **updatedAt**     | `Date`      | 是       | 记录最后更新时间。                                   | `"2025-11-20 10:00:00"`   |

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "textbookId": 1001,
  "textbookName": "人工智能导论（第二版）",
  "authorRole": "主编",
  "pressName": "高等教育出版社",
  "isbnNumber": "978-7-04-060000-2",
  "publishDate": "2025-05-20",
  "textbookType": "国家级规划",
  "edition": "第二版",
  "wordCount": 55,
  "usingInstitutions": "[\"清华大学\", \"北京大学\", \"浙江大学\"]",
  "applicableMajor": "计算机科学与技术,人工智能,软件工程",
  "textbookLevel": "本科",
  "approvalNumber": "JY2025001",
  "auditStatus": "待审核"
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "awardId": 1001,
  "msg": "更新成功"
}
```

#### 请求失败结果

```json
{
  "code": 200,
  "awardId": null,
  "msg": "教材信息更新失败"
}
```

### 删除获奖记录

`POST /api/deleteAwardIds`

#### 请求头

- `Content-Type`: `application/json`

#### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的教材记录ID

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

#### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的教材记录ID
- `msg`: `String`类型，提示信息

#### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [1001, 1002, 1003],
  "msg": "删除成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"教材信息删除失败"    
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectAwardByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
    "awardId": 1,
    "userId": 1001,
    "deptId": 2001,
    "awardName": "优秀项目奖",
    "awardWinner": "张三",
    "awardUnit": "技术部",
    "awardDate": "2025-11-20",
    "awardLevel": "国家级",
    "awardCategory": "科学技术奖",
    "awardRanking": "一等奖",
    "awardCeremonyDate": "2025-12-10",
    "awardCeremonyPlace": "北京国家会议中心",
    "auditStatus": "0",
    "createdAt": "2025-11-20T10:00:00",
    "updatedAt": "2025-11-20T10:00:00"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```

........其他错误
## 软著成果管理接口文档

### 查询软著列表

GET /api/selectSoftwareList

- Content-Type: application/json

- userId: Long类型，用户ID（用于查询角色权限）
- deptId: Long类型，部门ID（用于部门权限隔离）
- pageNum: Long类型，分页页码
- pageSize: Long类型，分页大小

数据库ry-vue中achievements_software的全部字段

```
GET /api/selectSoftwareList?userId=1&deptId=100&pageNum=1&pageSize=10
```

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- data_scope: char类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```
----------------------------示例----------------------------
SELECT * FROM achievements_software;  (data_scope = "1")

SELECT * FROM achievements_software WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_software WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_software WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_software WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

- code: number类型，状态码
- data: Object类型，软著列表
- msg: String类型，提示信息

```
{
  "total": 1,
  "rows": [
    {
      "softwareId": 1001,
      "userId": 1,
      "deptId": 101,
      "softwareName": "智能教学辅助系统",
      "softwareVersion": "V1.0.0",
      "certificateNo": "2024SR0123456",
      "publishDate": "2024-10-01",
      "registerDate": "2024-11-15",
      "developmentDate": "2024-09-30",
      "programmingLanguage": "Java",
      "softwareType": "应用软件",
      "softwareCopyrightCertificateLevel": "普通",
      "certificateType": "软著登记证书",
      "mainFunction": "提供智能化的教学辅助功能，包括作业批改、学情分析等。",
      "applicationField": "教育技术",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

```
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询软著记录详细信息

GET /api/selectSoftwareById

- Content-Type: application/json

- userId: Long类型，用户ID（用于查询角色权限）
- deptId: Long类型，部门ID（用于部门权限隔离）
- softwareId: Long类型，软著ID（用于查询软著表的具体记录）

数据库ry-vue中achievements_software的指定ID记录

```
GET /api/selectSoftwareById?userId=1&deptId=100&softwareId=1001
```

需要进行权限检查原理同**查询软著列表**

- code: number类型，状态码
- data: Object类型，软著详细信息
- msg: String类型，提示信息

```
{
  "code": 200,
  "data": {
      "softwareId": 1001,
      "userId": 1,
      "deptId": 101,
      "softwareName": "智能教学辅助系统",
      "softwareVersion": "V1.0.0",
      "certificateNo": "2024SR0123456",
      "publishDate": "2024-10-01",
      "registerDate": "2024-11-15",
      "developmentDate": "2024-09-30",
      "programmingLanguage": "Java",
      "softwareType": "应用软件",
      "softwareCopyrightCertificateLevel": "普通",
      "certificateType": "软著登记证书",
      "mainFunction": "提供智能化的教学辅助功能，包括作业批改、学情分析等。",
      "applicationField": "教育技术",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
  },
  "msg": "查询成功"
}
```

```
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增软著成果

POST /api/insertSoftware

- Content-Type: application/json

- userId: Long类型，用户ID（用于查询角色权限）
- deptId: Long类型，部门ID（用于部门权限隔离）
- softwareName: String类型，软件名称
- softwareVersion: String类型，软件版本
- certificateNo: String类型，登记号
- publishDate: Date类型，发表日期
- registerDate: Date类型，登记日期
- developmentDate: Date类型，开发完成日期
- programmingLanguage: String类型，编程语言
- softwareType: String类型，软件类型
- softwareCopyrightCertificateLevel: String类型，软著等级
- certificateType: String类型，证书类型
- mainFunction: String类型，主要功能
- applicationField: String类型，应用领域
- auditStatus: String类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

```
{
  "userId": 1,
  "deptId": 100,
  "softwareName": "智能教学辅助系统",
  "softwareVersion": "V1.0.0",
  "certificateNo": "2024SR0123456",
  "publishDate": "2024-10-01",
  "registerDate": "2024-11-15",
  "developmentDate": "2024-09-30",
  "programmingLanguage": "Java",
  "softwareType": "应用软件",
  "softwareCopyrightCertificateLevel": "普通",
  "certificateType": "软著登记证书",
  "mainFunction": "提供智能化的教学辅助功能。",
  "applicationField": "教育技术",
  "auditStatus": "待审核"
}
```

- 
- code: number类型，状态码
- data: Object类型，上传后的软著记录ID
- msg: String类型，提示信息

```
{
  "msg": "操作成功",
  "softwareId": 1007,
  "code": 200
}
```

```
{
  "msg": "软著信息插入失败",
  "softwareId": null,
  "code": 200
}
```

### 更新软著记录

POST /api/updateSoftware

- Content-Type: application/json

- userId: Long类型，用户ID（用于查询角色权限）
- deptId: Long类型，部门ID（用于部门权限隔离）
- softwareId: Long类型，软著ID
- softwareName: String类型，软件名称
- softwareVersion: String类型，软件版本
- certificateNo: String类型，登记号
- publishDate: Date类型，发表日期
- registerDate: Date类型，登记日期
- developmentDate: Date类型，开发完成日期
- programmingLanguage: String类型，编程语言
- softwareType: String类型，软件类型
- softwareCopyrightCertificateLevel: String类型，软著等级
- certificateType: String类型，证书类型
- mainFunction: String类型，主要功能
- applicationField: String类型，应用领域
- auditStatus: String类型，审核状态

更新时间后端在接收参数后自行插入

```
{
  "userId": 1,
  "deptId": 100,
  "softwareId": 1001,
  "softwareName": "智能教学辅助系统（升级版）",
  "softwareVersion": "V2.0.0",
  "certificateNo": "2024SR0123457",
  "publishDate": "2025-01-01",
  "registerDate": "2025-02-15",
  "developmentDate": "2024-12-30",
  "programmingLanguage": "Java/Python",
  "softwareType": "应用软件",
  "softwareCopyrightCertificateLevel": "高级",
  "certificateType": "软著登记证书",
  "mainFunction": "新增AI分析模块。",
  "applicationField": "教育技术",
  "auditStatus": "待审核"
}
```

- code: number类型，状态码
- data: Object类型，更新后的软著记录ID
- msg: String类型，提示信息

```
{
  "code": 200,
  "softwareId": 1001,
  "msg": "更新成功"
}
```

```
{
  "code": 200,
  "softwareId": null,
  "msg": "软著信息更新失败"
}
```

### 删除软著记录

POST /api/deleteSoftwares

- Content-Type: application/json

- `userId`: Long类型，用户ID（用于查询角色权限）
- `deptId`: Long类型，部门ID（用于部门权限隔离）
- `competitionIds`: Long[]类型，删除的软著记录ID

更新时间后端在接收参数后自行插入

```java
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

- code: number类型，状态码
- data: Object类型，删除的软著记录ID
- msg: String类型，提示信息

```java
{
  "code": 200,
  "competitionIds": [1001, 1002, 1003],
  "msg": "删除成功"
}
```

```java
{
  "code": 501,
  "softwareId": null,
  "msg":"软著信息删除失败"    
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectSoftwareByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
      "softwareId": 1001,
      "userId": 1,
      "deptId": 101,
      "softwareName": "智能教学辅助系统",
      "softwareVersion": "V1.0.0",
      "certificateNo": "2024SR0123456",
      "publishDate": "2024-10-01",
      "registerDate": "2024-11-15",
      "developmentDate": "2024-09-30",
      "programmingLanguage": "Java",
      "softwareType": "应用软件",
      "softwareCopyrightCertificateLevel": "普通",
      "certificateType": "软著登记证书",
      "mainFunction": "提供智能化的教学辅助功能，包括作业批改、学情分析等。",
      "applicationField": "教育技术",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```

........其他错误

## 专著管理接口文档

### 查询专著列表

`GET /api/selectMonographList`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`: `Long`类型，分页页码
- `pageSize`: `Long`类型，分页大小

##### 查询数据字段

数据库ry-vue中achievements_monograph的全部字段

##### 请求参数示例

```
GET /api/selectMonographList?userId=1&deptId=100&pageNum=1&pageSize=10
```

##### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql
----------------------------示例----------------------------
SELECT * FROM achievements_monograph;  (data_scope = "1")

SELECT * FROM achievements_monograph WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_monograph WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_monograph WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_monograph WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，专著列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "monographId": 1001,
      "userId": 1,
      "deptId": 101,
      "monographTitle": "大数据挖掘技术与应用",
      "authorRole": "第一作者",
      "pressName": "清华大学出版社",
      "isbnNumber": "978-7-302-12345-6",
      "publishDate": "2024-05-15",
      "monographType": "学术专著",
      "edition": "第一版",
      "wordCount": 35,
      "pageCount": 420,
      "language": "中文",
      "subjectCategory": "计算机科学与技术",
      "isIncluded": 1,
      "includedDatabase": "CSCD",
      "awardSituation": "校级优秀学术著作一等奖",
      "coAuthors": "[{\"name\":\"李四\",\"unit\":\"计算机学院\"}]",
      "internationalStandardBookNumber": "978-7-302-12345-6",
      "chinaClassificationNumber": "TP311",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询专著记录详细信息

`GET /api/selectMonographById`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `monographId`: `Long`类型，专著ID（用于查询专著表的具体记录）

##### 查询数据字段

数据库ry-vue中achievements_monograph的指定ID记录

##### 请求参数示例

```
GET /api/selectMonographById?userId=1&deptId=100&monographId=1001
```

需要进行权限检查原理同**查询专著列表**

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，专著详细信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "data": {
      "monographId": 1001,
      "userId": 1,
      "deptId": 101,
      "monographTitle": "大数据挖掘技术与应用",
      "authorRole": "第一作者",
      "pressName": "清华大学出版社",
      "isbnNumber": "978-7-302-12345-6",
      "publishDate": "2024-05-15",
      "monographType": "学术专著",
      "edition": "第一版",
      "wordCount": 35,
      "pageCount": 420,
      "language": "中文",
      "subjectCategory": "计算机科学与技术",
      "isIncluded": 1,
      "includedDatabase": "CSCD",
      "awardSituation": "校级优秀学术著作一等奖",
      "coAuthors": "[{\"name\":\"李四\",\"unit\":\"计算机学院\"}]",
      "internationalStandardBookNumber": "978-7-302-12345-6",
      "chinaClassificationNumber": "TP311",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
  },
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增专著成果

`POST /api/insertMonograph`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `monographTitle`: `String`类型，专著名称
- `authorRole`: `String`类型，作者角色
- `pressName`: `String`类型，出版社
- `isbnNumber`: `String`类型，ISBN号
- `publishDate`: `Date`类型，出版时间
- `monographType`: `String`类型，专著类型
- `edition`: `String`类型，版次
- `wordCount`: `Long`类型，字数（万字）
- `pageCount`: `Long`类型，页数
- `language`: `String`类型，著作语言
- `subjectCategory`: `String`类型，学科分类
- `isIncluded`: `Integer`类型，是否被收录（1:是, 0:否）
- `includedDatabase`: `String`类型，收录数据库
- `awardSituation`: `String`类型，获奖情况
- `coAuthors`: `String`类型，合著者信息
- `internationalStandardBookNumber`: `String`类型，国际标准书号
- `chinaClassificationNumber`: `String`类型，中国分类号
- `auditStatus`: `String`类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "monographTitle": "大数据挖掘技术与应用",
  "authorRole": "第一作者",
  "pressName": "清华大学出版社",
  "isbnNumber": "978-7-302-12345-6",
  "publishDate": "2024-05-15",
  "monographType": "学术专著",
  "edition": "第一版",
  "wordCount": 35,
  "pageCount": 420,
  "language": "中文",
  "subjectCategory": "计算机科学与技术",
  "isIncluded": 1,
  "includedDatabase": "CSCD",
  "awardSituation": "暂无",
  "coAuthors": "[{\"name\":\"李四\",\"unit\":\"计算机学院\"}]",
  "internationalStandardBookNumber": "978-7-302-12345-6",
  "chinaClassificationNumber": "TP311",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的专著记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "monographId": 1007,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "msg": "专著信息插入失败",
  "monographId": null,
  "code": 200
}
```

### 更新专著记录

`POST /api/updateMonograph`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `monographId`: `Long`类型，专著ID
- `monographTitle`: `String`类型，专著名称
- `authorRole`: `String`类型，作者角色
- `pressName`: `String`类型，出版社
- `isbnNumber`: `String`类型，ISBN号
- `publishDate`: `Date`类型，出版时间
- `monographType`: `String`类型，专著类型
- `edition`: `String`类型，版次
- `wordCount`: `Long`类型，字数（万字）
- `pageCount`: `Long`类型，页数
- `language`: `String`类型，著作语言
- `subjectCategory`: `String`类型，学科分类
- `isIncluded`: `Integer`类型，是否被收录
- `includedDatabase`: `String`类型，收录数据库
- `awardSituation`: `String`类型，获奖情况
- `coAuthors`: `String`类型，合著者信息
- `internationalStandardBookNumber`: `String`类型，国际标准书号
- `chinaClassificationNumber`: `String`类型，中国分类号
- `auditStatus`: `String`类型，审核状态

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "monographId": 1001,
  "monographTitle": "大数据挖掘技术与应用（修订版）",
  "authorRole": "独著",
  "pressName": "清华大学出版社",
  "isbnNumber": "978-7-302-12345-6",
  "publishDate": "2025-06-01",
  "monographType": "学术专著",
  "edition": "第二版",
  "wordCount": 40,
  "pageCount": 450,
  "language": "中文",
  "subjectCategory": "人工智能",
  "isIncluded": 1,
  "includedDatabase": "SCI",
  "awardSituation": "省级一等奖",
  "coAuthors": "[]",
  "internationalStandardBookNumber": "978-7-302-12345-6",
  "chinaClassificationNumber": "TP311",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的专著记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "monographId": 1001,
  "msg": "更新成功"
}
```

##### 请求失败结果

```json
{
  "code": 200,
  "monographId": null,
  "msg": "专著信息更新失败"
}
```

### 删除专著记录

`POST /api/deleteMonographs`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的专著记录ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [1001, 1002, 1003]
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `competitionIds`: `Object`类型，删除的专著记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [1001],
  "msg": "删除成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"专著信息删除失败"    
}
```

### 根据id列表查询竞赛记录

`POST`  /api/selectMonographByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
     "monographId": 1001,
      "userId": 1,
      "deptId": 101,
      "monographTitle": "大数据挖掘技术与应用",
      "authorRole": "第一作者",
      "pressName": "清华大学出版社",
      "isbnNumber": "978-7-302-12345-6",
      "publishDate": "2024-05-15",
      "monographType": "学术专著",
      "edition": "第一版",
      "wordCount": 35,
      "pageCount": 420,
      "language": "中文",
      "subjectCategory": "计算机科学与技术",
      "isIncluded": 1,
      "includedDatabase": "CSCD",
      "awardSituation": "校级优秀学术著作一等奖",
      "coAuthors": "[{\"name\":\"李四\",\"unit\":\"计算机学院\"}]",
      "internationalStandardBookNumber": "978-7-302-12345-6",
      "chinaClassificationNumber": "TP311",
      "auditStatus": "待审核",
      "createdAt": "2024-11-20",
      "updatedAt": "2024-11-20"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```
## 专利管理接口文档

### 查询专利列表

`GET /api/selectPatentList`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`: `Long`类型，分页页码
- `pageSize`: `Long`类型，分页大小

##### 查询数据字段

数据库ry-vue中achievements_patent的全部字段

##### 请求参数示例

```
GET /api/selectPatentList?userId=1&deptId=100&pageNum=1&pageSize=10
```

##### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql
----------------------------示例----------------------------
SELECT * FROM achievements_patent;  (data_scope = "1")

SELECT * FROM achievements_patent WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_patent WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_patent WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_patent WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，专利列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "patentId": 2001,
      "userId": 1,
      "deptId": 101,
      "patentName": "一种智能数据处理装置",
      "patentNo": "ZL202310123456.7",
      "patentType": "发明专利",
      "authorOrder": 1,
      "applicationDate": "2023-01-15",
      "authorizationDate": "2024-03-20",
      "publicationDate": "2023-07-01",
      "publicationNo": "CN116000000A",
      "patentValidity": "2043-01-15",
      "patentSubject": "计算机科学与技术",
      "patentStatus": "已授权",
      "patentOffice": "国家知识产权局",
      "technicalField": "人工智能与大数据",
      "legalStatus": "有效",
      "certificateType": "authorization_certificate",
      "auditStatus": "待审核",
      "createdAt": "2024-03-25",
      "updatedAt": "2024-03-25"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询专利记录详细信息

`GET /api/selectPatentById`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `patentId`: `Long`类型，专利ID（用于查询专利表的具体记录）

##### 查询数据字段

数据库ry-vue中achievements_patent的指定ID记录

##### 请求参数示例

```
GET /api/selectPatentById?userId=1&deptId=100&patentId=2001
```

需要进行权限检查原理同**查询专利列表**

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，专利详细信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "data": {
      "patentId": 2001,
      "userId": 1,
      "deptId": 101,
      "patentName": "一种智能数据处理装置",
      "patentNo": "ZL202310123456.7",
      "patentType": "发明专利",
      "authorOrder": 1,
      "applicationDate": "2023-01-15",
      "authorizationDate": "2024-03-20",
      "publicationDate": "2023-07-01",
      "publicationNo": "CN116000000A",
      "patentValidity": "2043-01-15",
      "patentSubject": "计算机科学与技术",
      "patentStatus": "已授权",
      "patentOffice": "国家知识产权局",
      "technicalField": "人工智能与大数据",
      "legalStatus": "有效",
      "certificateType": "authorization_certificate",
      "auditStatus": "待审核",
      "createdAt": "2024-03-25",
      "updatedAt": "2024-03-25"
  },
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增专利成果

`POST /api/insertPatent`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID
- `deptId`: `Long`类型，部门ID
- `patentName`: `String`类型，专利名称
- `patentNo`: `String`类型，专利号
- `patentType`: `String`类型，专利类型（发明专利/实用新型/外观设计）
- `authorOrder`: `Long`类型，发明人顺序
- `applicationDate`: `Date`类型，申请日期
- `authorizationDate`: `Date`类型，授权日期（可选）
- `publicationDate`: `Date`类型，公布日期（可选）
- `publicationNo`: `String`类型，公布号（可选）
- `patentValidity`: `Date`类型，专利有效期
- `patentSubject`: `String`类型，专利所属学科
- `patentStatus`: `String`类型，专利状态（申请中/已授权等）
- `patentOffice`: `String`类型，专利局
- `technicalField`: `String`类型，技术领域
- `legalStatus`: `String`类型，专利法律状态
- `certificateType`: `String`类型，证书类型
- `auditStatus`: `String`类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "patentName": "一种高效的图像识别算法",
  "patentNo": "202410123456.X",
  "patentType": "发明专利",
  "authorOrder": 1,
  "applicationDate": "2024-01-10",
  "patentValidity": "2044-01-10",
  "patentSubject": "计算机视觉",
  "patentStatus": "申请中",
  "patentOffice": "国家知识产权局",
  "technicalField": "人工智能",
  "legalStatus": "申请中",
  "certificateType": "application_notice",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的专利记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "patentId": 2007,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "msg": "专利信息插入失败",
  "patentId": null,
  "code": 200
}
```

### 更新专利记录

`POST /api/updatePatent`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID
- `deptId`: `Long`类型，部门ID
- `patentId`: `Long`类型，专利ID
- `patentName`: `String`类型，专利名称
- `patentNo`: `String`类型，专利号
- `patentType`: `String`类型，专利类型
- `authorOrder`: `Long`类型，发明人顺序
- `applicationDate`: `Date`类型，申请日期
- `authorizationDate`: `Date`类型，授权日期
- `publicationDate`: `Date`类型，公布日期
- `publicationNo`: `String`类型，公布号
- `patentValidity`: `Date`类型，专利有效期
- `patentSubject`: `String`类型，专利所属学科
- `patentStatus`: `String`类型，专利状态
- `patentOffice`: `String`类型，专利局
- `technicalField`: `String`类型，技术领域
- `legalStatus`: `String`类型，专利法律状态
- `certificateType`: `String`类型，证书类型
- `auditStatus`: `String`类型，审核状态

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "patentId": 2007,
  "patentName": "一种高效的图像识别算法",
  "patentNo": "ZL202410123456.X",
  "patentType": "发明专利",
  "authorOrder": 1,
  "applicationDate": "2024-01-10",
  "authorizationDate": "2025-02-15",
  "publicationDate": "2024-07-10",
  "publicationNo": "CN117000000A",
  "patentValidity": "2044-01-10",
  "patentSubject": "计算机视觉",
  "patentStatus": "已授权",
  "patentOffice": "国家知识产权局",
  "technicalField": "人工智能",
  "legalStatus": "有效",
  "certificateType": "authorization_certificate",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的专利记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "patentId": 2007,
  "msg": "更新成功"
}
```

##### 请求失败结果

```json
{
  "code": 200,
  "patentId": null,
  "msg": "专利信息更新失败"
}
```

### 删除专利记录

`POST /api/deletePatents`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的专利记录ID数组

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [2001, 2002, 2003]
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的专利记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [2001],
  "msg": "删除成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"专利信息删除失败"    
}
```

### 根据id列表查询竞赛记录

`POST`  /api/selectPatentByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
      "patentId": 2001,
      "userId": 1,
      "deptId": 101,
      "patentName": "一种智能数据处理装置",
      "patentNo": "ZL202310123456.7",
      "patentType": "发明专利",
      "authorOrder": 1,
      "applicationDate": "2023-01-15",
      "authorizationDate": "2024-03-20",
      "publicationDate": "2023-07-01",
      "publicationNo": "CN116000000A",
      "patentValidity": "2043-01-15",
      "patentSubject": "计算机科学与技术",
      "patentStatus": "已授权",
      "patentOffice": "国家知识产权局",
      "technicalField": "人工智能与大数据",
      "legalStatus": "有效",
      "certificateType": "authorization_certificate",
      "auditStatus": "待审核",
      "createdAt": "2024-03-25",
      "updatedAt": "2024-03-25"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```
## 成果转化管理接口文档

### 查询成果转化列表

`GET /api/selectTransferList`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `pageNum`: `Long`类型，分页页码
- `pageSize`: `Long`类型，分页大小

##### 查询数据字段

数据库ry-vue中achievements_transfer的全部字段

##### 请求参数示例

```
GET /api/selectTransferList?userId=1&deptId=100&pageNum=1&pageSize=10
```

##### SQL权限控制

根据user_id查出role_id，在角色表中根据role_id查出 data_scope 来确定数据权限，再根据数据权限来动态拼接SQL语句

```sql
----------------------------示例----------------------------
SELECT 
    r.data_scope
FROM sys_user u
LEFT JOIN sys_user_role ur ON u.user_id = ur.user_id
LEFT JOIN sys_role r ON ur.role_id = r.role_id
WHERE u.user_id = 1
AND u.del_flag = '0'
AND u.status = '0'
AND r.del_flag = '0'
AND r.status = '0';
----------------------------示例----------------------------
```

- `data_scope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

```sql
----------------------------示例----------------------------
SELECT * FROM achievements_transfer;  (data_scope = "1")

SELECT * FROM achievements_transfer WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  		(data_scope = "2")

SELECT * FROM achievements_transfer WHERE dept_id = deptId;  (data_scope = "3")

SELECT * FROM achievements_transfer WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (data_scope = "4")

SELECT * FROM achievements_transfer WHERE user_id = userId;(data_scope = "5")
----------------------------示例----------------------------
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，成果转化列表
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "total": 1,
  "rows": [
    {
      "transferId": 3001,
      "userId": 1,
      "deptId": 101,
      "achievementName": "高性能芯片散热技术",
      "achievementType": "专利",
      "achievementNumber": "ZL202310001",
      "transferMethod": "技术转让",
      "partnerEnterprise": "未来科技有限公司",
      "transferAmount": 500.00,
      "transferDate": "2024-05-10",
      "transferDescription": "将芯片散热专利技术整体转让给合作企业。",
      "validityPeriod": "永久",
      "territoryRange": "全球",
      "paymentMethod": "分期付款",
      "transferStatus": "已签约",
      "isExclusive": 1,
      "economicBenefits": "预计年增收2000万元",
      "socialBenefits": "推动半导体行业发展",
      "contactPerson": "张三",
      "contactPhone": "13800138000",
      "auditStatus": "待审核",
      "createdAt": "2024-05-15",
      "updatedAt": "2024-05-15"
    }
  ],
  "code": 200,
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 200,
  "msg": "查询失败"
}
```

### 查询成果转化记录详细信息

`GET /api/selectTransferById`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `transferId`: `Long`类型，转化ID（用于查询转化表的具体记录）

##### 查询数据字段

数据库ry-vue中achievements_transfer的指定ID记录

##### 请求参数示例

```
GET /api/selectTransferById?userId=1&deptId=100&transferId=3001
```

需要进行权限检查原理同**查询成果转化列表**

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，成果转化详细信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "data": {
      "transferId": 3001,
      "userId": 1,
      "deptId": 101,
      "achievementName": "高性能芯片散热技术",
      "achievementType": "专利",
      "achievementNumber": "ZL202310001",
      "transferMethod": "技术转让",
      "partnerEnterprise": "未来科技有限公司",
      "transferAmount": 500.00,
      "transferDate": "2024-05-10",
      "transferDescription": "将芯片散热专利技术整体转让给合作企业。",
      "validityPeriod": "永久",
      "territoryRange": "全球",
      "paymentMethod": "分期付款",
      "transferStatus": "已签约",
      "isExclusive": 1,
      "economicBenefits": "预计年增收2000万元",
      "socialBenefits": "推动半导体行业发展",
      "contactPerson": "张三",
      "contactPhone": "13800138000",
      "auditStatus": "待审核",
      "createdAt": "2024-05-15",
      "updatedAt": "2024-05-15"
  },
  "msg": "查询成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"查询详细信息失败"    
}
```

### 新增成果转化成果

`POST /api/insertTransfer`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID
- `deptId`: `Long`类型，部门ID
- `achievementName`: `String`类型，成果名称
- `achievementType`: `String`类型，成果类型
- `achievementNumber`: `String`类型，成果编号
- `transferMethod`: `String`类型，转化方式
- `partnerEnterprise`: `String`类型，合作企业
- `transferAmount`: `BigDecimal`类型，转化金额（万元）
- `transferDate`: `Date`类型，转化时间
- `transferDescription`: `String`类型，转化内容描述
- `validityPeriod`: `String`类型，有效期限
- `territoryRange`: `String`类型，地域范围
- `paymentMethod`: `String`类型，支付方式
- `transferStatus`: `String`类型，转化状态
- `isExclusive`: `Integer`类型，是否独占许可 (0:否, 1:是)
- `economicBenefits`: `String`类型，经济效益
- `socialBenefits`: `String`类型，社会效益
- `contactPerson`: `String`类型，联系人
- `contactPhone`: `String`类型，联系电话
- `auditStatus`: `String`类型，审核状态

创建时间，更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "achievementName": "新型环保材料制备工艺",
  "achievementType": "技术秘密",
  "achievementNumber": "JS2024005",
  "transferMethod": "技术许可",
  "partnerEnterprise": "绿能环保集团",
  "transferAmount": 200.50,
  "transferDate": "2024-06-01",
  "transferDescription": "授权该企业在华东地区使用该制备工艺。",
  "validityPeriod": "5年",
  "territoryRange": "中国华东地区",
  "paymentMethod": "一次性支付",
  "transferStatus": "洽谈中",
  "isExclusive": 0,
  "economicBenefits": "预期节省成本15%",
  "socialBenefits": "减少环境污染",
  "contactPerson": "李四",
  "contactPhone": "010-88888888",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，上传后的转化记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "msg": "操作成功",
  "transferId": 3007,
  "code": 200
}
```

##### 请求失败结果

```json
{
  "msg": "成果转化信息插入失败",
  "transferId": null,
  "code": 200
}
```

### 更新成果转化记录

`POST /api/updateTransfer`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID
- `deptId`: `Long`类型，部门ID
- `transferId`: `Long`类型，转化ID
- `achievementName`: `String`类型，成果名称
- `achievementType`: `String`类型，成果类型
- `achievementNumber`: `String`类型，成果编号
- `transferMethod`: `String`类型，转化方式
- `partnerEnterprise`: `String`类型，合作企业
- `transferAmount`: `BigDecimal`类型，转化金额（万元）
- `transferDate`: `Date`类型，转化时间
- `transferDescription`: `String`类型，转化内容描述
- `validityPeriod`: `String`类型，有效期限
- `territoryRange`: `String`类型，地域范围
- `paymentMethod`: `String`类型，支付方式
- `transferStatus`: `String`类型，转化状态
- `isExclusive`: `Integer`类型，是否独占许可
- `economicBenefits`: `String`类型，经济效益
- `socialBenefits`: `String`类型，社会效益
- `contactPerson`: `String`类型，联系人
- `contactPhone`: `String`类型，联系电话
- `auditStatus`: `String`类型，审核状态

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "transferId": 3007,
  "achievementName": "新型环保材料制备工艺",
  "achievementType": "技术秘密",
  "achievementNumber": "JS2024005",
  "transferMethod": "技术许可",
  "partnerEnterprise": "绿能环保集团",
  "transferAmount": 200.50,
  "transferDate": "2024-06-01",
  "transferDescription": "授权该企业在华东地区使用该制备工艺。",
  "validityPeriod": "5年",
  "territoryRange": "中国华东地区",
  "paymentMethod": "一次性支付",
  "transferStatus": "已签约",
  "isExclusive": 0,
  "economicBenefits": "预期节省成本15%",
  "socialBenefits": "减少环境污染",
  "contactPerson": "李四",
  "contactPhone": "010-88888888",
  "auditStatus": "待审核"
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的转化记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "transferId": 3007,
  "msg": "更新成功"
}
```

##### 请求失败结果

```json
{
  "code": 200,
  "transferId": null,
  "msg": "成果转化信息更新失败"
}
```

### 删除成果转化记录

`POST /api/deleteTransfers`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long`类型，用户ID（用于查询角色权限）
- `deptId`: `Long`类型，部门ID（用于部门权限隔离）
- `competitionIds`: `Long[]`类型，删除的转化记录ID数组

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "competitionIds": [3001, 3002, 3003]
}
```

##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，删除的转化记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例

```json
{
  "code": 200,
  "competitionIds": [3001],
  "msg": "删除成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "competitionIds": null,
  "msg":"成果转化信息删除失败"    
}
```
### 根据id列表查询竞赛记录

`POST`  /api/selectTransferByIds

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `Ids`:`Long[]`类型，查询的竞赛记录ID

##### 更新时间后端在接收参数后自行插入


##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "Ids": [1001, 1002, 1003]
}
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，查询的竞赛记录
- `msg`: `String`类型，提示信息

##### 响应结果示例
请求成功结果
```json
{
  "total": 1,
  "rows": [
{
      "transferId": 3001,
      "userId": 1,
      "deptId": 101,
      "achievementName": "高性能芯片散热技术",
      "achievementType": "专利",
      "achievementNumber": "ZL202310001",
      "transferMethod": "技术转让",
      "partnerEnterprise": "未来科技有限公司",
      "transferAmount": 500.00,
      "transferDate": "2024-05-10",
      "transferDescription": "将芯片散热专利技术整体转让给合作企业。",
      "validityPeriod": "永久",
      "territoryRange": "全球",
      "paymentMethod": "分期付款",
      "transferStatus": "已签约",
      "isExclusive": 1,
      "economicBenefits": "预计年增收2000万元",
      "socialBenefits": "推动半导体行业发展",
      "contactPerson": "张三",
      "contactPhone": "13800138000",
      "auditStatus": "待审核",
      "createdAt": "2024-05-15",
      "updatedAt": "2024-05-15"
}
]
"code":200
"msg": "查询成功"
```
请求失败结果

```json
{
  "total": 0,
  "rows": null,
  "code": 501,
  "msg": "查询失败"
}
```



