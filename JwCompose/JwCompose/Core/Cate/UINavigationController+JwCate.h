//
//  UINavigationController+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/12/5.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (JwCate)

/**
 当前导航控制器
 @return 导航控制器
 */
+ (UINavigationController *)jw_currentNC;

/** 当前导航控制器 */
+ (UINavigationController *)jw_getCurrentNCFrom:(UIViewController *)vc;

@end
