//
//  JwJumpHelper.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/21.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwJumpHelper.h"

@implementation JwJumpHelper

+ (Class)classViewControllerWithJumpModel:(JwJumpModel *)jumpModel{
    NSString *routePath = [[NSBundle mainBundle] pathForResource:@"JwJumpRoute" ofType:@"plist"];
    NSDictionary *routeValue = [NSDictionary dictionaryWithContentsOfFile:routePath];
    
    id value = routeValue[jumpModel.type];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return NSClassFromString(value[@"name"]);
    }
    return nil;
}

+ (JwBaseViewController *)viewControllerWithJumpModel:(JwJumpModel *)jumpModel{
    Class vcClass = [JwJumpHelper classViewControllerWithJumpModel:jumpModel];
    JwBaseViewController *vc = [[vcClass alloc] init];
    vc.jumpModel = jumpModel;
    return vc;
    
}

+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel{
    JwBaseViewController *vc = [JwJumpHelper jumpHelperWithJumpModel:jumpModel fromNC:nil];
    return vc;
}

+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromView:(UIView *)fromView{
    UINavigationController *nc = fromView.jw_navigationController;
    JwBaseViewController *vc = [JwJumpHelper jumpHelperWithJumpModel:jumpModel fromNC:nc];
    return vc;
}

+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromVC:(UIViewController *)fromVC{
    UINavigationController *nc = fromVC.navigationController;
    if (!nc) {
        nc = [UINavigationController jw_getCurrentNCFrom:fromVC];
    }
    JwBaseViewController *vc = [JwJumpHelper jumpHelperWithJumpModel:jumpModel fromNC:nc];
    return vc;
}

+ (JwBaseViewController *)jumpHelperWithJumpModel:(JwJumpModel *)jumpModel fromNC:(UINavigationController *)fromNC{
    JwBaseViewController *vc = [JwJumpHelper viewControllerWithJumpModel:jumpModel];
    if (!fromNC) {
        fromNC = kJwRootNavigationVC;
    }
    if (![fromNC isKindOfClass:[UINavigationController class]]) {
        fromNC = [UINavigationController jw_currentNC];
    }
    [fromNC pushViewController:vc animated:YES];
    return vc;
}

@end
