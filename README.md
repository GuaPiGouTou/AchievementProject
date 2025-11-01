# AchievementProject
师生成果管理项目

### 连接测试

25-10-26-15:33

25-10-26-16:44




### 技术选型

1.后端：c++

2.前端：Vue + 组件

2.数据库：MySQL 8



### 开发时间线

2025-10-26 -2025-10.31 任务要求

1.完成对项目的需求分析，列出各区域，各模块，各功能，包含数据类型，限制条件的分析文档（md文档）

2.数据库完成学生，教师信息表设计

3.前端完成登录界面，注册界面，默认密码修改界面，个人信息展示界面，个人信息修改界面 

4.后端完成前端对应的接口，登录接口，注册接口，默认密码修改接口，个人信息获取接口，个人信息展示接口

5.完成前端功能测试

6.完成后端单元测试

7.前后端联调完成部署

8.对系统进行压力测试

以上所有和项目有关的文件都在GitHub仓库中进行

GitHub仓库地址：

SSH : git@github.com:GuaPiGouTou/AchievementProject.git

HTTPS：https://github.com/GuaPiGouTou/AchievementProject.git

### 服务 API 文档

内网服务器地址：http://172.16.46.77:9095

#### `GET /api/getCodeUrl`

获取随机验证码URl

##### 请求参数

无

##### 响应结果

- `code`：`number`类型，错误码
- `data`：`String`类型，验证码URL
- `msg`  :   `String`类型，提示信息

##### 响应结果示例

请求成功结果

```json
{
  "code": 200,
  "data": "http://172.16.46.77/static/img/36.png",
  "msg":"获取成功"    
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"静态资源不存在"    
}
```

........其他错误

#### `POST /api/verifyCodeUrl`

提交验证码和验证图片URL

##### 请求参数

- `correct_verification_code`：`String` 类型，验证码
- `verification_code_ip`：`String` 类型，URL

##### **请求参数示例**

```json
{
  "correct_verification_code": "3T6Y",
  "verification_code_ip":"http://172.16.46.77/static/img/36.png"
}
```

##### 响应结果

- `code`：`number`类型，错误码
- `data`：`Boolean`类型，结果
- `msg`  :   `String`类型，提示信息

##### 响应结果示例

请求成功结果

```json
{
  "code": 200,
  "data": true,
   "msg": "验证成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": false,
   "msg": "验证码错误"
}
```

..........

#### `POST /api/login`

提交账号密码进行登录，成功返回用户token

##### 请求参数

- `student_no`：`String` 类型，学号
- `password`：`String` 类型，密码
- `isTeacherIdentity`:`Boolean`类型，默认学生身份，选择为老师身份

##### 请求参数示例

```json
{
  "uaername": '24306010535',
  "password":"123456",
  "isTeacherIdentity":false
}
```

##### 响应结果

- `code`：`number`类型, 错误码
- `data`：`Json`;类型，token,initial(初始账号标识)
- `msg`   :  `String`类型，提示信息

##### 响应结果示例

请求成功结果

```json
{
  "code": 200,
  "data": {
      token:"asdasdafdvdf69df*5612313",
      initial:1//是否第一次登录1/0
  },
   "msg": "登录成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": null,
   "msg": "登录失败用户名不存在"
}
```

..........其他错误

#### `POST /api/updatePassword`

修改用户密码

##### 请求头

- `Authorization`:` token`
- `Content-Type`: `application/json`

##### 请求参数

- `student_no`：`String` 类型，学号
- `password`：`String` 类型，旧密码
- `newpassword`：`String` 类型，新密码
- `isTeacherIdentity`:`Boolean`类型，默认学生身份，选择为老师身份

##### 请求参数示例

```json
{
  "username": '24306010535',
  "password":"123456",
  "newpassword":"password123456",
  "isTeacherIdentity":false
}
```

##### 响应结果

