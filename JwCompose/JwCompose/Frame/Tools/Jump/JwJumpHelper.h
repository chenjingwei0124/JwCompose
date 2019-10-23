//
//  JwJumpHelper.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/21.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwJumpHelper : NSObject

+ (Class)classViewControllerWithJumpModel:(JwJumpModel *)jumpModel;
+ (JwBaseViewController *)viewControllerWithJumpModel:(JwJumpModel *)jumpModel;

+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel;
+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromView:(UIView * __nullable)fromView;
+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromVC:(UIViewController * __nullable)fromVC;
+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromNC:(UINavigationController * __nullable)fromNC;

@end

NS_ASSUME_NONNULL_END
 
