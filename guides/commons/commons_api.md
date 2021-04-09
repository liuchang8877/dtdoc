# 通用服务接口

现阶段发送用户相关短信暂由用户中心对接，待消息平台API易用性提升后，推荐直接通过消息平台API对接相关消息发送接口。

## 获取图形验证码

### 请求方式

```
请求URL：调用入口/api/dt-commons/captcha.jpg
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
http://192.168.113.165:8887/api/dt-commons/captcha.jpg?key=2ecd1fc5-f7c1-4e25-aa96-24b881ac5bfd
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*必填* | 用于生成图形验证码的唯一标识，推荐使用32位UUID形式                         | string |

### 响应样例

正常情况下，会返回Headers中包含Content-Type:image/jpeg的Response，Body中为图形验证码图片的Base64编码。

## 验证图形验证码

### 请求方式

```
请求URL：调用入口/api/dt-commons/captcha/validate
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
http://192.168.113.165:8887/api/dt-commons/captcha/validate?key=2ecd1fc5-f7c1-4e25-aa96-24b881ac5bfd&captcha=cnxdg
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **key**  <br>*必填* | 用于生成图形验证码的唯一标识，推荐使用32位UUID形式                         | string |
| **captcha**  <br>*必填* | 图形验证码的文字内容                         | string |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": null
}
```