- `code`：`number`类型,错误码
- `data`：`Boolean`类型，结果
- `msg`:`String`类型，提示信息

##### 响应结果示例

请求成功结果

```json
{
  "code": 200,
  "data": true,
   "msg": "修改成功"
}
```

请求失败结果

```json
{
  "code": 501,
  "data": false,
   "msg": "登录失败用户名不存在"
}
```

..........其他错误

#### `GET/api/getUserInfo`

获取用户信息

##### 请求头

- `Authorization`:` token`
- `Content-Type`: `application/json`

##### 请求参数

- `username`：`String` 类型，账号
- `isTeacherIdentity`:`Boolean`类型，默认学生身份，选择为老师身份

##### 请求参数示例

```json
{
  "username": 'L15525',
  "isTeacherIdentity":true
}
```

##### 响应结果

- `code`：`number`类型,错误码
- `data`：`Json`类型，用户信息
- `msg`:`String`类型，提示信息

##### 响应结果示例

请求成功结果：学生

```json
{
  "code": 200,
  "data": {
"student_no": "2023001001",
"name": "张三",
"gender": "男",
"grade": "2023级",
"department": "计算机学院",
"major": "软件工程",
"phone": "13800138000",
"email": "zhangsan@example.com",
"id_card": "110101200001011234",
"avatar": "/example/avatars/student1.jpg",
"birth_date": "2000-01-01",
"enrollment_date": "2023-09-01",
"address": "北京市海淀区中关村大街1号",
"student_status": "在读",
"semester": 3,
"class": "软件工程2301班",
"created_at": "2023-09-01T08:00:00Z",
"updated_at": "2024-06-15T14:30:00Z"
},
   "msg": "获取成功"
}
```

请求成功结果：学生

```json
{
  "code": 200,
  "data": {
"teacher_no": "T2023001",
"name": "张老师",
"gender": "男",
"title": "副教授",
"department": "计算机科学与技术学院",
"research_direction": "人工智能、机器学习、数据挖掘",
"phone": "010-12345678",
"mobile": "13800138000",
"email": "zhang@university.edu.cn",
"office_location": "计算机学院楼301室",
"id_card": "110101198001011234",
"avatar": "/uploads/avatars/teacher_001.jpg",
"birth_date": "1980-01-01",
"hire_date": "2010-08-15",
"education_background": "2009-2013 中国科学院 计算机软件与理论 博士",
"work_experience": "2013-至今 某大学计算机学院 副教授",
"academic_achievements": "发表SCI/EI论文20余篇",
"created_at": "2010-08-15T09:00:00Z",
"updated_at": "2024-06-15T14:30:00Z"
},
   "msg": "获取成功"
}
```



请求失败结果

```json
{
  "code": 501,
  "data": null,
   "msg": " 获取失败用户名不存在"
}
```

..........其他错误

#### `GET /api/publickey`

获取RSA公钥

##### 请求参数

无

##### 响应结果

- `code`：`number`类型，错误码
- `data`：`String`类型，公钥
- `msg`  :   `String`类型，提示信息

##### 响应结果示例

请求成功结果

```json
{
  "code": 200,
  "data": "-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1yxvpIsbuwKBoYRze0R7
iCKZSAq87Qt/sGN81CerFBvyfWvnvV+fu/Ugm0VzXY+7yTsQxG3ijQdoizw7CLJI
SXw+BCUCrM7ret94xgARXr65l68TxnVw1yzJbez/k5Vl04t0Baj56iSlnQGKPzBX
L+9+lAMkIzW5SYl5uKNaCVkqsw00l4wM6op+7uaneLVhInBVrjn+f57HVmJK3jHx
BPisM9MDn1QbUYeABbVmS4zXCTTyN6SJgmqw0gTiKobTgiKKjZM5enPTmgJQit4f
WKm6FxcKYUj2QGR68JQegG4Y1XZCPWanhXury9FvRO72/NwNrjQaoIsOTPsWmV0D
jwIDAQAB
-----END PUBLIC KEY-----",
  "msg":"获取成功"    
}
```

