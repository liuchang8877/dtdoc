# 学校相关接口

## 获取学校列表

可增量、按类型查询

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/list
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/list?lastUpdateTime=2020-01-01&type=2
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode                         | string |
| **type**  <br>*非必填* | 学校类型： 1 高校，2 K12， 3 中职                         | int |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": [
        {
            "customerCode": "1001",
            "dpCode": "00000000",
            "latitude": null,
            "longitude": null,
            "name": "郑州枫杨外国语学校",
            "backgroundImgUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg",
			"logoUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg",
            "addr": null,
            "linkman": null,
            "phone": null,
            "regionId": null,
            "baned": false,
            "ecardSchool": false,
            "virtualCard": false,
            "type": 2,
            "description": null
        },
        {
            "customerCode": "666666",
            "dpCode": "00000000",
            "latitude": null,
            "longitude": null,
            "name": "江南大学附属中学",
            "backgroundImgUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg",
			"logoUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg",
            "addr": null,
            "linkman": null,
            "phone": null,
            "regionId": null,
            "baned": false,
            "ecardSchool": false,
            "virtualCard": false,
            "type": 2,
            "description": null
        }
    ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|学校信息数组|JSONArray|
|****|下为学校信息参数||
|**name**|学校名称|string|
|**customerCode**|学校唯一标识|string|
|**dpCode**|一卡通系统学校编号|string|
|**addr**|学校地址|string|
|**latitude**|学校地址纬度|decimal|
|**longitude**|学校地址经度|decimal|
|**logoUrl**|学校校徽图片地址|string|
|**backgroundImgUrl**|学校背景图地址|string|
|**linkman**|学校联系人|string|
|**phone**|学校联系电话|string|
|**regionId**|学校所属区域id|int|
|**type**|学校类型: 1 高校，2 K12，3 中职|int|
|**baned**|是否禁用|boolean|
|**ecardSchool**|是否上线一卡通|boolean|
|**virtualCard**|是否上线虚拟卡|boolean|
|**description**|学校介绍|string|


## 根据学校名称模糊查询获取学校列表

可按类型查询

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/listByName
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/listByName?name=%E5%8D%8E%E5%8C%97&type=1
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **name**  <br>*必填* | 学校名称，注意需要urlEncode                       | string |
| **type**  <br>*非必填* | 学校类型： 1 高校，2 K12， 3 中职                        | int |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": [
        {
            "customerCode": "2",
            "dpCode": "00000000",
            "latitude": 34.784121,
            "longitude": 113.803909,
            "name": "华北水利水电大学",
            "backgroundImgUrl": null,
			"logoUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg"
            "addr": "河南省郑州市金水区水环路1号",
            "linkman": null,
            "phone": null,
            "regionId": 179,
            "baned": false,
            "ecardSchool": true,
            "virtualCard": true,
            "type": 1,
            "description": null,
            
        }
    ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|学校信息数组|JSONArray|
|****|下为学校信息参数||
|**name**|学校名称|string|
|**customerCode**|学校唯一标识|string|
|**dpCode**|一卡通系统学校编号|string|
|**addr**|学校地址|string|
|**latitude**|学校地址纬度|decimal|
|**longitude**|学校地址经度|decimal|
|**logoUrl**|学校校徽图片地址|string|
|**backgroundImgUrl**|学校背景图地址|string|
|**linkman**|学校联系人|string|
|**phone**|学校联系电话|string|
|**regionId**|学校所属区域id|int|
|**type**|学校类型: 1 高校，2 K12，3 中职|int|
|**baned**|是否禁用|boolean|
|**ecardSchool**|是否上线一卡通|boolean|
|**virtualCard**|是否上线虚拟卡|boolean|
|**description**|学校介绍|string|


## 根据学校唯一标识集合、学校组织机构id查询信息列表

可根据需求自由组合查询，例如只需要学校列表则只传学校唯一标识集合即可。

注意：此接口没有根据DT基座自带的B端权限过滤数据，业务系统使用时自行处理数据权限。

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/dept/list
请求方法：POST
Request Headers：
    x-deepcloud-from:
		C端：client
		B端：admin
	Authorization:
		C端：应用access_token
		B端：admin的access_token
	Content-Type: application/json
