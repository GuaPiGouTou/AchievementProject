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
- `paperIds`: `Long[]`类型，删除的论文记录ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "paperIds": [1001, 1002, 1003]
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
  "paperId": 1001,
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
- `attachmentIds`: `Long[]`类型，删除的附件记录ID

更新时间后端在接收参数后自行插入

##### 请求参数示例

```json
{
  "userId": 1,
  "deptId": 100,
  "attachmentIds": [1001, 1002, 1003]
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
  "attachmentId": 1001,
  "msg": "删除成功"
}
```

##### 请求失败结果

```json
{
  "code": 501,
  "attachmentId": null,
  "msg":"附件信息删除失败"    
}
```

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
  "competitionId": 1001,
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
- `textbookIds`: `Long[]`类型，删除的教材记录ID

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "textbookIds": [1001, 1002, 1003]
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
  "textbookId": 1001,
  "msg": "删除成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "textbookId": null,
  "msg":"教材信息删除失败"    
}
```

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
- `textbookIds`: `Long[]`类型，删除的教材记录ID

更新时间后端在接收参数后自行插入

#### 请求参数示例

```json
{
  "userId": 24306010534,
  "deptId": 100,
  "awardIds": [1001, 1002, 1003]
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
  "awardId": 1001,
  "msg": "删除成功"
}
```

#### 请求失败结果

```json
{
  "code": 501,
  "awardId": null,
  "msg":"教材信息删除失败"    
}
```

