//
//  UIView+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIView+JwCate.h"

@implementation UIView (JwCate)

- (CGFloat)jw_x{
    return self.frame.origin.x;
}

- (void)setJw_x:(CGFloat)jw_x{
    CGRect frame = self.frame;
    frame.origin.x = jw_x;
    self.frame = frame;
}

- (CGFloat)jw_y{
    return self.frame.origin.y;
}

- (void)setJw_y:(CGFloat)jw_y{
    CGRect frame = self.frame;
    frame.origin.y = jw_y;
    self.frame = frame;
}

- (CGFloat)jw_right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJw_right:(CGFloat)jw_right{
    CGRect frame = self.frame;
    frame.size.width = jw_right - frame.origin.x;
    self.frame = frame;
}

- (CGFloat)jw_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJw_bottom:(CGFloat)jw_bottom{
    CGRect frame = self.frame;
    frame.size.height = jw_bottom - frame.origin.y;
    self.frame = frame;
}

- (CGFloat)jw_right_x{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJw_right_x:(CGFloat)jw_right_x{
    CGRect frame = self.frame;
    frame.origin.x = jw_right_x - frame.size.width;
    self.frame = frame;
}

- (CGFloat)jw_bottom_y{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJw_bottom_y:(CGFloat)jw_bottom_y{
    CGRect frame = self.frame;
    frame.origin.y = jw_bottom_y - frame.size.height;
    self.frame = frame;
}

- (CGFloat)jw_width{
    return self.frame.size.width;
}

- (void)setJw_width:(CGFloat)jw_width{
    CGRect frame = self.frame;
    frame.size.width = jw_width;
    self.frame = frame;
}

- (CGFloat)jw_height{
    return self.frame.size.height;
}

- (void)setJw_height:(CGFloat)jw_height{
    CGRect frame = self.frame;
    frame.size.height = jw_height;
    self.frame = frame;
}

- (CGFloat)jw_width_r{
    return self.frame.size.width;
}

- (void)setJw_width_r:(CGFloat)jw_width_r{
    CGRect frame = self.frame;
    frame.origin.x = frame.origin.x - (jw_width_r - frame.size.width);
    frame.size.width = jw_width_r;
    self.frame = frame;
}

- (CGFloat)jw_height_b{
    return self.frame.size.height;
}

- (void)setJw_height_b:(CGFloat)jw_height_b{
    CGRect frame = self.frame;
    frame.origin.y = frame.origin.y - (jw_height_b - frame.size.height);
    frame.size.width = jw_height_b;
    self.frame = frame;
}

- (CGFloat)jw_centerX{
    return self.center.x;
}

- (void)setJw_centerX:(CGFloat)jw_centerX{
    self.center = CGPointMake(jw_centerX, self.center.y);
}

- (CGFloat)jw_centerY{
    return self.center.y;
}

- (void)setJw_centerY:(CGFloat)jw_centerY{
    self.center = CGPointMake(self.center.x, jw_centerY);
}

- (CGPoint)jw_origin{
    return self.frame.origin;
}

- (void)setJw_origin:(CGPoint)jw_origin{
    CGRect frame = self.frame;
    frame.origin = jw_origin;
    self.frame = frame;
}

- (CGSize)jw_size{
    return self.frame.size;
}

- (void)setJw_size:(CGSize)jw_size{
    CGRect frame = self.frame;
    frame.size = jw_size;
    self.frame = frame;
}

- (UIViewController *)jw_viewController{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (UINavigationController *)jw_navigationController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}

- (UITabBarController *)jw_tabBarController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITabBarController class]]) {
            return (UITabBarController *)nextResponder;
        }
    }
    return nil;
}

/** 固定角圆角 */
- (void)jw_bezierRoundingCorners:(UIRectCorner)corners cornerRadius:(NSInteger)cornerRadius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
