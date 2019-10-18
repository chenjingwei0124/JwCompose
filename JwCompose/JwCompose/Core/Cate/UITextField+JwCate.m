//
//  UITextField+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UITextField+JwCate.h"

@implementation UITextField (JwCate)
/**
 *  设置placeholder 颜色
 */
- (void)jw_setupPlaceholderAttributedWithColor:(UIColor *)color text:(NSString *)text{
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text
                                                               attributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:self.font}];
    self.attributedPlaceholder = attr;
}

@end
