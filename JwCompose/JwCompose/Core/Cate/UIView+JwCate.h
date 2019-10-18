//
//  UIView+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JwCate)

@property (nonatomic, assign) CGFloat jw_x;
@property (nonatomic, assign) CGFloat jw_y;

/** 固定控件x值赋值右边值 取值右边值*/
@property (nonatomic, assign) CGFloat jw_right;
/** 固定控件y值赋值右边值 取值右边值*/
@property (nonatomic, assign) CGFloat jw_bottom;

/** 固定控件宽度赋值右边值 取值右边值*/
@property (nonatomic, assign) CGFloat jw_right_x;
/** 固定控件高度赋值下边值 取值下边值*/
@property (nonatomic, assign) CGFloat jw_bottom_y;

@property (nonatomic, assign) CGFloat jw_width;
@property (nonatomic, assign) CGFloat jw_height;

/** 固定控件右边赋值宽度 取值宽度 */
@property (nonatomic, assign) CGFloat jw_width_r;
/** 固定控件底边赋值高度 取值高度 */
@property (nonatomic, assign) CGFloat jw_height_b;

@property (nonatomic, assign) CGFloat jw_centerX;
@property (nonatomic, assign) CGFloat jw_centerY;

@property (nonatomic, assign) CGPoint jw_origin;
@property (nonatomic, assign) CGSize  jw_size;

@property (nonatomic, readonly)UIViewController *jw_viewController;

@property (nonatomic, readonly)UINavigationController *jw_navigationController;

@property (nonatomic, readonly)UITabBarController *jw_tabBarController;

/** 固定角圆角 */
- (void)jw_bezierRoundingCorners:(UIRectCorner)corners cornerRadius:(NSInteger)cornerRadius;


@end
