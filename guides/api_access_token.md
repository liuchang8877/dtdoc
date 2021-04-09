# 应用access_token

应用access_token是应用的调用应用级接口的全局唯一接口调用凭据。

access_token的有效期目前为24个小时。

## 获取应用access_token

### 适用场景

适用于应用以自己的名义与授权服务器以及资源服务器进行互动，且与用户资源无关的场景。

例如应用需要同步从DTOP基础数据、获取学校信息、组织机构信息时。

### 请求方式

```
请求URL：调用入口/open/access_token
请求方法：POST
Request Headers：
    Content-Type: application/x-www-form-urlencoded
```

### 请求样例

```
urlencode前为：
client_id=CLIENT_ID&
client_secret=CLIENT_SECRET&
grant_type=client_credentials
```

### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **client_id**  <br>*必填* | DT开放平台为为应用分配的client_id                | string          |
| **client_secret**  <br>*必填* | DT开放平台为为应用分配的client_secret | string |
| **grant_type**  <br>*必填* | 固定值client_credentials | string |


### 响应样例

正常情况下，会返回下述JSON格式数据：

```
 {
     "access_token": "ACCESS_TOKEN",
     "expires_in": 86400
 }
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**access_token**|用户授权access_token|string|
|**expires_in**|过期时间（秒），目前为24小时|integer (int32)|

