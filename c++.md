#### `POST /api/selectContestList`

查询竞赛列表

##### 请求头

- `Content-Type`: `application/json`

##### 请求参数

- `userId`: `bigint`类型，用户ID（用于查询角色权限）
- `deptId`: `bigint`类型，部门ID（用于部门权限隔离）
- `dataScope`: `char`类型，数据权限标识符（1-5）1:全部数据权限,2:自定义数据权限,3:本部门数据权限,4:本部门及以下数据权限,5:仅本人数据权限

##### 查询数据字段

数据库ry-vue中achievements_competition的全部字段


##### 请求参数示例



```json
{
  "userId": 1,
  "deptId": 100,
  "dataScope": "1"
}
```

sql示例

```json
SELECT * FROM achievements_competition;  (dataScope = "1")

SELECT * FROM achievements_competition WHERE dept_id IN
(SELECT dept_id FROM sys_dept WHERE dept_id IN 
(SELECT dept_id FROM sys_role_dept WHERE role_id = 101));  					(dataScope = "2")

SELECT * FROM achievements_competition WHERE dept_id = deptId;  (dataScope = "3")

SELECT * FROM achievements_competition WHERE dept_id IN(SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(deptId, ancestors) > 0) OR deptId = 100; (dataScope = "4")

SELECT * FROM achievements_competition WHERE user_id = userId;(dataScope = "5")
```



##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的用户信息
- `msg`: `String`类型，提示信息

##### 响应结果示例



```json
{
  "code": 200,
  "data": [
    {
      "competition_id": 1001,
      "competition_name": "全国大学生程序设计大赛",
      "competition_level": "国家级",
      "competition_type": "算法编程类",
      "competition_time": "2024-10-15T09:00:00",
      "role_type": "指导老师",
      "award_level": "一等奖",
      "organizer": "教育部高等教育司",
      "audit_status": "待审核"
    },
    {
      "competition_id": 1002,
      "competition_name": "全国大学生java",
      "competition_level": "国家级",
      "competition_type": "算法编程",
      "competition_time": "2025-11-10T16:02:50",
      "role_type": "参赛者",
      "award_level": "三等奖",
      "organizer": "教育局",
      "audit_status": "待审核"
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
  "msg":"用户信息更新失败"    
}
```

........其他错误