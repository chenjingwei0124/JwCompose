//
//  JwDataService.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseService.h"
#import "JwClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwDataService : JwBaseService

/** 分类 /api/app/firstEntry
 */
- (void)firstEntrySuccess:(void (^)(NSMutableArray *entrys, id data))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
