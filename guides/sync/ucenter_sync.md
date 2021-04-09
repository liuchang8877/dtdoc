# 基础数据同步

目前DTOP可供第三方系统同步的基础数据包括

<a href="http://192.168.113.162:8094/file-service-provider/download/dtop_customer.sql" target="_blank" id="customer">学校信息</a>

<a href="http://192.168.113.162:8094/file-service-provider/download/dtop_customer_dept.sql" target="_blank" id="customerDept">组织机构信息</a>

<a href="http://192.168.113.162:8094/file-service-provider/download/dtop_import_rn_auth_user.sql" target="_blank" id="import">组织机构人员名单</a>

<a href="http://192.168.113.162:8094/file-service-provider/download/dtop_rn_member_relative.sql" target="_blank" id="member_relative">人员名单的亲属名单</a>

<a href="http://192.168.113.162:8094/file-service-provider/download/dtop_rn_member_dept.sql" target="_blank" id="member_dept">人员名单的组织机构关系</a>

## 同步方式

推荐第三方系统通过同步原始数据表的形式（原始数据表创建SQL，**右键上方下载链接，选择链接另存为**），完成与DTOP的基础数据同步。

在同步基础数据时，第三方业务系统根据需求自行选择同步方式，也可以混合使用。

### 接口同步方式

DTOP提供的基础数据同步接口一般都默认支持通过最后更新时间（增量）的方式同步数据，不传最后更新时间则返回全量数据。

另外某些同步接口也支持根据具体纬度过滤同步数据。

同步接口需要第三方系统提前申请，审核后开通。

具体接口见下方接口文档。

### MQ同步方式

目前DTOP提供的MQ同步方式涉及五个topic，对应五种基础数据类型。

当DTOP的基础数据表发生变更时会向对应的topic发送包含变更数据的MQ消息，业务系统可根据MQ消息中包含的数据进行同步操作。

目前T2，T3环境均使用RocketMQ，且由于T3环境MQ有账号密码限制，如有需要，请提前向DTOP申请，审核后提供MQ连接资源。


## 同步学校数据

支持通过最后更新时间（增量）过滤数据。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/customer/time
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/customer/time?lastUpdateTime=lastUpdateTime
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode，不填则为全量获取数据             | string          |


### 响应

正常情况下，会返回JSONArray格式的<a href="#/guides/sync/ucenter_sync#customer">学校信息</a>。


<!--
  需要特殊申请的接口，暂不开放
## 以最后更新时间同步组织机构数据

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/dept/time
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/dept/time?lastUpdateTime=lastUpdateTime
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **lastUpdateTime**  <br>*必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode                | string          |

### 响应

