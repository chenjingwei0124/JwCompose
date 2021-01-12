
//
//  JwShareAuthHeader.h
//  JwPart
//
//  Created by 陈警卫 on 2020/5/7.
//  Copyright © 2020 陈警卫. All rights reserved.
//

#ifndef JwShareAuthHeader_h
#define JwShareAuthHeader_h

#define IMPORT_SINA_WEIBO //注释此行则 不开启【 新浪微博 】平台
#define IMPORT_SUB_QQ //注释此行则 不开启【 QQ 】平台
#define IMPORT_SUB_Wechat //注释此行则 不开启【 微信 】平台

/** 以下为各平台的相关参数设置 */

//UniversalLink
#define MOBSSDKUniversalLink @""

#pragma mark - 新浪微博配置信息
/** 开放平台地址： http://open.weibo.com */

#ifdef IMPORT_SINA_WEIBO
//AppKey
#define MOBSSDKSinaWeiboAppKey @""
//AppSecret
#define MOBSSDKSinaWeiboAppSecret @""
#endif


#pragma mark - QQ平台的配置信息
/** 开放平台地址： http://open.qq.com */

#if defined IMPORT_SUB_QQ
//AppID
#define MOBSSDKQQAppID @""
//AppKey
#define MOBSSDKQQAppKey @""
#endif


#pragma mark - 微信平台的配置信息
/** 开放平台地址： https://open.weixin.qq.com */
#if defined IMPORT_SUB_Wechat
//AppID
#define MOBSSDKWeChatAppID @""
//AppSecret
#define MOBSSDKWeChatAppSecret @""
#endif

#endif /* JwShareAuthHeader_h */

