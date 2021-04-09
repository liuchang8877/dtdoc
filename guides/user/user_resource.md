# 获取用户资源

## 获取用户基本信息

### 请求方式

```
请求URL：调用入口/api/open-auth/api/open/user/base
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:用户授权access_token
```

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "guid" : "1177499161797332994",
    "nickName" : "张三",
    "avatar" : "avatar/images/1.jpg",
    "customerCode" : "55",
    "customerName" : "河南大学",
    "merged" : true,
    "mergedGuid" : "1156120315407908866,1156120315407908867",
    "sex" : 1
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**guid**|用户全局唯一id|string|
|**nickName**|昵称|string|
|**avatar**|头像链接|string|
|**customerCode**|学校唯一标识|string|
|**customerName**|学校名称|string|
|**merged**|是否合并过 false 否 true 是|boolean|
|**mergedGuid**|曾用guid,以","间隔|string|
|**sex**|性别: 0 未知，1 男性，2 女性|string|

## 获取用户实名信息

### 请求方式

```
请求URL：调用入口/api/open-auth/api/open/user/rnuser
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:用户授权access_token
```

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK"
  "data" : {
    "guid" : "1177499161797332994",
    "nickName" : "张三",
    "avatar" : "avatar/images/1.jpg",
    "customerCode" : "55",
    "customerName" : "河南大学",
    "merged" : true,
    "mergedGuid" : "1156120315407908866,1156120315407908867",
    "sex" : 1,
    "userAuthInfo": {
      "mobileNo": "18595776620",
      "identityNo": "410101200701018839",
      "serialNo": "123456",
      "realName": "dt",
      "outid": "123456",
      "idType": 1,
      "ecardCustomerid": "11111",
      "deptInfo": [
        {
          "deptId": 12,
		  "customerCode":"3333",
          "deptName": "三年级一班"
		  "supervisor": true,
		  "position": "英语老师"
        }
      ],
      "relativeInfo": [
        {
          "customerCode": "55",
          "identityNo": "41001234567812345",
          "outid": "123456",
		  "ecardCustomerid": "22222",
          "realName": "比亚迪宋",
          "mobileNo": "18118101810",
          "serialNo": "123456",
          "relation": "S",
		  "deptInfo": [
			{
			  "deptId": 12,
			  "customerCode":"3333"
			  "deptName": "三年级一班"
			}
		  ]
        }
      ]
	  "roleInfo": [
        {
          "customerCode": "21635",
		  "customerName": "华东测试四",
          "outid": "123456",
		  "ecardCustomerid": "22222",
          "role": "1",
        }
      ]
    }
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**guid**|用户全局唯一id|string|
|**nickName**|昵称|string|
|**avatar**|头像链接|string|
|**customerCode**|学校唯一标识|string|
|**customerName**|学校名称|string|
|**sex**|性别: 0 未知，1 男性，2 女性|string|
|**merged**|是否合并过 false 否 true 是|boolean|
|**mergedGuid**|曾用guid,以","间隔|string|
|**userAuthInfo**|用户实名信息|json|
|**userAuthInfo.idType**|用户身份证件类型,1 居民身份证，A 护照|string|
|**userAuthInfo.identityNo**|身份证件号|string|
|**userAuthInfo.realName**|真实姓名|string|
|**userAuthInfo.mobileNo**|手机号|string|
|**userAuthInfo.outid**|一卡通编号|string|
|**userAuthInfo.serialNo**|学工号|string|
|**userAuthInfo.ecardCustomerid**|一卡通唯一号|string|
|**userAuthInfo.deptInfo**|用户组织机构信息|JSONArray|
|**userAuthInfo.deptInfo.deptId**|用户组织机构id|long|
|**userAuthInfo.deptInfo.deptName**|用户组织机构名称|string|
|**userAuthInfo.deptInfo.customerCode**|组织机构所属学校唯一标识|long|
|**userAuthInfo.deptInfo.supervisor**|是否该组织机构管理者|boolean|
|**userAuthInfo.deptInfo.position**|在该组织机构的职位|string|
|**userAuthInfo.relativeInfo**|用户亲属信息|JSONArray|
|**userAuthInfo.relativeInfo.customerCode**|亲属学校唯一标识|string|
|**userAuthInfo.relativeInfo.idType**|亲属身份证件类型|string|
|**userAuthInfo.relativeInfo.identityNo**|亲属身份证件号|string|
|**userAuthInfo.relativeInfo.outid**|亲属一卡通编号|string|
|**userAuthInfo.relativeInfo.realName**|亲属真实姓名|string|
|**userAuthInfo.relativeInfo.mobileNo**|亲属手机号|string|
|**userAuthInfo.relativeInfo.serialNo**|亲属学工号|string|
|**userAuthInfo.relativeInfo.relation**|关系(与当前用户的直系血亲关系，包含F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女)|string|
|**userAuthInfo.relativeInfo.deptInfo**|亲属组织机构信息|JSONArray|
|**userAuthInfo.relativeInfo.deptInfo.deptId**|亲属组织机构id|long|
|**userAuthInfo.relativeInfo.deptInfo.deptName**|亲属组织机构名称|string|
|**userAuthInfo.relativeInfo.deptInfo.customerCode**|组织机构所属学校唯一标识|string|
|**userAuthInfo.roleInfo**|用户角色信息|JSONArray|
|**userAuthInfo.roleInfo.customerCode**|用户在此角色下的学校唯一标识|string|
|**userAuthInfo.roleInfo.customerName**|用户在此角色下的学校名称|string|
|**userAuthInfo.roleInfo.outid**|用户在此角色下的学工号|string|
|**userAuthInfo.roleInfo.ecardCustomerid**|用户在此角色下的一卡通唯一号|string|
|**userAuthInfo.roleInfo.role**|用户角色：1 学生,2 教师,3 家长,4 后勤人员,5 临时人员|int|


## 修改登录密码（原登录密码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/password/update/oldpassword
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "old_password":"111111",
    "new_password":"123456",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **old_password**  <br>*必填* | 原密码                         | string |
| **new_password**  <br>*必填* | 新密码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 修改登录密码（短信验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/password/update/smscode
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "code":"985165",
    "password":"123456",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **code**  <br>*必填* | 短信验证码                         | string |
| **password**  <br>*必填* | 新密码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 修改登录密码（无条件）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/password/update
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "password":"111111",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **password**  <br>*必填* | 新密码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 验证密码

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/password/verify
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "password":"123456",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **password**  <br>*必填* | 新密码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 修改手机号（短信验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/update/mobileno
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "mobile_no":"18137371636",
    "code":"267540",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **mobile_no**  <br>*必填* | 手机号                         | string |
| **code**  <br>*必填* | 短信验证码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 切换用户主学校

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/update/customer
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "customer_code":"21635",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customer_code**  <br>*必填* | 要切换的学校的学校编码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```
<!--

## 移除用户主学校的一卡通信息（登录密码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/delete/ecard/password
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "password":"123456",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **password**  <br>*必填* | 登录密码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```
-->
<!--

## 移除用户主学校的一卡通信息（短信验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/delete/ecard/code
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "code":"267540",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **code**  <br>*必填* | 短信验证码                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```
-->

## 修改个人基本信息

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/update/basic
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
    "sex": 1,
    "nickname":"我最摇摆",
    "avatar":"20190805/7/08015FE84736443E9201BBB4B1ED636D.jpg",
    "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **sex**  <br>*非必填* | 性别: 0 未知，1 男性，2 女性                   | string |
| **nickname**  <br>*非必填* | 用户昵称                      | string |
| **avatar**  <br>*非必填* | 头像地址                         | string |
| **guid**  <br>*非必填*       | 用户全局唯一id，内部调用时必填 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 应用获取用户基本信息列表（无用户授权）

请注意，此接口权限较高，一般只对私有应用开放。

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/get/basic
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type: application/json
```

#### 请求样例

```
[
  "1270609807504752641",
  "1288053374923546626"
]
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **guid**  <br>*必填* | guid集合，一个或多个                  | JSONArray| |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": [
    {
      "guid": "1270609807504752641",
      "customerCode": "21635",
      "customerName": "华东测试四",
      "sex": 2,
      "nickName": "helloworld",
      "avatar": "userpic/view/6.jpg",
      "merged": null,
      "mergedGuid": "1270556326316163073,1270556790541729794,1270590066048315394,1270590136881721345"
    },
    {
      "guid": "1288053374923546626",
      "customerCode": null,
      "customerName": null,
      "sex": null,
      "nickName": "你好",
      "avatar": "20200729/14/43E3BFC1D565456EA3328691BE05351F.jpg",
      "merged": null,
      "mergedGuid": null
    }
  ]
}
```

## 获取用户标签

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/tag
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
```

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": {
        "alias": "1270609807504752641",
        "tags": [
            "customer_21635",
            "customerdept_104"
        ]
    }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**alias**|用户全局唯一id|string|
|**tags**|用户标签，学校标签格式为"customer_+customerCode";组织机构标签格式为："customerdept_+customerdeptId"|JSONArray|


## 移除指定学校的一卡通信息（短信验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/delete/ecard/code
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
```

#### 请求样例

```
{
  "code":"888888",
  "customerCode":"21635"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **code**  <br>*必填* | 短信验证码                  | string| |
| **customerCode**  <br>*必填* | 要移除一卡通信息的学校唯一编码                  | string| |



#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```


## 移除指定的亲属信息

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/delete/relative
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "customerCode":"21635",
  "serialNo":"123456"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customerCode**  <br>*必填* | 要移除亲属的学校唯一编码                  | string| |
| **serialNo**  <br>*必填* | 要移除的亲属的学工号                 | string| |



#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 获取用户特定角色相关信息

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/info/role
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "customerCode":"21635",
  "serialNo":"123456",
  "role":1,
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customerCode**  <br>*必填* | 学校唯一编码                  | string| |
| **serialNo**  <br>*必填* | 学工号                 | string| |
| **role**  <br>*必填* | 用户角色：1 学生,2 教师,3 家长,4 后勤人员,5 临时人员                  | int| |
| **guid**  <br>*非必填* | 用户唯一标识                 | string| |


#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {
    "guid": "1290609807504752642",
    "role": 2,
    "customerCode": "1001",
    "customerName": "郑州枫杨外国语学校",
    "ecardSchool": false,
    "dpcode": "00000000",
    "memberId": null,
    "serialNo": "150940",
    "ecardCustomerId": null,
    "deptInfo": [
      {
        "deptId": 228,
        "deptName": "2018级1班",
        "supervisor": false,
        "position": "语文老师",
        "customerCode": "1001",
        "ecardSchool": false
      }
    ],
    "relativeInfo": [
	  {
        "customerCode": "1001",
        "ecardSchool": false,
        "identityNo": null,
        "outid": "150941",
        "realName": "刘小宝",
        "mobileNo": null,
        "serialNo": "150941",
        "relation": "F",
        "ecardCustomerId": null,
        "childAvatar": null,
        "deptInfo": [
		  {
            "deptId": 229,
            "deptName": "2018级1班",
            "supervisor": false,
            "position": 学生,
            "customerCode": "1001",
            "ecardSchool": false
          }
		]
	  }
	]
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**guid**|用户全局唯一id|string|
|**role**|用户角色：1 学生,2 教师,3 家长,4 后勤人员,5 临时人员|int|
|**customerCode**|学校唯一标识|string|
|**customerName**|学校名称|string|
|**ecardSchool**|学校是否上线一卡通|boolean|
|**dpcode**|一卡通学校标识|string|
|**memberId**|当前角色对应的人员名单唯一标识|string|
|**serialNo**|学工号|string|
|**ecardCustomerId**|一卡通编号|string|
|**deptInfo**|用户组织机构信息|JSONArray|
|**deptInfo.deptId**|用户的组织机构id|int|
|**deptInfo.deptName**|组织机构名称|string|
|**deptInfo.supervisor**|真实姓名|boolean|
|**deptInfo.position**|职位|string|
|**deptInfo.customerCode**|学校唯一标识|string|
|**deptInfo.ecardSchool**|该组织机构对应的学校学校是否上线一卡通|boolean|
|**relativeInfo**|用户亲属信息|JSONArray|
|**relativeInfo.customerCode**|亲属的学校唯一标识|string|
|**relativeInfo.ecardSchool**|亲属的学校是否上线一卡通|boolean|
|**relativeInfo.identityNo**|亲属的身份证号|string|
|**relativeInfo.outid**|亲属的学工号|string|
|**relativeInfo.realName**|亲属的真实姓名|string|
|**relativeInfo.mobileNo**|亲属的手机号|string|
|**relativeInfo.serialNo**|亲属的学工号|string|
|**relativeInfo.relation**|当前用户与亲属的关系(F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女)|string|
|**relativeInfo.ecardCustomerId**|亲属的一卡通编号|string|
|**relativeInfo.childAvatar**|亲属的用户头像|string|
|**relativeInfo.deptInfo**|亲属的部门信息|JSONArray|
|**relativeInfo.deptInfo.deptId**|亲属的组织机构id|int|
|**relativeInfo.deptInfo.deptName**|亲属的组织机构名称|string|
|**relativeInfo.deptInfo.supervisor**|亲属是否是该组织机构的管理者|boolean|
|**relativeInfo.deptInfo.position**|亲属的组织机构职位|string|
|**relativeInfo.deptInfo.customerCode**|亲属组织机构所在学校的唯一标识|string|
|**relativeInfo.deptInfo.ecardSchool**|亲属组织机构对应的学校是否上线一卡通|boolean|



若信息有误则会返回下述JSON格式数据：

```
{
    "code": 400,
    "message": "错误提示信息",
    "data": null
}
```

## 用户注销

用户注销后，将清除所有已认证的信息，请谨慎使用。

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/logoff
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **guid**  <br>*非必填* | 用户唯一标识                 | string| |

#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {}
}
```


# 用户扩展信息


用户扩展信息基于"Key、value"理念开发，一个key只能对应唯一的一个值，多次提交会相互覆盖，value的内容和格式由数据提交方自行管理。

目前对于key的存在限制，即不是任意key均能使用，需要向DTOP申请后方能使用。

注意：key区分大小写，"key"、"value"均为String类型。

目前支持的key有：

| key                         | 说明                           |  类型  |
| ---------------------------- | ------------------------------ | ------ |
| **tradeNoticeEnable**| 是否允许交易通知                  | string| |
| **appNoticeEnable**| 是否允许应用通知                 | string| |



## 提交GUID对应的用户的扩展信息



#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/ext/set
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "key":"tradeNoticeEnable",
  "value":"false",
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*必填* | 键                  | string| |
| **value**  <br>*必填* | 要提交的key对应的值                 | string| |
| **guid**  <br>*非必填* | 用户唯一标识                 | string| |


#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {}
}
```

