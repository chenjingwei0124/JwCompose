//
//  JwAmountTextField.h
//  Jst_ios
//
//  Created by 陈警卫 on 2018/6/11.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 金额输入框
 显示¥94,862.57格式 自输入小数点 小数点后仅且只有两位小数
 */
@interface JwAmountTextField : UITextField

@property (nonatomic, strong) NSString *amount;

@end
