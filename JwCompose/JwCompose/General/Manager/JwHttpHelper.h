//
//  JwHttpHelper.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwHttpManager.h"
#import "JwServiceDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwHttpHelper : NSObject

/** 判断正确的请求 */
+ (BOOL)httpManager:(JwHttpManager *)manager shouldSuccessWithResponse:(id)response;
/** 接口错误统一处理 */
+ (void)httpManager:(JwHttpManager *)manager didResultWithResponse:(nullable id)response error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
