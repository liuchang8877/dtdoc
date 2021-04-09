# 获取用户授权access_token

如果您的应用在对接DTOP时需要使用用户的资源（用户信息等），为保证用户资源的安全和隐私，您的应用需要取得用户的授权，即获取访问用户资源的用户授权access_token。

在这种情况下，需要引导用户完成登录授权的流程。该流程采用国际通用的OAuth2.0标准协议作为用户身份验证和授权协议。

DTOP支持多种用户授权方式：

1、[标准用户授权](#标准用户授权)。

2、[宿主对接授权](#宿主对接授权)。

3、[直接通过用户名短信验证码/密码授权](#直接通过用户名短信验证码密码授权)。


## 标准用户授权

标准用户授权页面授权时序图如下

![标准用户授权页面授权](../../_images/DTOP_standard_auth.jpg '标准用户授权页面授权时序图')

### 第一步：获取授权码(code) 

#### 请求接口

```
请求URL：调用入口/open/oauth2/authorize
请求方式：GET
```

#### 请求参数

|名称|说明|类型|
|---|---|---|
|**client_id**|DT开放平台为为应用分配的client_id|string|
|**redirect_uri**|应用在DT开放平台配置的授权回调地址，注意需要urlEncode|string|
|**response_type**|code，固定值|string|

#### 请求样例

```
调用入口/open/oauth2/authorize?client_id=客户端ID&redirect_uri=回调地址&response_type=code
```

如果此时未登录会先跳转到登录页面，登录完成后，服务端会根据redirect_uri的回调地址跳转并追加code值。

至此，应用获取到授权码。

### 第二步：通过授权码(code)换取用户授权access_token
#### 请求方式

```
请求URL：调用入口/open/access_token
请求方法：POST
Request Headers：
    Content-Type: application/x-www-form-urlencoded
```
#### 请求样例

```
urlencode前为：
client_id=CLIENT_ID&
client_secret=CLIENT_SECRET&
redirect_uri=REDIRECT_URI&
grant_type=authorization_code&
code=CODE
```
#### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **client_id**  <br>*必填* | DT开放平台为为应用分配的client_id                | string          |
| **client_secret**  <br>*必填* | DT开放平台为为应用分配的client_secret | string |
| **redirect_uri**  <br>*必填* | 应用在DT开放平台配置的授权回调地址 | string |
| **grant_type**  <br>*必填* | 固定值authorization_code | string |
| **code**  <br>*必填* | 授权码 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
 {
     "access_token": "ACCESS_TOKEN",
     "refresh_token": "REFRESH_TOKEN",
     "expires_in": 86400
 }
```

#### 响应参数

|名称|说明|类型|
|---|---|---|
|**access_token**|用户授权access_token|string|
|**refresh_token**|用于刷新access_token的token|string|
|**expires_in**|access_token过期时间，目前为24小时|integer (int32)|


## 宿主对接授权

如下时序图描述了应用通过宿主对接DT开放平台获取用户授权access_token的过程。

应用开发者可以忽略宿主与DT开放平台的对接的细节，只需关注从下图中步骤7处开始的流程。


![通过宿主对接获取用户授权](../../_images/DTOP_host_auth.jpg '通过宿主对接获取用户授权时序图')

对于应用开发者而言只需要如下两步就可以获取用户授权access_token：

### 第一步：获取授权码(code) 

以下简称应用在DT开放平台配置的回调地址为redirect_uri。

则DT开放平台在验证了宿主发送的一系列信息的后，会跳转至

```
redirect_uri?code=CODE
```

至此，应用获取到授权码。

### 第二步：通过授权码(code)换取用户授权access_token


[同标准授权流程](#第二步：通过授权码code换取用户授权access_token)。


## 直接通过用户名短信验证码/密码授权

对于可信性较高的应用，如基于DT的APP和H5门户等，可以通过此模式获取到用户授权access_token。

#### 请求方式

```
请求URL：调用入口/open/access_token
请求方法：POST
Request Headers：
    Content-Type: application/x-www-form-urlencoded
```
#### 请求样例

```
urlencode前为：
client_id=CLIENT_ID&
client_secret=CLIENT_SECRET&
redirect_uri=REDIRECT_URI&
grant_type=password&
username=USERNAME&
password=PASSWORD&
loginType=LOGIN_TYPE
```
#### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **client_id**  <br>*必填* | DT开放平台为为应用分配的client_id                | string          |
| **client_secret**  <br>*必填* | DT开放平台为为应用分配的client_secret | string |
| **redirect_uri**  <br>*必填* | 应用在DT开放平台配置的授权回调地址 | string |
| **grant_type**  <br>*必填* | 固定值password | string |
| **username**  <br>*必填* | 用户名，一般为手机号 | string |
| **password**  <br>*必填* | 短信验证码/密码 | string |
| **loginType**  <br>*必填* |登录类型，1 短信验证码，2 密码 | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
 {
     "access_token": "ACCESS_TOKEN",
     "refresh_token": "REFRESH_TOKEN",
     "expires_in": 86400
 }
```

#### 响应参数

|名称|说明|类型|
|---|---|---|
|**access_token**|用户授权access_token|string|
|**refresh_token**|用于刷新access_token的token|string|
|**expires_in**|access_token过期时间，目前为24小时|integer (int32)|

## 通过refresh_token获取access_token

在第一次获取到access_token时，同时会获取到用于刷新access_token的refresh_token，refresh_token可以用来获取到全新的有效的access_token。

目前用户授权refresh_token的有效期为一个月，可以用来实现自动登录等功能。

#### 请求方式

```
请求URL：调用入口/open/access_token
请求方法：POST
Request Headers：
    Content-Type: application/x-www-form-urlencoded
```
#### 请求样例

```
urlencode前为：
client_id=CLIENT_ID&
client_secret=CLIENT_SECRET&
redirect_uri=REDIRECT_URI&
grant_type=refresh_token&
refresh_token=REFRESH_TOKEN
```
#### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **client_id**  <br>*必填* | DT开放平台为为应用分配的client_id                | string          |
| **client_secret**  <br>*必填* | DT开放平台为为应用分配的client_secret | string |
| **redirect_uri**  <br>*必填* | 应用在DT开放平台配置的授权回调地址 | string |
| **grant_type**  <br>*必填* | 固定值refresh_token | string |
| **refresh_token**  <br>*必填* | 获取到的refresh_token | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
 {
     "access_token": "ACCESS_TOKEN",
     "refresh_token": "REFRESH_TOKEN",
     "expires_in": 86400
 }
```

#### 响应参数

|名称|说明|类型|
|---|---|---|
|**access_token**|用户授权access_token|string|
|**refresh_token**|用于刷新access_token的token|string|
|**expires_in**|access_token过期时间，目前为24小时|integer (int32)|
