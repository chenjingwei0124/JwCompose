//
//  UITextField+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JwCate)
/**
 *  设置placeholder 颜色
 */
- (void)jw_setupPlaceholderAttributedWithColor:(UIColor *)color text:(NSString *)text;

@end
