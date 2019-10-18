//
//  JwHttpHelper.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwHttpHelper.h"

@implementation JwHttpHelper

/** 判断正确的请求 */
+ (BOOL)httpManager:(JwHttpManager *)manager shouldSuccessWithResponse:(id)response{
    NSDictionary *result = response;
    if ([result[@"code"] integerValue] == kHttpCodeSuccess) {
        return YES;
    }else{
        NSError *error = [NSError errorWithDomain:(result[@"msg"] ?: @"未知数据错误")
                                             code:[result[@"code"] integerValue]
                                         userInfo:result];
        [JwHttpHelper httpManager:manager didResultWithResponse:response error:error];
        return NO;
    }
}

/** 接口错误统一处理 */
+ (void)httpManager:(JwHttpManager *)manager didResultWithResponse:(id)response error:(NSError *)error;{
    if (error && response == nil) {
        //[JwProgressHelper showError:error.domain];
        [JwProgressHelper showError:@"网络出问题啦"];
    }else if(error) {
        [JwProgressHelper showError:error.domain];
    }
}

@end