若key有误或未经批准则会返回下述JSON格式数据：

```
{
    "code": 400,
    "message": "请求的扩展信息包含不正确的类型",
    "data": null
}
```

## 获取GUID对应的用户的特定扩展信息



#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/ext/get
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "key":"tradeNoticeEnable",
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*必填* | 键                  | string| |
| **guid**  <br>*非必填* | 用户唯一标识                 | string| |


#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {
	"tradeNoticeEnable": "false"
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|内包含以"key"为键,"value"为"key"对应的值的数据|json|


若key有误或未经批准则会返回下述JSON格式数据：

```
{
    "code": 400,
    "message": "请求的扩展信息包含不正确的类型",
    "data": null
}
```

## 获取GUID对应的用户的扩展信息列表



#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/ext/get/list
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "key":["appNoticeEnable","tradeNoticeEnable"],
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*非必填* | 键数组，不传则为获取全部                  | JSONArray|| |
| **guid**  <br>*非必填* | 用户唯一标识                | string| |


#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {
	"tradeNoticeEnable": "false",
	"appNoticeEnable": "false"
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|内包含以"key"为键,"value"为"key"对应的值的数据|json|

若key有误或未经批准则会返回下述JSON格式数据：

```
{
    "code": 400,
    "message": "请求的扩展信息包含不正确的类型",
    "data": null
}
```


## 删除GUID对应的用户的特定扩展信息

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/ext/delete
请求方法：POST
Request Headers：
    x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```

#### 请求样例

```
{
  "key":"tradeNoticeEnable",
  "guid":"1270609807504752641"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*必填* | 键                  | string| |
| **guid**  <br>*非必填* | 用户唯一标识                 | string| |


#### 响应样例

正常情况下，若验证通过会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {}
}
```

若key有误或未经批准则会返回下述JSON格式数据：

```
{
    "code": 400,
    "message": "请求的扩展信息包含不正确的类型",
    "data": null
}
```