```

#### 请求样例

```
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/dept/list
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customerCodePerm**  <br>*非必填* | 学校唯一标识集合                       | JSONArray |
| **customerDeptIdPerm**  <br>*非必填* | 学校组织机构id集合                       | JSONArray |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": [
    {
      "ecardSchool": null,
      "hasChildren": true,
      "latitude": 34.814431,
      "customerCode": "55",
      "description": null,
      "type": 0,
      "children": null,
      "id": 17,
      "addr": "河南省开封市顺河回族区明伦街18号",
      "operatorId": null,
      "backgroundImgUrl": "20200420/17/F6379D417B3A4011B9A37C3DD35AB477.jpg",
      "longitude": 114.376659,
      "level": 0,
      "virtualCard": null,
      "dataType": "customer",
      "updateTime": "2020-11-11 11:27:29",
      "deptType": 0,
      "leaf": true,
      "linkman": null,
      "logoUrl": "20200420/17/9A589C3DA2BC4BE6B9701F476DAD143B.jpg",
      "treeId": null,
      "extensions": null,
      "deleted": null,
      "createTime": "2020-04-09 16:38:50",
      "phone": null,
      "regionId": 98,
      "dpCode": "00000000",
      "able": true,
      "name": "XXX大学",
      "baned": null
    },
    {
      "ecardSchool": null,
      "hasChildren": true,
      "latitude": null,
      "customerCode": "21635",
      "description": null,
      "type": 1,
      "children": null,
      "id": 72,
      "addr": null,
      "operatorId": null,
      "backgroundImgUrl": "",
      "longitude": null,
      "level": 0,
      "virtualCard": null,
      "dataType": "customer",
      "updateTime": "2020-08-13 15:36:52",
      "deptType": 0,
      "leaf": true,
      "linkman": null,
      "logoUrl": "",
      "treeId": null,
      "extensions": null,
      "deleted": null,
      "createTime": "2020-04-29 14:57:58",
      "phone": null,
      "regionId": 40,
      "dpCode": "00000000",
      "able": true,
      "name": "华东测试四",
      "baned": null
    },
    {
      "level": 1,
      "dataType": "dept",
      "customerCode": "55",
      "remark": "asd",
      "updateTime": "2020-08-20 14:50:24",
      "type": 1,
      "parentId": 0,
      "treeId": null,
      "parentName": null,
      "deleted": false,
      "createTime": "2019-09-17 09:39:47",
      "name": "计算机与信息工程学院",
      "id": 1
    }
  ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|学校信息数组|JSONArray|
|**data.dataType**|信息类型："customer"为学校、"dept"为组织机构|string|
|****|下为学校信息参数||
|**name**|学校名称|string|
|**customerCode**|学校唯一标识|string|
|**dpCode**|一卡通系统学校编号|string|
|**addr**|学校地址|string|
|**latitude**|学校地址纬度|decimal|
|**longitude**|学校地址经度|decimal|
|**logoUrl**|学校校徽图片地址|string|
|**backgroundImgUrl**|学校背景图地址|string|
|**linkman**|学校联系人|string|
|**phone**|学校联系电话|string|
|**regionId**|学校所属区域id|int|
|**type**|学校类型: 1 高校，2 K12，3 中职|int|
|**baned**|是否禁用|boolean|
|**ecardSchool**|是否上线一卡通|boolean|
|**virtualCard**|是否上线虚拟卡|boolean|
|**description**|学校介绍|string|
|****|下为组织机构信息参数||
|**id**|组织机构的id（DT体系内组织机构的唯一标识）|string|
|**name**|组织机构的名称|string|
|**type**|组织机构类型：1 教学院系，2 科研机构，3 公共服务(指图书馆、档案馆、分析测试中心、计算/网络/信息/电教/教育技术中心等学术支撑单位 )，4 党务部门(含工会、团委、妇委会)，5 行政机构，6 附属单位，7 后勤部门，8 校办产业，9 其他  |int|
|**level**|教学院系级别：1 院系，2 专业，3 年级，4 班级，0 非教学院系|int|
|**customerCode**|组织机构所属学校唯一标识|string|
|**deleted**|是否被删除|boolean|
|**createTime**|创建时间|string|
|**updateTime**|更新时间|string|
|**parentId**|组织机构的父级id|long|

