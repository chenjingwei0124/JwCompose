//
//  JwAuthHelper.h
//  JwPart
//
//  Created by 陈警卫 on 2020/5/7.
//  Copyright © 2020 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuthBlock)(BOOL success, NSString *wxCode);

@interface JwAuthHelper : NSObject

@property (nonatomic, strong) JwAuthHelper *authHelper;

//单例
+ (JwAuthHelper *)singleAuth;

//注册
+ (void)auth;
+ (void)authWithAppId:(NSString *)appId;

//处理回调
+ (BOOL)handleOpenURL:(NSURL *)url;
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;

//微信授权登录
+ (void)sendAuthWithScope:(NSString *)scope state:(NSString *)state completion:(AuthBlock)completion;

/**
 ShareSDK微信授权登录
 微信需要AppSecret 正常
 微信没有AppSecret SSDKUser uid == authCode
 [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:nil];
 */
+ (void)authorizeWithPlatformType:(SSDKPlatformType)platformType success:(void(^)(SSDKUser *user, NSError *error))success;

//拉起小程序
+ (void)wakeupWeChatMiniProgramWithUserName:(NSString *)userName path:(NSString *)path type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
