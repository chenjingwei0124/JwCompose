//
//  JwLocalCenter.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseModel.h"
#import "JwUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwLocalCenter : JwBaseModel

@property (nonatomic, strong) JwUserModel *userModel;
@property (nonatomic, assign) BOOL isLogined;

+ (instancetype)shared;
+ (instancetype)read;
- (void)save;
@end

NS_ASSUME_NONNULL_END
