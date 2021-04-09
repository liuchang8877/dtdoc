# 客户相关

## 检索客户是否存在接口(手机号)

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/member/exsit/mobileNo
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "mobileNo":"18100000000"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **mobileNo**  <br>*必填* | 手机号                         | string |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "existed" : true
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**existed**|是否存在|boolean|


## 检索客户是否存在接口(实名信息)

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/member/exsit/realNameInfo
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "realName":"张三",
    "idType":"1",
	"identityNo":"110101199003074231",
	"memberId":"G110101199003074231"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **realName**  <br>*非必填* | 真实姓名                         | string |
| **idType**  <br>*非必填*       | 身份证件类型，通过字典表接口的获取身份证件类型 | string |
| **identityNo**  <br>*非必填*       | 身份证件号 | string |
| **memberId**  <br>*非必填*       | 客户唯一标识 | string |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "existed" : true
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**existed**|是否存在|boolean|


## 检索客户是否存在接口(学工号等唯一序列号)

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/member/exsit/serialNo
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type: application/json
```

#### 请求样例

```
{
	"customerCode":"21635",
	"serialNo":"10086"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customerCode**  <br>*必填*       | 学校唯一标识 | string |
| **serialNo**  <br>*必填*       | 学工号等唯一序列号 | string |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "existed" : true
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**existed**|是否存在|boolean|

## 获取客户对应用户的信息(客户唯一标识)

一期V8调用时rnAuth>0即为已认证

V8调试请在DT的t2环境调试，具体联系王炳勋

V8在t2联调时请求URL：http://ucenter-service-provider.default:8092/api/member/info

厦大项目生产和测试环境，具体url将default替换为v8的命名空间即可

Request Header中不需要x-deepcloud-from:client，Authorization:应用access_token这两部分

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/member/info
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "memberId":"G110101199003074231"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **memberId**  <br>*必填* | 客户唯一标识                         | string |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "rnAuth" : 4
	"unionPayEnable" : true 
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**rnAuth**|该客户唯一编号对应的用户的实名认证状态：0 未认证，1 已手机号实名，2 已银行卡实名，3 已人脸实名 4 已银行卡+人脸实名;  | int |
|**unionPayEnable**|是否开启云闪付App付款|boolean|


## 以组织机构id获取客户名单数据

支持角色维度

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/member/deptid
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
例如想要请求某组织机构下所有的角色为教师的人员名单信息
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/member/deptid?dept_id=339&role=2
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **dept_id**  <br>*必填* | 组织机构id                   | int |
| **role**  <br>*非必填* | 角色：1 学生，2 教师，3 家长，4 后勤人员，5 临时人员                      | int |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": [
    {
      "identityNo": "411152200000002",
      "mobileNo": "15617653245",
      "outid": "350002",
      "role": 2,
      "realName": "三五二",
      "customerCode": "21635",
      "customerName": "华东测试四",
      "memberId": null,
      "avatar": null,
      "deptInfo": {
        "deptId": 339,
        "deptName": "2018级一班",
        "supervisor": true,
        "position": "英语老师"
      },
      "relativeInfo": []
    },
    {
      "identityNo": "411522199309036000",
      "mobileNo": null,
      "outid": "350003",
      "role": 2,
      "realName": "三五三",
      "customerCode": "21635",
      "customerName": "华东测试四",
      "memberId": null,
      "avatar": null,
      "deptInfo": {
        "deptId": 339,
        "deptName": "2018级一班",
        "supervisor": true,
        "position": "思政老师"
      },
      "relativeInfo": []
    }
  ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|人员名单信息|JSONARRAY|
|****|下为人员名单信息|JSON|
|**identityNo**|身份证号|string|
|**mobileNo**|手机号|string|
|**outid**|学工号/一卡通卡号|string|
|**role**|角色：1 学生，2 教师，3 家长，4 后勤人员，5 临时人员|int|
|**realName**|真实姓名|string|
|**customerCode**|学校的唯一标识|string|
|**customerName**|学校名称|string|
|**memberId**|人员名单唯一标识|string|
|**avatar**|人员名单对应用户的头像地址|string|
|**deptInfo**|组织机构信息|JSON|
|**deptInfo.deptId**|组织机构id |long|
|**deptInfo.deptName**|组织机构名称|string|
|**deptInfo.supervisor**|是否管理员|boolean|
|**deptInfo.position**|职位|string|
|**relativeInfo**|亲属信息|JSON|
|**relativeInfo.realName**|亲属真实姓名|string|
|**relativeInfo.mobileNo**|亲属手机号码|string|
|**relativeInfo.identityNo**|亲属身份证号|string|
|**relativeInfo.relation**|关系(与当前人员的直系血亲关系，包含F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女)|string|


## 以组织机构id集合获取客户名单数据

支持角色维度，会查询组织机构的所有子机构

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/member/dept
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
例如想要请求某组织机构下所有的角色为学生的人员名单信息
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/member/dept?dept_id=339&dept_id=338&role=1
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **dept_id**  <br>*必填* | 组织机构id                   | int[] |
| **role**  <br>*非必填* | 角色：1 学生，2 教师，3 家长，4 后勤人员，5 临时人员                      | int |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": [
    {
      "identityNo": "410182199300000004",
      "mobileNo": null,
      "outid": "350004",
      "role": 1,
      "realName": "三五四",
      "customerCode": "21635",
      "customerName": "华东测试四",
      "memberId": null,
      "avatar": null,
      "deptInfo": [
        {
          "deptId": 339,
          "deptName": "2018级一班",
          "supervisor": false,
          "position": null
        }
      ],
      "relativeInfo": [
        {
          "realName": "三五四爸爸",
          "mobileNo": "156901111171",
          "identityNo": null,
          "relation": "F"
        },
        {
          "realName": "三五四妈妈",
          "mobileNo": "15690000071",
          "identityNo": null,
          "relation": "M"
        },
        {
          "realName": "三五四祖父",
          "mobileNo": "15697777771",
          "identityNo": null,
          "relation": "GF"
        }
      ]
    },
    {
      "identityNo": "411522199909096099",
      "mobileNo": null,
      "outid": "350001",
      "role": 1,
      "realName": "三五一",
      "customerCode": "21635",
      "customerName": "华东测试四",
      "memberId": null,
      "avatar": null,
      "deptInfo": [
        {
          "deptId": 339,
          "deptName": "2018级一班",
          "supervisor": false,
          "position": null
        }
      ],
      "relativeInfo": [
        {
          "realName": "三五一外祖父",
          "mobileNo": 13911111111,
          "identityNo": null,
          "relation": "MGF"
        }
      ]
    }
  ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|人员名单信息|JSONARRAY|
|****|下为人员名单信息|JSON|
|**identityNo**|身份证号|string|
|**mobileNo**|手机号|string|
|**outid**|学工号/一卡通卡号|string|
|**role**|角色：1 学生，2 教师，3 家长，4 后勤人员，5 临时人员|int|
|**realName**|真实姓名|string|
|**customerCode**|学校的唯一标识|string|
|**customerName**|学校名称|string|
|**memberId**|人员名单唯一标识|string|
|**avatar**|人员名单对应用户的头像地址|string|
|**deptInfo**|组织机构信息|JSON|
|**deptInfo.deptId**|组织机构id |long|
|**deptInfo.deptName**|组织机构名称|string|
|**deptInfo.supervisor**|是否管理员|boolean|
|**deptInfo.position**|职位|string|
|**relativeInfo**|亲属信息|JSON|
|**relativeInfo.realName**|亲属真实姓名|string|
|**relativeInfo.mobileNo**|亲属手机号码|string|
|**relativeInfo.identityNo**|亲属身份证号|string|
|**relativeInfo.relation**|关系(与当前人员的直系血亲关系，包含F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女)|string|

