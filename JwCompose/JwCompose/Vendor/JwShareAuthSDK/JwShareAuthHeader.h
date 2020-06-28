
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
#define MOBSSDKUniversalLink @"https://api-sip.510gow.com/"

#pragma mark - 新浪微博配置信息
/** 开放平台地址： http://open.weibo.com */

#ifdef IMPORT_SINA_WEIBO
//AppKey
#define MOBSSDKSinaWeiboAppKey @"3389791131"
//AppSecret
#define MOBSSDKSinaWeiboAppSecret @"bbaff4a5083d6097f74703e4e5cc4dbd"
#endif


#pragma mark - QQ平台的配置信息
/** 开放平台地址： http://open.qq.com */

#if defined IMPORT_SUB_QQ
//AppID
#define MOBSSDKQQAppID @"1110514410"
//AppKey
#define MOBSSDKQQAppKey @"exJOpwcUQ9SiXGFX"
#endif


#pragma mark - 微信平台的配置信息
/** 开放平台地址： https://open.weixin.qq.com */
#if defined IMPORT_SUB_Wechat
//AppID
#define MOBSSDKWeChatAppID @"wx302098a58b772f43"
//AppSecret
#define MOBSSDKWeChatAppSecret @"548dc9625d6d6a265c6d13d2954b9c71"
#endif

#endif /* JwShareAuthHeader_h */

