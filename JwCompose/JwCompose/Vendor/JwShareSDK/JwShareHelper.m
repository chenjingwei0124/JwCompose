
//
//  JwShareHelper.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/11/30.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwShareHelper.h"
#import <WechatConnector/WechatConnector.h>

@implementation JwShareHelper

+ (void)share{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
#ifdef IMPORT_SINA_WEIBO
        [platformsRegister setupSinaWeiboWithAppkey:MOBSSDKSinaWeiboAppKey appSecret:MOBSSDKSinaWeiboAppSecret redirectUrl:MOBSSDKSinaWeiboRedirectUri];
#endif
        
#if (defined IMPORT_SUB_QQFriend) || (defined IMPORT_SUB_QZone)
        [platformsRegister setupQQWithAppId:MOBSSDKQQAppID appkey:MOBSSDKQQAppKey];
#endif
        
#if (defined IMPORT_SUB_WechatSession) || (defined IMPORT_SUB_WechatTimeline) || (defined IMPORT_SUB_WechatFav)
        [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:nil];
#endif
    }];
}

/** 分享 */
+ (void)shareWithPlatformType:(SSDKPlatformType)platformType
                  contentType:(SSDKContentType)contentType
                        share:(JwShare *)share
                   completion:(void(^)(BOOL success, NSError *error))completion{
    
    NSMutableDictionary *params = nil;
    params = [self setupPlatformType:platformType contentType:contentType share:share];
    
    [self shareWithPlatformType:platformType param:params completion:completion];
}

+ (void)shareWithPlatformType:(SSDKPlatformType)platformType param:(NSMutableDictionary *)param completion:(void(^)(BOOL success, NSError *error))completion{
    if (param.count == 0) {
        DLog(@"请先设置分享参数");
        return;
    }
    Weak(self);
    [ShareSDK share:platformType
         parameters:param
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         [wself showShareResult:state completion:completion];
    }];
}

/** 分享
 设置分享参数
 */
+ (NSMutableDictionary *)setupPlatformType:(SSDKPlatformType)platformType
                               contentType:(SSDKContentType)contentType
                                     share:(JwShare *)shareModel {
    
    if (contentType == SSDKContentTypeMiniProgram) {
        JwShare_WeChatMiniProgram *share = (JwShare_WeChatMiniProgram *)shareModel;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param SSDKSetupWeChatMiniProgramShareParamsByTitle:share.title
                                                description:share.description_f
                                                 webpageUrl:share.webpageUrl
                                                       path:share.path
                                                 thumbImage:share.thumbImage
                                               hdThumbImage:share.hdThumbImage
                                                   userName:share.userName
                                            withShareTicket:share.withShareTicket
                                            miniProgramType:share.miniProgramType
                                         forPlatformSubType:platformType];
        return param;
        
    }else{
        JwShare *share = (JwShare *)shareModel;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param SSDKSetupShareParamsByText:share.text images:share.images url:share.url title:share.title type:contentType];
        return param;
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

/** 分享结果
 */
+ (void)showShareResult:(SSDKResponseState)state
             completion:(void(^)(BOOL success, NSError *error))completion{
    
    BOOL isSuccess = NO;
    NSString *tip = nil;
    
    switch (state) {
        case SSDKResponseStateBegin:
            break;
        case SSDKResponseStateSuccess:{
            isSuccess = YES;
            tip = @"分享成功";
            break;
        }
        case SSDKResponseStateFail:{
            isSuccess = NO;
            tip = @"分享失败";
            break;
        }
        case SSDKResponseStateCancel:{
            isSuccess = NO;
            tip = @"分享取消";
            break;
        }
            
        default:
            break;
    }
    
    NSError *error = [NSError errorWithDomain:tip code:0 userInfo:nil];
    if (completion) {
        completion(isSuccess, error);
    }
}








@end
