//
//  JwJumpModel.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/21.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwJumpModel : JwBaseModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) id<Ignore> jw_data;

@end

NS_ASSUME_NONNULL_END
