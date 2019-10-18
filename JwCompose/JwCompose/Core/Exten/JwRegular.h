//
//  JwRegular.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/17.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwRegular : NSObject
/** 判断是否包含中文符号*/
+ (BOOL)validateChinaSymbols:(NSString *)str first:(BOOL)first;

/** 验证登录密码 6-16位*/
+ (BOOL)validateLoginPassword:(NSString *)str;
/** 验证姓名*/
+ (BOOL)validateNameString:(NSString *)str;

/** 验证数字*/
+ (BOOL)validateNumber:(NSString*)str;
/** 验证数字*/
+ (BOOL)validateNumberWithString:(NSString *)str;
/** 验证数字和小数点*/
+ (BOOL)validateNumberPoint:(NSString*)str;
/** 验证金额格式 小数点后一位或两位*/
+ (BOOL)validateAmount:(NSString *)str;
/** 验证邮箱*/
+ (BOOL)validateEmail:(NSString *)str;
/** 验证手机号码*/
+ (BOOL)validatePhone:(NSString *)str;
/** 验证邮政编码*/
+ (BOOL)validateZipcode:(NSString *)str;
/** 验证固定号码 不带有"-"*/
+ (BOOL)validateTelephone:(NSString *)str;
/** 验证固定号码 带有"-"*/
+ (BOOL)validateTelephoneFormat:(NSString *)str;
/** 验证中文字 20个字内*/
+ (BOOL)validateChinese:(NSString *)str;
/** 简单验证身份证*/
+ (BOOL)validateIDCard:(NSString *)str;
/** 身份证*/
+ (BOOL)validateIdentityCard:(NSString *)str;
/** 验证银行卡*/
+ (BOOL)validateBankCarNum:(NSString *)str;
/** 密码验证 YES表示同时包含数字和英文字符*/
+ (BOOL)validatePassword:(NSString *)str;
/** 只包含数字和字母的密码，固定位数*/
+ (BOOL)validateContainLetterAndNumWithMaxChars:(NSInteger)max minChars:(NSInteger)min str:(NSString *)str;

@end
