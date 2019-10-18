//
//  UIBarButtonItem+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIBarButtonItem+JwCate.h"
#import "NSString+JwCate.h"
#import "UIView+JwCate.h"

@implementation UIBarButtonItem (JwCate)

+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateHighlighted)];
    
    btn.jw_size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image size:(CGSize)size{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if (@available(iOS 9.0, *)) {
        [btn.widthAnchor constraintEqualToConstant:size.width].active = YES;
        [btn.heightAnchor constraintEqualToConstant:size.height].active = YES;
    }
    
    btn.jw_size = size;
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateHighlighted)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color image:(NSString *)image{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateHighlighted)];
    }
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    
    CGFloat space = 5;
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, - space);
    
    CGSize imgSize = btn.currentImage.size;
    UIFont *font = btn.titleLabel.font;
    CGFloat labw = [btn.currentTitle jw_widthForLabelHeight:imgSize.height fontsize:(int)font.pointSize];
    btn.jw_size = CGSizeMake(imgSize.width + labw + space, imgSize.height);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
