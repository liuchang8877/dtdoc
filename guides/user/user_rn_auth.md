# 实名认证

## 实名认证接口

实名认证的本意是为应用与服务采集必要的、可信的用户信息，使之能够在进入应用之前就获取到完成应用流程所需的必要数据。


| 认证标识           | 说明                                  |可获得实名信息|
| -------------------- | ------------------------------------- |-----------|
| <a href="#/guides/user/user_rn_auth?id=导入信息认证">IMPORT</a> | 导入信息认证 |身份证号、真实姓名等已导入的实名信息|
| <a href="#/guides/user/user_rn_auth?id=一卡通认证">ECARD</a> | 一卡通认证 |一卡通outid、真实姓名|
| <a href="#/guides/user/user_rn_auth?id=手机号验证码认证">MOBILE</a> | 手机号验证码认证 |当前用户使用的手机号|
| <a href="#/guides/user/user_rn_auth?id=白名单认证">IMPORT-ECARD</a> | 白名单认证 |身份证号、真实姓名等已导入的实名信息|
| <a href="#/guides/user/user_rn_auth?id=亲子关系认证">RELATION</a> | 亲子关系认证 |实名信息，亲子关系| 
| <a href="#/guides/user/user_rn_auth?id=用户合并认证">MEGRE</a> | 用户合并认证 |进行上述实名认证时，返回code=409时触发,合并成功后新用户继承原用户认证过的全部实名信息，原用户实名信息全部移除。 <br> <B>注意：该过程一旦完成，不可逆。</B>|
| <a href="#/guides/user/user_rn_auth?id=银联开放平台人脸认证">UNIONPAY-FACE</a> | 银联开放平台人脸认证 | 身份证件号对应证件照与活体识别人脸截图的对比结果和认证凭据|
| <a href="#/guides/user/user_rn_auth?id=微信人脸认证">WECHAT-FACE</a> | 微信人脸认证 |微信人脸认证结果和认证凭据|

后续还会根据需求开发更多的认证方式。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/rnauth
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:用户授权access_token
	Content-Type: application/json
