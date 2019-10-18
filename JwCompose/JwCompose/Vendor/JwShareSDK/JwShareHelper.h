//
//  JwShareHelper.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/11/30.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwShareModel.h"
#import <ShareSDK/ShareSDK.h>

//#define IMPORT_SINA_WEIBO //注释此行则 不开启【 新浪微博 】平台
//#define IMPORT_SUB_QQFriend //注释此行则 不开启【 QQ好友 】平台
//#define IMPORT_SUB_QZone //注释此行则 不开启【 QQ空间 】平台
#define IMPORT_SUB_WechatSession //注释此行则 不开启【 微信好友 】平台
#define IMPORT_SUB_WechatTimeline //注释此行则 不开启【 微信朋友圈 】平台
//#define IMPORT_SUB_WechatFav //注释此行则 不开启【 微信收藏 】平台

/**
 以下为各平台的相关参数设置
 */
#pragma mark - 新浪微博配置信息
/*
 info.plist 中需要设置 白名单 LSApplicationQueriesSchemes
 <string>sinaweibosso</string>
 <string>weibo</string>
 <string>weibosdk</string>
 <string>weibosdk2.5</string>
 <string>sinaweibo</string>
 <string>sinaweibohd</string>
 
 info.plist 中需要设置 URL Schemes
 规则 wb+AppKey 例：wb568898243
 
 Other Linker Flags 需设置 -ObjC
 
 授权：应用内web 客户端SSO
 
 可以通过以下方法进行权限添加
 - (void)SSDKSetAuthSettings:(NSArray *)authSettings
 
 v4.0.1 默认不再区分客户端或web分享  有客户端则优先使用客户端进行分享 无客户端则调用微博SDK内置分享页面进行分享
 SDK：文字 文字+图片 链接 注：为安装客户端
 api：文字 文字+图片 注：文字中需要附安全域链接 安全域需要在微博开放平台设置 并不能分享话题 通过设置参数时设置 SSDKEnableSinaWeiboAPIShare 启动
 
 v4.0.4
 1、视频分享只支持本地视频分享
 2、多张图片分享并开启story分享的话，默认取第一张图
 
 分享详例：MOBSinaWeiboViewController
 
 开放平台地址： http://open.weibo.com
 */

#ifdef IMPORT_SINA_WEIBO
//AppKey
#define MOBSSDKSinaWeiboAppKey @"568898243"
//AppSecret
#define MOBSSDKSinaWeiboAppSecret @"38a4f8204cc784f81f9f0daaf31e02e3"
//RedirectUri
#define MOBSSDKSinaWeiboRedirectUri @"http://www.sharesdk.cn"
//AuthType 授权优先类型 web sso both
#define MOBSSDKSinaWeiboAuthType SSDKAuthorizeTypeBoth
#endif


#pragma mark - QQ平台的配置信息
/*
 info.plist 中需要设置 白名单 LSApplicationQueriesSchemes
 <string>mqq</string>
 <string>mqqapi</string>
 <string>mqqwpa</string>
 <string>mqqbrowser</string>
 <string>mttbrowser</string>
 <string>mqqOpensdkSSoLogin</string>
 <string>mqqopensdkapiV2</string>
 <string>mqqopensdkapiV3</string>
 <string>mqqopensdkapiV4</string>
 <string>wtloginmqq2</string>
 <string>mqzone</string>
 <string>mqzoneopensdk</string>
 <string>mqzoneopensdkapi</string>
 <string>mqzoneopensdkapi19</string>
 <string>mqzoneopensdkapiV2</string>
 <string>mqqapiwallet</string>
 <string>mqqopensdkfriend</string>
 <string>mqqopensdkdataline</string>
 <string>mqqgamebindinggroup</string>
 <string>mqqopensdkgrouptribeshare</string>
 <string>tencentapi.qq.reqContent</string>
 <string>tencentapi.qzone.reqContent</string>
 <string>tim</string>
 <string>timapi</string>
 <string>timopensdkfriend</string>
 <string>timwpa</string>
 <string>timgamebindinggroup</string>
 <string>timapiwallet</string>
 <string>timOpensdkSSoLogin</string>
 <string>wtlogintim</string>
 <string>timopensdkgrouptribeshare</string>
 <string>timopensdkapiV4</string>
 <string>timgamebindinggroup</string>
 <string>timopensdkdataline</string>
 <string>wtlogintimV1</string>
 <string>timapiV1</string>
 
 info.plist 中需要设置 URL Schemes
 规则 tencent+AppKey 例：tencent100371282
 
 授权：客户端SSO 未安装客户端则会使用应用内web
 
 分享：仅客户端 QQ好友 文字 图片 链接 音乐链接 视频链接
 QQ空间 文字 图片 链接 相册视频
 
 分享详例：MOBQQViewController MOBQZoneViewController
 
 开放平台地址： http://open.qq.com
 */
#if (defined IMPORT_SUB_QQFriend) || (defined IMPORT_SUB_QZone)
//AppID
#define MOBSSDKQQAppID @"1105338247"
//AppKey
#define MOBSSDKQQAppKey @"9bQpwegPPt4gkMjK"
//AuthType
#define MOBSSDKQQAuthType SSDKAuthorizeTypeBoth
//useTIM 是否优先使用TIM客户端
#define MOBSSDKQQUseTIM YES
//是否默认返回 UnionID v4.0.2增加
#define MOBSSDKQQBackUnionID NO
#endif


#pragma mark - 微信平台的配置信息
/*
 info.plist 中需要设置 白名单 LSApplicationQueriesSchemes
 <string>weixin</string>
 
 info.plist 中需要设置 URL Schemes
 规则 appID 例：wx4868b35061f87885
 
 Other Linker Flags 需设置 -ObjC
 
 授权：客户端SSO 未安装客户端则会使用应用内web
 
 分享：仅客户端 微信好友 文字 图片 链接 音乐链接 视频链接 应用消息 表情 文件[本地视频] 小程序
 微信朋友圈 文字 图片 链接 音乐链接 视频链接
 微信收藏 文字 图片 链接 音乐链接 视频链接 文件[本地视频]
 
 分享详例：MOBWechatcontactsViewController MOBWechatmomentsViewController MOBWechatfavoritesViewController
 
 开放平台地址： https://open.weixin.qq.com
 */
#if (defined IMPORT_SUB_WechatSession) || (defined IMPORT_SUB_WechatTimeline) || (defined IMPORT_SUB_WechatFav)
//AppID
#define MOBSSDKWeChatAppID @"wx492d8e2064d748b1"
//AppSecret
#define MOBSSDKWeChatAppSecret @"c9cfb73dc06b609266a62657b4b1e082"
#endif

@interface JwShareHelper : NSObject

+ (void)share;

/** 分享 */
+ (void)shareWithPlatformType:(SSDKPlatformType)platformType
                  contentType:(SSDKContentType)contentType
                        share:(JwShare *)share
                   completion:(void(^)(BOOL success, NSError *error))completion;

/**
 授权登录
 微信需要AppSecret 正常
 微信没有AppSecret SSDKUser uid == authCode
 [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:nil];
 */
+ (void)authorizeWithPlatformType:(SSDKPlatformType)platformType success:(void(^)(SSDKUser *user, NSError *error))success;


@end
