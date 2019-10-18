//
//  UIBarButtonItem+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JwCate)

+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image;
+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image size:(CGSize)size;
+ (UIBarButtonItem *)jw_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color image:(NSString *)image;

@end
