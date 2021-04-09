# 一卡通服务调用说明


### 请求方式

```
请求URL：调用入口/api/ecard-service/api/ecard/{command}
请求方法：POST
Request Headers：
    x-deepcloud-from:client
    Authorization:用户授权access_token
    Content-Type: application/json
```

说明: 

{command} 为一卡通接口命令字。

入口参数中一卡通接口定义的参数中如果出现command,dpcode等参数，不需要再传。

具体对应内容请查阅[《一卡通前置接口文档》](http://192.168.113.162:8094/file-service-provider/download/ecard.pdf)。

### 请求样例

```
{   
    "customercode":"1234",
    "params":{   
        "customerid":"123456",
        "password":"654321"
    }
}
```
### 请求参数

| 名称                 | 说明                                  | 类型            |
| -------------------- | ------------------------------------- | --------------- |
| **customercode**  <br>*必填* | 学校唯一标识              | string          |
| **params**  <br>*必填* | 一卡通接口定义的参数 | json |

### 响应样例

正常情况下，会返回下述JSON格式数据：

```
{
    "code": 200,
    "message": "OK",
    "data": {
        一卡通返回数据
    }
}
```

### 响应参数

|名称|说明|类型|
|---|---|---|
|**code**|操作结果：200=成功 其他=失败|integer|
|**message**|操作响应信息|string|
|**data**|一卡通返回数据|json|

说明:
返回值data部分为一卡通返回的数据，具体数据定义请查阅[《一卡通前置接口文档》](http://192.168.113.162:8094/file-service-provider/download/ecard.pdf)。


