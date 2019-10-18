//
//  UIViewController+JwCate.m
//  renrenying
//
//  Created by 陈警卫 on 2019/2/26.
//  Copyright © 2019年 陈警卫. All rights reserved.
//

#import "UIViewController+JwCate.h"

@implementation UIViewController (JwCate)

- (UIViewController *)jw_viewControllerForNavigationControllersWithClassString:(NSString *)classString{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(classString)]) {
            return controller;
        }
    }
    return nil;
}

@end
