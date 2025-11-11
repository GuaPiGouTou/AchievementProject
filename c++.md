### 查询竞赛列表

#### `GET /api/selectContestList`

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）


##### 查询数据字段

数据库ry-vue中achievements_competition的全部字段


##### 请求参数示例

```json
GET /api/selectContestList?userId=1&deptId=100
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
  "code": 200,
  "data": [
    {
      "competition_id": 1001,
      "user_id": 1,
      "dept_id": 101,
      "competition_name": "全国大学生程序设计大赛",
      "competition_level": "国家级",
      "competition_type": "算法编程类",
      "competition_time": "2024-10-15T09:00:00",
      "role_type": "指导老师",
      "award_level": "一等奖",
      "award_date": "2024-10-20",
      "organizer": "教育部高等教育司",
      "competition_category": "学科竞赛",
      "team_size": 3,
      "team_name": "创新之星团队",
      "student_participants": "[\"张三\", \"李四\", \"王五\"]",
      "award_certificate_no": "CERT20241020001",
      "competition_website": "https://acm.contest.edu.cn",
      "audit_status": "待审核",
      "created_at": "2025-11-07T10:25:10",
      "updated_at": "2025-11-10T16:38:56"
    },
    {
      "competition_id": 1002,
      "user_id": 1,
      "dept_id": 100,
      "competition_name": "全国大学生java",
      "competition_level": "国家级",
      "competition_type": "算法编程",
      "competition_time": "2025-11-10T16:02:50",
      "role_type": "参赛者",
      "award_level": "三等奖",
      "award_date": "2025-11-10",
      "organizer": "教育局",
      "competition_category": "学科竞赛",
      "team_size": 1,
      "team_name": "无敌",
      "student_participants": "成型也，薛红绯",
      "award_certificate_no": "CERT20241020002",
      "competition_website": "https://acm.contest.edu.cn",
      "audit_status": "待审核",
      "created_at": "2025-11-10T16:03:40",
      "updated_at": "2025-11-10T17:12:24"
    }
  ],
  "msg": "查询成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"竞赛列表查询失败"    
}
```

........其他错误

### 查询竞赛记录详细信息

#### `GET /api/selectContestById

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
  "code": 200,
  "data": {
      "competition_id": 1001,
      "user_id": 1,
      "dept_id": 101,
      "competition_name": "全国大学生程序设计大赛",
      "competition_level": "国家级",
      "competition_type": "算法编程类",
      "competition_time": "2024-10-15T09:00:00",
      "role_type": "指导老师",
      "award_level": "一等奖",
      "award_date": "2024-10-20",
      "organizer": "教育部高等教育司",
      "competition_category": "学科竞赛",
      "team_size": 3,
      "team_name": "创新之星团队",
      "student_participants": "[\"张三\", \"李四\", \"王五\"]",
      "award_certificate_no": "CERT20241020001",
      "competition_website": "https://acm.contest.edu.cn",
      "audit_status": "待审核",
      "created_at": "2025-11-07T10:25:10",
      "updated_at": "2025-11-10T16:38:56"
    },
  "msg": "查询成功"
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

#### `POST /api/insertContest

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
  "code": 200,
  "data": {
      "competition_id": 1001
    },
  "msg": "插入成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"竞赛信息插入失败"    
}
```

........其他错误

### 更新竞赛记录

#### `POST /api/updateContest

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
    "auditStatus": "审核通过"
  }
```


##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的竞赛记录ID
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "code": 200,
  "data": {
      "competition_id": 1001
    },
  "msg": "更新成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"竞赛信息更新失败"    
}
```

........其他错误

### 删除竞赛记录

#### `POST  /api/deleteContests

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `Long `类型，用户ID（用于查询角色权限）
- `deptId`: `Long `类型，部门ID（用于部门权限隔离）
- `competitionIds`:`Array`类型，删除的竞赛记录ID

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
  "code": 200,
   "data": {
      "competition_id": 1001
    },
  "msg": "删除成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": null,
  "msg":"竞赛信息删除失败"    
}
```

........其他错误
