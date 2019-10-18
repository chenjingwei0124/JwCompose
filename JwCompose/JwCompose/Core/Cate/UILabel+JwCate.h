//
//  UILabel+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/12/12.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JwCate)

/**
 自适应宽度

 @return 宽度
 */
- (CGFloat)jw_auto_width;

/**
 自适应高度

 @return 高度
 */
- (CGFloat)jw_auto_height;

/**
 自适应尺寸

 @return 尺寸
 */
- (CGSize)jw_auto_size;

/** 获取label中内容的行数和每一行的内容 */
- (NSArray *)jw_getLinesArrayOfStringInLabel;

@end
