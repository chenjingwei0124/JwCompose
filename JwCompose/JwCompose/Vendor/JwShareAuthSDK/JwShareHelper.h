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
#import <ShareSDKUI/ShareSDKUI.h>

@interface JwShareHelper : NSObject

+ (void)share;

/** 分享 */
+ (void)shareWithPlatformType:(SSDKPlatformType)platformType
                  contentType:(SSDKContentType)contentType
                        share:(JwShare *)share
                   completion:(void(^)(BOOL success, NSError *error))completion;
/** 分享UI */
+ (void)shareUIWithContentType:(SSDKContentType)contentType
                         share:(JwShare *)share
                    completion:(void(^)(BOOL success, NSError *error))completion;


@end
