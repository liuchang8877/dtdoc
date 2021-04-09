## Java SDK

说明：目前封装了获取用户授权access_token以及获取用户信息的API。

1.获取用户授权access_token：
    
    import net.newcapec.cloud.auth2.client.auth.Oauth;
    import net.newcapec.cloud.auth2.client.model.AccessToken;
    
    Oauth oauth = new Oauth("调用入口/open/access_token");
    AccessToken accessToken = null;
    try {
        accessToken =  oauth.getAccessTokenByCode("client_id", "client_secret", "redirect_uri", "code");
    } catch (OpenCampusException e) {
        e.printStackTrace();
    }
    
2.获取用户信息：

     
    import net.newcapec.cloud.auth2.client.request.UserContext;
    
    //传入参数为获取到的用户授权access_token
    UserContext userContext = new UserContext(accessToken.getAccessToken());
    //获取基本信息
    userContext.getUserInfo()
    //获取实名信息
    userContext.getRealUserInfo()
    

                    
                                

> [Java SDK 下载](http://192.168.113.162:8094/file-service-provider/download/open-auth-client.jar)
>
> [Java SDK demo 下载](http://192.168.113.162:8094/file-service-provider/download/auth-demo.zip)