//
//  JwAuthHelper.m
//  JwPart
//
//  Created by 陈警卫 on 2020/5/7.
//  Copyright © 2020 陈警卫. All rights reserved.
//completion

#import "JwAuthHelper.h"
#import "JwShareAuthHeader.h"
#import <WXApi.h>
#import <WechatConnector/WechatConnector.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface JwAuthHelper ()<WXApiDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

//WXApiDelegate微信代理回调
//ASAuthorizationControllerDelegate 处理数据回调
//ASAuthorizationControllerPresentationContextProviding 设置上下文 管理视图弹出在哪里

@property (nonatomic, copy) AuthBlock didAuthBlock;

@end

@implementation JwAuthHelper

+ (JwAuthHelper *)singleAuth{
    static JwAuthHelper *authHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authHelper = [[JwAuthHelper alloc] init];
    });
    return authHelper;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [JwAuthHelper auth];
    }
    return self;
}

+ (void)auth{
    [WXApi registerApp:MOBSSDKWeChatAppID universalLink:MOBSSDKUniversalLink];
}

+ (void)authWithAppId:(NSString *)appId{
    [WXApi registerApp:appId universalLink:MOBSSDKUniversalLink];
}

+ (void)sendAuthWithScope:(NSString *)scope state:(NSString *)state completion:(AuthBlock)completion{
    
    if([WXApi isWXAppInstalled]){
        SendAuthReq *authReq = [[SendAuthReq alloc] init];
        authReq.scope = scope;
        authReq.state = state;
        
        JwAuthHelper *authHelper = [JwAuthHelper singleAuth];
        authHelper.didAuthBlock = completion;
        
        [WXApi sendReq:authReq completion:^(BOOL success) {
            
        }];
    }else{
        [UIAlertView showWithTitle:@"提示" message:@"请先安装微信" cancelButtonTitle:@"确定" action:^{
            
        }];
    }
}

/**
 授权登录
 微信需要AppSecret 正常
 微信没有AppSecret SSDKUser uid == authCode
 [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:nil];
 */
+ (void)authorizeWithPlatformType:(SSDKPlatformType)platformType success:(void(^)(SSDKUser *user, NSError *error))success{
    [WeChatConnector setRequestAuthTokenOperation:^(NSString *authCode, void (^getUserinfo)(NSString *uid, NSString *token)) {
        SSDKUser *user = [[SSDKUser alloc] init];
        user.uid = authCode;
        success(user, nil);
        getUserinfo(nil,nil);
    }];
    [ShareSDK authorize:platformType settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess){
            success(user, error);
        }else if (state == SSDKResponseStateCancel){
            success(nil, error);
        }else if (state == SSDKResponseStateFail){
            success(nil, error);
        }
    }];
}

//拉起小程序
+ (void)wakeupWeChatMiniProgramWithUserName:(NSString *)userName path:(NSString *)path type:(NSString *)type{
    //向微信注册
   [JwAuthHelper auth];
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = userName;//@"gh_00ba555b97d4";  //拉起的小程序的username
    launchMiniProgramReq.path = path;    //拉起小程序页面的可带参路径，不填默认拉起小程序首页
    
    if ([type isEqualToString:@"0"]) {
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //拉起小程序的类型 正式版
    }else if ([type isEqualToString:@"1"]){
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest; //开发版
    }else if ([type isEqualToString:@"2"]){
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypePreview; //体验版
    }
    
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        DLog(@"微信回调");
    }];
}

+ (void)signinApple API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *authAppleIDRequest = [appleIDProvider createRequest];
    authAppleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    
    ASAuthorizationPasswordRequest *passwordRequest = [[ASAuthorizationPasswordProvider new] createRequest];
    NSMutableArray <ASAuthorizationRequest *>* array = [NSMutableArray arrayWithCapacity:2];
    if (authAppleIDRequest) {
        [array addObject:authAppleIDRequest];
    }
    if (passwordRequest) {
        [array addObject:passwordRequest];
    }
    NSArray <ASAuthorizationRequest *>* requests = [array copy];
    
    ASAuthorizationController *auth = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
    auth.delegate = [JwAuthHelper singleAuth];
    auth.presentationContextProvider = [JwAuthHelper singleAuth];
    [auth performRequests];
}


//接收回调
+ (BOOL)handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[JwAuthHelper singleAuth]];
}

+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity{
    return [WXApi handleOpenUniversalLink:userActivity delegate:[JwAuthHelper singleAuth]];
}


/*
 收到一个来自微信的请求 第三方应用程序处理完后调用sendResp向微信发送结果
 */
- (void)onReq:(BaseReq*)req{
    DLog(@"onReq");
}

/*
 发送一个sendReq后 收到微信的回应
 收到一个来自微信的处理结果 调用一次sendReq后会收到onResp
 */
- (void)onResp:(BaseResp*)resp{
    
    if([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == 0) {
            if (self.didAuthBlock) {
                self.didAuthBlock(YES, ((SendAuthResp *)resp).code);
            }
        }else if(resp.errCode == -4) {
            if (self.didAuthBlock) {
                self.didAuthBlock(NO, @"用户拒绝微信授权");
            }
        }else if(resp.errCode == -2) {
            if (self.didAuthBlock) {
                self.didAuthBlock(NO, @"用户取消微信授权");
            }
        }else{
            if (self.didAuthBlock) {
                self.didAuthBlock(NO, @"微信授权失败");
            }
        }
    }
}

//代理主要用于展示在哪里
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    return [UIApplication sharedApplication].keyWindow;
}


- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    
    if([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]){
        
        ASAuthorizationAppleIDCredential *credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; //refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; //access token
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"state: %@", state);
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
        
    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        
        //Sign in using an existing iCloud Keychain credential.
        ASPasswordCredential *passwordCredential = (ASPasswordCredential *)authorization.credential;
        NSString *userIdentifier = passwordCredential.user;
        NSString *password = passwordCredential.password;
        
        NSLog(@"userIdentifier: %@", userIdentifier);
        NSLog(@"password: %@", password);
        
    }
}

//回调失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    DLog(@"%@", errorMsg);
}


@end
