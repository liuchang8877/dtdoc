# 文件相关接口

## 单文件上传 （生成的文件地址无需授权即可访问）

### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/upload
请求方法：POST
Request Headers：
	x-deepcloud-from: admin || client
	Authorization: 管理员access_token || 应用access_token || 用户access_token
	Content-Type：multipart/form-data
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **file**  <br>*必填* | 暂定允许类型：jpg,jpeg,png,xls,xlsx,zip,apk, 最大允许的文件大小：100M                    |  |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
	"code":200,
	"message":"OK",
	"data":{
		"path": "http://192.168.113.166/file-api/file-service-provider/file/20190805/8/D9B9BD8918E2453E825162F852382D68.jpg"
	}
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**path**|文件可直接访问的全路径|string|

## 多文件上传接口 （生成的文件地址无需授权即可访问）

### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/batch/upload
请求方法：POST
Request Headers：
	x-deepcloud-from: admin || client
	Authorization: 管理员access_token || 应用access_token || 用户access_token
	Content-Type：multipart/form-data
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **file**  <br>*必填* (允许多个) | 暂定允许类型：jpg,jpeg,png,xls,xlsx,zip,apk, 最大允许的文件大小：100M                    |  |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
	"code":200,
	"message":"OK",
	"data":{
		"path": "http://192.168.113.166/file-api/file-service-provider/file-api/20200812/11/2E70468498CC4B85AAF89302D6E1E94B.jpg,http://192.168.113.162:8094/file-service-provider/file/20190805/8/D9B9BD8918E2453E825162F852382D68.jpg"
	}
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**path**|文件可直接访问的全路径，多个文件的路径以逗号隔开，顺序与上传时的顺序一致|string|


## 单文件上传（生成的文件地址需要授权才能访问）

文件访问见[授权文件访问](#授权文件访问)

### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/private
请求方法：POST
Request Headers：
	x-deepcloud-from: admin || client
	Authorization: 管理员access_token || 应用access_token || 用户access_token
	Content-Type：multipart/form-data
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **file**  <br>*必填* | 暂定允许类型：jpg,jpeg,png,xls,xlsx,zip,apk, 最大允许的文件大小：100M                    |  |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
	"code":200,
	"message":"OK",
	"data":{
		"path": "http://192.168.113.166/file-api/file-service-provider/download/20190805/8/D9B9BD8918E2453E825162F852382D68.jpg"
	}
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**path**|文件可直接访问的全路径|string|


## 多文件上传接口（生成的文件地址需要授权才能访问）

文件访问见[授权文件访问](#授权文件访问)

### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/batch/private
请求方法：POST
Request Headers：
	x-deepcloud-from: admin || client
	Authorization: 管理员access_token || 应用access_token || 用户access_token
	Content-Type：multipart/form-data
```

### 请求参数

| 名称                         | 说明                           | 类型   |
| ---------------------------- | ------------------------------ | ------ |
| **file**  <br>*必填* (允许多个) | 暂定允许类型：jpg,jpeg,png,xls,xlsx,zip,apk, 最大允许的文件大小：100M                    |  |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
	"code":200,
	"message":"OK",
	"data":{
		"path": "http://192.168.113.166/file-api/file-service-provider/download/20200812/11/2E70468498CC4B85AAF89302D6E1E94B.jpg,http://192.168.113.162:8094/file-service-provider/download/20190805/8/D9B9BD8918E2453E825162F852382D68.jpg"
	}
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**path**|文件可直接访问的全路径，多个文件的路径以逗号隔开，顺序与上传时的顺序一致|string|

<!-- ## 文件读取接口

读取通过DT开放平台文件上传接口上传的文件。

直接访问DT文件服务生成的文件路径即可。

### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/file/
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
http://192.168.113.166/file-api/file-service-provider/file/20200728/19/808BC2379D454F1CB0856519D0F9688B.jpg
```

### 响应样例

正常情况下，会返回正确返回文件;

路径错误返回响应状态码为404。

-->

<!-- ## 文件下载接口

用于下载存储于固定路径、固定名称的模板等文件，若有上传文件需要请联系DT开发人员。

请求最终形成固定的文件路径URL。


### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/download/
请求方法：GET
Request Headers：
	x-deepcloud-from:client
	Authorization:应用access_token
```

### 请求样例

```
http://192.168.113.166/file-api/file-service-provider/download/template/student.xls
```

### 响应样例

正常情况下，会返回正确返回文件;

路径错误返回响应状态码为404。

-->

## 授权文件访问


### 请求方式

```
请求URL：调用入口/file-api/file-service-provider/download/
请求方法：GET
Request Headers：
	x-deepcloud-from: admin || client 
	Authorization: 管理员access_token || 应用access_token || 用户access_token
```

### 请求样例

```
http://192.168.113.166/file-api/file-service-provider/download/template/student.xls
```

### 响应样例

正常情况下，会返回正确返回文件;

路径错误返回响应状态码为404。