## 根据学校唯一标识获取学校信息

可按类型查询

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/customerInfo
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/customerInfo?customerCode=21635
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customerCode**  <br>*必填* | 学校唯一标识                       | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": {
		"customerCode": "2",
		"dpCode": "00000000",
		"latitude": 34.784121,
		"longitude": 113.803909,
		"name": "华北水利水电大学",
		"backgroundImgUrl": null,
		"logoUrl": "20200426/9/09AD028C01814F9280F4F3051C532959.jpg",
		"addr": "河南省郑州市金水区水环路1号",
		"linkman": null,
		"phone": null,
		"regionId": 179,
		"baned": false,
		"ecardSchool": true,
		"virtualCard": true,
		"type": 1,
		"description": null
	}
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|学校信息|JSON|
|****|下为学校信息参数||
|**name**|学校名称|string|
|**customerCode**|学校唯一标识|string|
|**dpCode**|一卡通系统学校编号|string|
|**addr**|学校地址|string|
|**latitude**|学校地址纬度|decimal|
|**longitude**|学校地址经度|decimal|
|**logoUrl**|学校校徽图片地址|string|
|**backgroundImgUrl**|学校背景图地址|string|
|**linkman**|学校联系人|string|
|**phone**|学校联系电话|string|
|**regionId**|学校所属区域id|int|
|**type**|学校类型: 1 高校，2 K12，3 中职|int|
|**baned**|是否禁用|boolean|
|**ecardSchool**|是否上线一卡通|boolean|
|**virtualCard**|是否上线虚拟卡|boolean|
|**description**|学校介绍|string|

## 通过学校唯一标识获取学校的组织机构列表

支持组织机构类型、教学院系级别维度

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/customer/dept
请求方法：GET
Request Headers：
    x-deepcloud-from:client
	Authorization:应用access_token
```

#### 请求样例

```
例如想要请求某学校下所有的班级信息
http://192.168.113.165:8887/api/ucenter-service-provider/api/customer/dept?customer_code=21635&level=4
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **customer_code**  <br>*必填* | 学校唯一标识                       | string |
| **type**  <br>*非必填* | 组织机构类型：1 教学院系，2 科研机构，3 公共服务(指图书馆、档案馆、分析测试中心、计算/网络/信息/电教/教育技术中心等学术支撑单位 )，4 党务部门(含工会、团委、妇委会)，5 行政机构，6 附属单位，7 后勤部门，8 校办产业，9 其他                       | int |
| **level**  <br>*非必填* | 教学院系级别：1 院系，2 专业，3 年级，4 班级，0 非教学院系                      | int |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
  "code": 200,
  "message": "OK",
  "data": [
    {
      "deptId": 339,
      "deptName": "2018级一班",
      "level": 4,
      "type": 1,
      "fullName": "特教专业-2018级一班",
      "parentId": 338
    },
	{
      "deptId": 340,
      "deptName": "2018级二班",
      "level": 4,
      "type": 1,
      "fullName": "特教专业-2018级二班",
      "parentId": 338
    }
  ]
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**data**|学校的组织机构信息|JSONARRAY|
|****|下为组织机构参数||
|**deptId**|组织机构的id（DT体系内组织机构的唯一标识）|long|
|**deptName**|组织机构的名称|string|
|**type**|组织机构类型：1 教学院系，2 科研机构，3 公共服务(指图书馆、档案馆、分析测试中心、计算/网络/信息/电教/教育技术中心等学术支撑单位 )，4 党务部门(含工会、团委、妇委会)，5 行政机构，6 附属单位，7 后勤部门，8 校办产业，9 其他  |int|
|**level**|教学院系级别：1 院系，2 专业，3 年级，4 班级，0 非教学院系|int|
|**fullName**|组织机构的全名（目前只扩展到父级的名称拼接）|string|
|**parentId**|组织机构的父级id|long|