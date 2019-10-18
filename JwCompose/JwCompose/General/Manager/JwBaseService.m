//
//  JwBaseService.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseService.h"

@implementation JwBaseService

- (JwHttpManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [JwHttpManager sharedManager];
    }
    return _httpManager;
}

//处理节点
- (NSString *)nodePoint:(NSString *)point{
    return [NSString stringWithFormat:@"%@%@", kServiceBasePoint, point];
}
//默认参数
- (NSMutableDictionary *)defaultParam:(NSDictionary *)param{
    NSMutableDictionary *defaultParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    defaultParam[@"devicetype"] = @"iOS";
    defaultParam[@"deviceid"] = [JwUUID jw_uuidDeviceString];
    defaultParam[@"devicemode"] = [JwiPhoneType jw_iPhoneType];
    defaultParam[@"timestamp"] = [JwCommon jw_commonTimestampString];
    defaultParam[@"osver"] = [JwCommon jw_commonSystemVersionString];
    defaultParam[@"appver"] = [JwCommon jw_commonVersionString];
    
    return defaultParam;
}
//签名参数
- (NSMutableDictionary *)signParam:(NSDictionary *)param{
    NSMutableString *signString = [NSMutableString string];
    NSMutableDictionary *signParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    NSArray *keyArray = [signParam allKeys];
    //通过key获取相应的 "key=value"
    NSMutableArray *keyValueArray = [NSMutableArray array];
    
    for (NSString *keyStr in keyArray) {
        NSString *valueStr = [signParam objectForKey:keyStr];
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@", keyStr, valueStr];
        [keyValueArray addObject:keyValueStr];
    }
    [keyValueArray addObject:kServiceBlur];
    
    //按照字母升序排列
    NSArray *afterSortedKeyValueArray = [keyValueArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //升序
        NSComparisonResult result = [obj1 compare:obj2 options:NSLiteralSearch];
        return result;
    }];
    
    [afterSortedKeyValueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [signString appendString:obj];
    }];
    
    DLog(@"sign--%@", signString);
    signParam[@"sign"] = [signString md5String];
    return signParam;
}

@end
