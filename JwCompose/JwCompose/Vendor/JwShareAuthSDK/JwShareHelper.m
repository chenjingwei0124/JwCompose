
//
//  JwShareHelper.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/11/30.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwShareHelper.h"
#import "JwShareAuthHeader.h"
#import <MOBFoundation/MobSDK+Privacy.h>


@implementation JwShareHelper

+ (void)share{
    
    [MobSDK uploadPrivacyPermissionStatus:YES onResult:^(BOOL success) {

    }];
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
#ifdef IMPORT_SINA_WEIBO
        [platformsRegister setupSinaWeiboWithAppkey:MOBSSDKSinaWeiboAppKey appSecret:MOBSSDKSinaWeiboAppSecret redirectUrl:MOBSSDKUniversalLink];
#endif
        
#if defined IMPORT_SUB_QQ
        [platformsRegister setupQQWithAppId:MOBSSDKQQAppID appkey:MOBSSDKQQAppKey enableUniversalLink:YES universalLink:MOBSSDKUniversalLink];
#endif
        
#if defined IMPORT_SUB_Wechat
        [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:MOBSSDKWeChatAppSecret universalLink:MOBSSDKUniversalLink];
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

+ (void)shareUIWithContentType:(SSDKContentType)contentType
                          share:(JwShare *)share
                     completion:(void(^)(BOOL success, NSError *error))completion{
    
    NSMutableDictionary *params = nil;
    params = [self setupPlatformType:SSDKPlatformTypeUnknown contentType:contentType share:share];
    
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    //设置分享菜单为简洁样式
    config.style = SSUIActionSheetStyleSystem;
    //设置竖屏有多少个item平台图标显示
    config.columnPortraitCount = 5;
    //设置取消按钮标签文本颜色
    config.cancelButtonTitleColor = JwColorHexString(@"#999999");
    //设置标题文本颜色
    config.itemTitleColor = JwColorHexString(@"#666666");
    //设置分享菜单栏状态栏风格
    config.statusBarStyle = UIStatusBarStyleLightContent;

    NSArray *customItems = @[@(SSDKPlatformSubTypeWechatSession),
                             @(SSDKPlatformSubTypeWechatTimeline),
                             @(SSDKPlatformTypeSinaWeibo),
                             @(SSDKPlatformSubTypeQQFriend),
                             @(SSDKPlatformSubTypeQZone)];

    if (params.count == 0) {
        DLog(@"请先设置分享参数");
        return;
    }
    Weak(self);
    //弹出分享菜单
    [ShareSDK showShareActionSheet:nil
                       customItems:customItems
                       shareParams:params
                sheetConfiguration:config
                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        [wself showShareResult:state completion:completion];
    }];
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

/**
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
 分享结果
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