请求失败结果

```json
{
  "code": 501,
  "data": "",
  "msg":"公钥获取失败"    
}
```

........其他错误

#### `POST /api/updateUserInfo`

统一修改用户信息，支持学生和老师两种身份

##### 请求头

- `Authorization`: `Bearer token`
- `Content-Type`: `application/json`

##### 请求参数

- `username`: `String`类型，用户名（用于验证身份）
- `isTeacherIdentity`: `Boolean`类型，身份标识
- `updateData`: `Object`类型，更新数据（根据身份动态验证）

##### 更新数据字段（updateData）

**通用字段**

- `name`: `String`类型，姓名
- `phone`: `String`类型，手机号
- `email`: `String`类型，邮箱
- `avatar`: `String`类型，头像URL
- `address`: `String`类型，地址（老师对应`office_location`）

**学生特有字段**

- `grade`: `String`类型，年级
- `department`: `String`类型，学院
- `major`: `String`类型，专业
- `class`: `String`类型，班级
- `student_status`: `String`类型，学籍状态

**老师特有字段**

- `title`: `String`类型，职称
- `department`: `String`类型，学院
- `research_direction`: `String`类型，研究方向
- `office_location`: `String`类型，办公室位置
- `mobile`: `String`类型，手机号

##### 请求参数示例

学生示例

```json
{
  "username": "2023001001",
  "isTeacherIdentity": false,
  "updateData": {
    "name": "张三",
    "phone": "13800138000",
    "email": "zhangsan@example.com",
    "grade": "2023级",
    "class": "软件工程2301班"
  }
}
```

老师示例

```json
{
  "username": "T2023001",
  "isTeacherIdentity": true,
  "updateData": {
    "name": "张老师",
    "email": "zhang@university.edu.cn",
    "title": "副教授",
    "research_direction": "人工智能、机器学习"
  }
}
```



##### 响应结果

- `code`: `number`类型，状态码
- `data`: `Object`类型，更新后的用户信息
- `msg`: `String`类型，提示信息

##### 响应结果示例

学生结果

```json
{
  "code": 200,
  "data": {
    "student_no": "2023001001",
    "name": "张三",
    "phone": "13800138000",
    "email": "zhangsan@example.com",
    "grade": "2023级",
    "class": "软件工程2301班",
    "updated_at": "2024-06-15T15:30:00Z"
  },
  "msg": "学生信息更新成功"
}
```

老师结果