正常情况下，会返回JSONArray格式的[组织机构信息](http://192.168.113.162:8094/file-service-provider/download/dtop_customer_dept.sql)。
-->

## 以学校唯一标识同步组织机构数据

支持通过最后更新时间（增量）过滤数据。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/dept/timeandcustomercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/dept/timeandcustomercode?lastUpdateTime=lastUpdateTime&customerCode=customerCode
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode，不填则为全量获取数据                | string          |


### 响应

正常情况下，会返回JSONArray格式的<a href="#/guides/sync/ucenter_sync#customerDept">组织机构信息</a>。


<!--
## 以学校唯一标识同步组织机构数据

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/dept/customercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/dept/customercode?customerCode=customerCode
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |


### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#customerDept">组织机构信息</a>。
-->

<!--
  需要特殊申请的接口，暂不开放
## 以最后更新时间同步人员名单数据

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/time
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/time?lastUpdateTime=lastUpdateTime
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **lastUpdateTime**  <br>*必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode                | string          |

### 响应

正常情况下，会返回下述JSONArray格式的[组织机构人员名单](http://192.168.113.162:8094/file-service-provider/download/dtop_import_rn_auth_user.sql)。
-->

## 以学校唯一标识同步人员名单数据

支持通过最后更新时间（增量）及角色过滤数据。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/timeandcustomercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/timeandcustomercode?lastUpdateTime=lastUpdateTime&customerCode=customerCode&role=1&role=2
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode，不填则为全量获取数据                 | string          |
| **role**  <br>*非必填* | 人员名单角色：1 学生,2 教师, 4 后勤人员,5 临时人员               | int          |
| **startNum**  <br>*必填* | 获取记录的起始值，从0开始               | long          |
| **recordSize**  <br>*必填* | 获取记录的条数，<B>不能大于5000,否则直接返回失败 </B>               | int          |

### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#import">组织机构人员名单</a>。

## 以学校唯一标识同步人员名单的亲属名单数据

支持通过最后更新时间（增量）过滤数据。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/relative/customercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/relative/customercode?lastUpdateTime=lastUpdateTime&customerCode=customerCode
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode，不填则为全量获取数据                | string          |

### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#member_relative">人员名单的亲属名单</a>。

## 以学校唯一标识同步人员名单的组织机构关系数据

支持通过最后更新时间（增量）过滤数据。

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/dept/customercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/dept/customercode?lastUpdateTime=lastUpdateTime&customerCode=customerCode
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |
| **lastUpdateTime**  <br>*非必填* | 上次更新时间，格式为`yyyy-MM-dd HH:mm:ss`，注意需要urlEncode，不填则为全量获取数据                | string          |
| **role**  <br>*非必填* | 人员名单角色：1 学生,2 教师, 4 后勤人员,5 临时人员               | int          |
| **startNum**  <br>*必填* | 获取记录的起始值，从0开始               | long          |
| **recordSize**  <br>*必填* | 获取记录的条数，<B>不能大于5000,否则直接返回失败 </B>              | int          |

### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#member_dept">人员名单的组织机构关系</a>。

<!--
## 以学校唯一标识同步人员名单数据

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/customercode
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/customercode?customerCode=customerCode
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customerCode**  <br>*必填* | 学校唯一标识               | string          |

### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#import">组织机构人员名单</a>。
-->

<!--
## 以组织机构id同步人员名单数据

### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sync/importuser/deptid
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
调用入口/api/ucenter-service-provider/api/sync/importuser/deptid?deptId=deptId
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **deptId**  <br>*必填* | 组织机构id               | long          |

### 响应

正常情况下，会返回下述JSONArray格式的<a href="#/guides/sync/ucenter_sync#import">组织机构人员名单</a>。-->


## 学校数据MQ同步消息

### 请求方式

   [MQ地址](guides/api_protocol?id=mq资源)
   
    T1
	
    topic：T1-syncCustomer
	
	T2 T3 P1
	
    topic：syncCustomer

### Message body

正常情况下，Message body中为JSONArray格式的<a href="#/guides/sync/ucenter_sync#customer">学校信息</a>。

## 组织机构数据MQ同步消息

### 请求方式

   [MQ地址](guides/api_protocol?id=mq资源)
   
    T1
	
    topic：T1-syncCustomerDept
	
	T2 T3 P1
	
    topic：syncCustomerDept

### Message body

正常情况下，Message body中为JSONArray格式的<a href="#/guides/sync/ucenter_sync#customerDept">组织机构信息</a>。


## 人员名单数据MQ同步消息

### 请求方式

   [MQ地址](guides/api_protocol?id=mq资源)
   
	T1
	
	topic：T1-syncImportUser
	
	T2 T3 P1
	
	topic：syncImportUser

### Message body

正常情况下，Message body中为JSONArray格式的<a href="#/guides/sync/ucenter_sync#import">组织机构人员名单</a>。

## 人员名单的亲属名单MQ同步消息

### 请求方式

   [MQ地址](guides/api_protocol?id=mq资源)
   
    T1
	
    topic：T1-syncMemberRelative
	
	T2 T3 P1  
	
	topic：syncMemberRelative

### Message body

正常情况下，Message body中为JSONArray格式的<a href="#/guides/sync/ucenter_sync#member_relative">人员名单的亲属名单</a>。

## 人员名单的组织机构关系数据MQ同步消息

### 请求方式

   [MQ地址](guides/api_protocol?id=mq资源)
   
	T1
	
    topic：T1-syncMemberDept
	
	T2 T3 P1
	
	topic：syncMemberDept

### Message body

正常情况下，Message body中为JSONArray格式的<a href="#/guides/sync/ucenter_sync#member_dept">人员名单的组织机构关系</a>。