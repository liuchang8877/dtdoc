# 消息相关接口

现阶段发送用户相关短信暂由用户中心对接，待消息平台API易用性提升后，推荐直接通过消息平台API对接相关消息发送接口。

# 短信

## 发送短信验证码（无图形验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sms/code/send
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type：application/json
```

#### 请求样例

```
{
    "mobile_no":"181xxxxxxxx"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **mobile_no**  <br>*必填* | 发送手机号                         | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 发送短信验证码（验证图形验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sms/code/captcha/send
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type：application/json
```

#### 请求样例

```
{
    "mobile_no":"181xxxxxxxx",
	"key":"2ecd1fc5-f7c1-4e25-aa96-24b881ac5bfd",
	"captcha":"cnxdg"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **mobile_no**  <br>*必填* | 发送手机号                         | string |
| **key**  <br>*必填* | 用于生成图形验证码的唯一标识，推荐使用32位UUID形式                         | string |
| **captcha**  <br>*必填* | 图形验证码的文字内容                       | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

## 通过用户唯一标识发送短信验证码（无图形验证码）

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sms/code/guid/send
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type：application/json
```

#### 请求样例

```
{
    "guid":"18111111111111111"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **guid**  <br>*必填* | 用户唯一标识                       | string |

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```


## 验证短信验证码

#### 请求方式

```
请求URL：调用入口/api/ucenter-service-provider/api/sms/code/verify
请求方法：POST
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
	Content-Type：application/json
```

#### 请求样例

```
{
    "mobile_no":"181xxxxxxxx",
    "code":"267540"
}
```

#### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **mobile_no**  <br>*必填* | 发送手机号                         | string|
| **code**  <br>*必填* | 短信验证码                         | string|

#### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```

# 推送

目前推送只支持极光推送

# 微信公众号模板消息

# 企业微信消息