```
### 请求样例

```
{
	"rnAuthPatternCode":"ECARD",
	"guid":"1238365130127781890",
	"data":{
		"outid":"350002",
		"password":"123456",
		"name":"三五二"
	}	
}
```
### 请求参数

#### 导入信息认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "IMPORT"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id，过网关调用不传，服务间调用必传 | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.name** <br>*必填* | 真实姓名 | string          |
| **data.identityNo** <br>*必填* | 身份证号 | string |
| **data.outid** <br>*必填* | 学工号 | string |
| **data.customerCode** <br>*非必填* | 学校唯一编号 | string |
| **data.role** <br>*非必填* | 认证期望角色：1 学生 2 教师 4 后勤人员 5 临时人员，若传此参数则会对比人员名单信息中的角色是否一致，不传不校验 | int |

#### 手机号验证码认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "MOBILE"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.mobileNo** <br>*必填* | 手机号 | string          |
| **data.code** <br>*必填* | 验证码 | string |

#### 一卡通认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "ECARD"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.outid** <br>*必填* | 学工号/一卡通卡号 | string          |
| **data.name** <br>*必填* | 真实姓名 | string |
| **data.password** <br>*必填* | 一卡通消费密码 | string |
| **data.customerCode** <br>*非必填* | 学校唯一编号 | string |

#### 白名单认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "IMPORT-ECARD"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.outid** <br>*必填* | 学工号/一卡通卡号 | string          |
| **data.name** <br>*必填* | 真实姓名 | string |
| **data.password** <br>*非必填* | 该学校上线了一卡通则必填 | string |
| **data.customerCode** <br>*非必填* | 学校唯一编号 | string |
| **data.role** <br>*非必填* | 认证期望角色，1:学生 2:教师 4:后勤人员 5:临时人员，若传此参数则会对比人员名单信息中的角色是否一致，不传不校验 | int |

#### 亲子关系认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "RELATION"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.name** <br>*必填* | 用户真实姓名 | string |
| **data.relation** <br>*必填* |亲属关系 （一般为当前用户与亲属的直系血亲关系，包含F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女） | string |
| **data.identityNo** <br>*非必填* |身份证号 | string |
| **data.outid** <br>*必填* | 亲属的学工号/一卡通卡号 | string          |
| **data.childName** <br>*必填* | 亲属真实姓名 | string |
| **data.customerCode** <br>*非必填* | 亲属学校唯一编号 | string |
| **data.type** <br>*必填* | 认证途径，1:一卡通方式实名信息认证；2:导入方式实名信息认证 | int |
| **data.password** <br>*非必填* |亲属的一卡通密码，data.type=1 必填 | string |

#### 用户合并认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "MERGE"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.code** <br>*必填* | 短信验证码 | string          |
| **data.oldGuid** <br>*必填* | 已认证过该实名信息的用户的guid | string |
| **data.authInfo** <br>*必填* | 触发合并认证时的实名认证信息，请原封不动的将上次时用户输入的信息上报 | json |

#### 银联开放平台人脸认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "UNIONPAY-FACE"--固定值 | string          |
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.token** <br>*必填* | 云闪付银联可信数字身份核验平台token | string|
| **data.sign** <br>*必填* | 签名信息 | string |
| **data.ts** <br>*必填* | 时间戳 | long |
| **data.action** <br>*必填* | 交易类型 | string |
| **data.txnTime** <br>*必填* | 交易请求时间	 | string |
| **data.txnSrc** <br>*必填* | 交易来源	 | string |
| **data.orgCode** <br>*必填* | 应用方代码		 | string |
| **data.orgSeq** <br>*必填* | 应用方请求流水号		 | string |
| **data.comUserId** <br>*必填* | 外部数据使用方代码	 | string |
| **data.authCode** <br>*必填* | 认证模式代码	 | string |
| **data.sceneCode** <br>*必填* | 交易场景代码		 | string |
| **data.protocoVerison** <br>*必填* | 用户电子协议版本号	 | string |
| **data.authSeq** <br>*必填* | 用户授权流水号		 | string |
| **data.name** <br>*必填* | 姓名	 | string |
| **data.certType** <br>*必填* | 身份证件类型	 | string |
| **data.certCode** <br>*必填* | 证件号	 | string |
| **data.faceImage** <br>*必填* | 人像图片	 | string |
| <B>注意：此接口及对接流程仍待与银联确认。</B> | 	 | string |

#### 微信人脸认证

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **rnAuthPatternCode** <br>*必填* | "WECHAT-FACE"--固定值 | string|
| **guid** <br>*非必填* | 用户唯一id | string |
| **data** <br>*必填* | 实名认证数据 | json |
| **data.accessToken** <br>*必填* | 微信应用（小程序、公众号等）access_token | string|
| **data.verifyResult** <br>*必填* | 微信人脸认证查询凭据 | string|
| **data.realName** <br>*必填* | 真实姓名 | string |
| **data.identityNo** <br>*必填* | 身份证号 | string |
| **data.deviceId** <br>*必填* | 设备号 | string |



### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": {
    "guid": "1290609807504752642",
	"rnAuthTicket": "T_YYYYMMXXXX",
	"deviceId": "DYYYMMXXXX",
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
|**rnAuthTicket**|实名认证凭据，依次凭据可查询该次认证结果|string|
|**deviceId**|该次认证设备编号|String|
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
|**relativeInfo.relation**|亲属关系 （一般为当前用户与亲属的直系血亲关系，包含F-父亲、M-母亲、S-儿子、D-女儿、GF-祖父、GM-祖母、MGF-外祖父、MGM-外祖母、GS-孙子、GD-孙女、MGS-外孙、MGD-外孙女）|string|
|**relativeInfo.ecardCustomerId**|亲属的一卡通编号|string|
|**relativeInfo.childAvatar**|亲属的用户头像|string|
|**relativeInfo.deptInfo**|亲属的部门信息|JSONArray|
|**relativeInfo.deptInfo.deptId**|亲属的组织机构id|int|
|**relativeInfo.deptInfo.deptName**|亲属的组织机构名称|string|
|**relativeInfo.deptInfo.supervisor**|亲属是否是该组织机构的管理者|boolean|
|**relativeInfo.deptInfo.position**|亲属的组织机构职位|string|
|**relativeInfo.deptInfo.customerCode**|亲属组织机构所在学校的唯一标识|string|
|**relativeInfo.deptInfo.ecardSchool**|亲属组织机构对应的学校是否上线一卡通|boolean|

出现信息被占用 ，开启合并返回

```
{
  "code" : 409,
  "message" : "当前认证信息已被 mobileNo 占用",
  "data" : {
	"mobileNo": "180******11",
	"guid": "11111111111111111111"
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**mobileNo**|脱敏过的已认证过该认证信息的用户的手机号|string|
|**guid**|系统中已认证过该认证信息的用户的guid|string|

系统未开启合并或已认证过该信息的用户没有登记手机号时，返回

```
{
  "code" : 410,
  "message" : "当前认证信息已被（mobileNo）占用，请联系人工客服",
  "data":{}
}
```
## 实名认证结果查询接口

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/user/rnauth/result
请求方法：Get
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
调用入口/api/ucenter-service-provider/api/user/getresult?rnAuthTicket=xxxx
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **rnAuthTicket**  <br>*必填* | 实名认证凭据，依次凭据可查询该次认证结果                        | string |


### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code" : 200,
  "message" : "OK",
  "data" : {
    "result" : true,
	"deviceId" : "D2486350057",
	"memberId" : "G110101199003074231",
	"identifyTime" : 1486350057,
	"finishTime" : 1486350357,
	"realName" : "张三",
	"identityNo" : "110101199003074231"
  }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**result**|认证结果|boolean|
|**identifyTime**|认证时间|long|
|**deviceId**|该次认证设备编号|String|
|**memberId**|客户唯一标识|String|
|**finishTime**|认证结束时间|long|
|**realName**|真实姓名|String|
|**identityNo**|身份证号|String|
