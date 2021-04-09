# 消息平台SDK

## 使用流程

![消息平台使用流程](../../_images/message_SDK.png '消息平台使用流程')

### 添加引用
在项目的pom.xml中添加依赖
```
<dependency>
  	<groupId>net.newcapec.cloud</groupId>
  	<artifactId>mp-sdk</artifactId>
  	<version>1.0-SNAPSHOT</version>
</dependency>
```

### 配置
```
### 开放平台模式
### 固定值，Http为开放平台模式，没有此配置为基于服务发现的内部调用模式。
message.feign.type=Http 	
### DT开放平台调用入口+/api/
message.feign.host=http://dt.t2/api/ 	

### 内部调用模式
### 在开放平台中申请的消息平台消费者信息，需要提前申请开通该功能
### 消息平台消费者id
message.consumer.id=id
### 消费平台秘钥
message.consumer.secret=secrect
```
## 获取应用access_token
* [参考开始开发->获取应用access_token](/guides/api_access_token?id=获取应用access_token)

## 发送短信
样例代码
###  第一步
```JAVA
	//注入client
	@Autowired
    private DefaultMpClient defaultMpClient;
```
### 第二步
```JAVA
	
	Message message = new SMSMessage();
	//设置AccessToken，内部调用可以不为accessToken赋值
	message.setAccessToken("7b10ffa76faf6330cf7dc1fd8606e77a");   
	
    //设置发送类型和模板id
	SMSMessageProperty smsMessageProperty = new SMSMessageProperty();	
	smsMessageProperty.setType("1"); // 1为短信验证码 2-验证短信验证码 3-自定义替换模板	
	smsMessageProperty.setTemplateId("1"); // 模板id 可在对接资源管理 短信模板中查看
	
	//设置接收人手机号
	ClientUser u1 = new ClientUser();
	u1.setMobileNo("手机号");
	message.setUser(new User[]{u1});
	
	message.setMessageProperty(smsMessageProperty);
	R r = null;
	try {
		r = defaultMpClient.excute(message);            
	} catch (Exception e) {
		e.getMessage();·
	}
```
### 验证短信验证码
```
	Message message = new SMSMessage();
	//设置AccessToken，内部调用可以不为accessToken赋值
	message.setAccessToken("7b10ffa76faf6330cf7dc1fd8606e77a");   
	
    //设置发送类型和模板id
	SMSMessageProperty smsMessageProperty = new SMSMessageProperty();	
	smsMessageProperty.setType("2"); // 此处类型为2	
	smsMessageProperty.setTemplateId("1"); // 模板id 可在对接资源管理 短信模板中查看
	
	//设置要验证的手机号
	ClientUser u1 = new ClientUser();
	u1.setMobileNo("手机号");
	message.setUser(new User[]{u1});
	
	//设置待验证的数值
	Map<String,Object> content=new HashMap<>();
    content.put("code","111111");
    smsMessageProperty.setContent(content);
	
	message.setMessageProperty(smsMessageProperty);
	R r = null;
	try {
		r = defaultMpClient.excute(message);            
	} catch (Exception e) {
		e.getMessage();·
	}
```

### 发送自定义替换模板
```JAVA
	Message message = new SMSMessage();
	//设置AccessToken，内部调用可以不为accessToken赋值
	message.setAccessToken("7b10ffa76faf6330cf7dc1fd8606e77a");   
    
     //设置发送类型和模板id
	SMSMessageProperty smsMessageProperty = new SMSMessageProperty();	
	smsMessageProperty.setType("3"); // 此处类型为3	
	smsMessageProperty.setTemplateId("1"); //// 模板id 可在对接资源管理 短信模板中查看
	
	//设置接收人手机号
	ClientUser u1 = new ClientUser();
	u1.setMobileNo("手机号");
	message.setUser(new User[]{u1});
	
   //设置替换内容例如模板如下：
   //亲爱的${name}，您好，您申请的收费项目${project}审核不通过，原因是：${reson}，请登录融合收入平台进行处理。
    Map<String,Object> content=new HashMap<>();
    content.put("name","李华");
    content.put("project","英语培训");
    content.put("reson","基础太差");
    smsMessageProperty.setContent(content);
    
    
	message.setMessageProperty(smsMessageProperty);
	R r = null;
	try {
		r = defaultMpClient.excute(message);            
	} catch (Exception e) {
		e.getMessage();·
	}
```

## 发送极光推送
样例代码
```JAVA
	JPushMessage jPushMessage = JPushMessage.builder("测试消息").addAllPlatform().build();
	jPushMessage.setAppKey(appKey);
	jPushMessage.setSecret(seret);        
	jPushMessage.setAccessToken("fbdac925da17714e16f71355702ea06f"); 
	
	try {
		R r = defaultMpClient.excute(jPushMessage);           
	} catch (Exception e) {
		e.getMessage();
	}

```