```json
{
  "code": 200,
  "data": {
    "teacher_no": "T2023001",
    "name": "张老师",
    "email": "zhang@university.edu.cn",
    "title": "副教授",
    "research_direction": "人工智能、机器学习",
    "updated_at": "2024-06-15T15:30:00Z"
  },
  "msg": "教师信息更新成功"
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

### 需求分析日志



### 前端日志

#### 2025-10-27 0:00

1.对登录页面进行美化，输入框进行条件限制

2.加入默认页路由

#### 2025-10-29 12:48

1.创建Axios工具类

2.创建api工具类

3.创建RSA加密工具类

4.·登录界面加入老师选项

5.登录逻辑使用api工具类完成内聚解耦

6.登录密码实现RSA公钥加密

### 2025-10-29 22：18

1.完成修改密码界面

2.主页跳转修改密码界面

3.退出登录功能

### 后端日志
#### 2025-11-1 16:52

1.将五个接口完成，并且完成相应的功能

2.实现RSA公钥接口创建以及用私钥解密

3.Token登录发送前端,以及比对Token和用户,Token具有有效时间.

4.验证码的第一个字的边界Bug已修改

### 数据库日志
MySQL7.0 字符集：utf8mb4 -- UTF-8 Unicode 整理：utf8mb4_0900_ai_ci

2025-10-26 18:14

1.完成学生、老师的信息表和账号表

2025-10-27 21:17
<<<<<<< HEAD
2.完成输入导入、角色表和验证码表

2025-11-01 18：14

3.完成成果表
	
=======
2.完成输入导入和角色表
	

# 常见错误代码参考表

## 网络连接错误

| 错误代码 | 说明       | 常见原因                     | 解决方法                   |
| -------- | ---------- | ---------------------------- | -------------------------- |
| 10061    | 连接被拒绝 | 目标服务器未运行或防火墙阻止 | 检查服务状态和防火墙设置   |
| 10060    | 连接超时   | 网络延迟或服务器无响应       | 检查网络连接和服务器状态   |
| 10054    | 连接被重置 | 对方主动关闭连接             | 检查服务器日志和配置       |
| 10013    | 权限被拒绝 | 无权限访问端口               | 以管理员身份运行或更改端口 |

## HTTP 状态码

### 4xx 客户端错误
| 状态码 | 说明            | 常见原因       |
| ------ | --------------- | -------------- |
| 400    | Bad Request     | 请求语法错误   |
| 401    | Unauthorized    | 需要身份验证   |
| 403    | Forbidden       | 服务器拒绝请求 |
| 404    | Not Found       | 资源不存在     |
| 408    | Request Timeout | 请求超时       |

### 5xx 服务器错误
| 状态码 | 说明                  | 常见原因       |
| ------ | --------------------- | -------------- |
| 500    | Internal Server Error | 服务器内部错误 |
| 502    | Bad Gateway           | 网关错误       |
| 503    | Service Unavailable   | 服务不可用     |
| 504    | Gateway Timeout       | 网关超时       |

## 数据库错误

### MySQL
| 错误代码 | 说明                   | 解决方法           |
| -------- | ---------------------- | ------------------ |
| 1045     | 访问被拒绝             | 检查用户名和密码   |
| 1049     | 未知数据库             | 确认数据库是否存在 |
| 1064     | SQL语法错误            | 检查SQL语句        |
| 2002     | 连接失败               | 检查MySQL服务状态  |
| 2003     | 无法连接到数据库服务器 | 检查网络和防火墙   |

### SQL Server
| 错误代码 | 说明           | 解决方法           |
| -------- | -------------- | ------------------ |
| 18456    | 登录失败       | 检查身份验证模式   |
| 4060     | 无法打开数据库 | 检查数据库状态     |
| 233      | 连接失败       | 检查SQL Server配置 |

## 系统错误 (Windows)

| 错误代码 | 说明         | 解决方法         |
| -------- | ------------ | ---------------- |
| 5        | 访问被拒绝   | 以管理员身份运行 |
| 2        | 文件未找到   | 检查文件路径     |
| 13       | 权限被拒绝   | 检查文件权限     |
| 267      | 目录名称无效 | 检查目录路径     |

## 编程语言常见错误

### JavaScript
| 错误类型       | 说明     | 常见场景           |
| -------------- | -------- | ------------------ |
| TypeError      | 类型错误 | 未定义变量调用方法 |
| ReferenceError | 引用错误 | 访问未定义变量     |
| SyntaxError    | 语法错误 | 代码语法错误       |

### Python
| 异常类型    | 说明     | 常见场景     |
| ----------- | -------- | ------------ |
| SyntaxError | 语法错误 | 代码语法错误 |
| NameError   | 名称错误 | 未定义变量   |
| IndexError  | 索引错误 | 列表索引越界 |
| KeyError    | 键错误   | 字典键不存在 |

## 文件系统错误

| 错误代码 | 说明       | 解决方法       |
| -------- | ---------- | -------------- |
| 32       | 文件被占用 | 关闭占用程序   |
| 80       | 文件已存在 | 重命名或删除   |
| 123      | 文件名无效 | 检查文件名规范 |
| 183      | 文件已存在 | 选择不同名称   |

---

*本表格仅供参考，具体问题需要结合实际情况分析。*

>>>>>>> 
