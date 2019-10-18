//
//  JwBaseService.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwHttpManager.h"
#import "JwServiceDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwBaseService : NSObject

@property (nonatomic, strong) JwHttpManager *httpManager;

//处理节点
- (NSString *)nodePoint:(NSString *)point;
//默认参数
- (NSMutableDictionary *)defaultParam:(NSDictionary *)param;
//签名参数
- (NSMutableDictionary *)signParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
