//
//  NSString+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "NSString+JwCate.h"

@implementation NSString (JwCate)

/** 获取字符串高度 */
- (CGFloat)jw_heightForLabelWidth:(CGFloat)width fontsize:(CGFloat)fontsize {
    CGFloat height = [self jw_heightForLabelWidth:width font:[UIFont systemFontOfSize:fontsize]];
    return height;
}

/** 获取字符串高度 */
- (CGFloat)jw_heightForLabelWidth:(CGFloat)width font:(UIFont *)font{
    CGSize expectSize = CGSizeMake(width, MAXFLOAT);
    CGSize size = [self jw_sizeForFont:font expectSize:expectSize lineBreakMode:(NSLineBreakByWordWrapping)];
    return size.height;
}

/** 获取字符串宽度 */
- (CGFloat)jw_widthForLabelHeight:(CGFloat)height fontsize:(CGFloat)fontsize{
    CGFloat width = [self jw_widthForLabelHeight:height font:[UIFont systemFontOfSize:fontsize]];
    return width;
}

/** 获取字符串宽度 */
- (CGFloat)jw_widthForLabelHeight:(CGFloat)height font:(UIFont *)font{
    CGSize expectSize = CGSizeMake(MAXFLOAT, height);
    CGSize size = [self jw_sizeForFont:font expectSize:expectSize lineBreakMode:(NSLineBreakByWordWrapping)];
    return size.width;
}

/** 获取字符串尺寸 */
- (CGSize)jw_sizeForFont:(UIFont *)font expectSize:(CGSize)expectSize lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    if (!font) {
        font = [UIFont systemFontOfSize:12];
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    
    CGRect rect = [self boundingRectWithSize:expectSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

/** 自定义正数格式(金额的格式转化) 94,862.57 */
+ (NSString *)jw_stringChangeMoneyWithStr:(NSString *)str {
    
    //判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //正数格式 前缀可在所需地方随意添加
    formatter.positiveFormat = @",###.##";
    //注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    
    return money;
}

/**
 中国正数格式(金额的格式转化) ￥94,862.57这样的形式
 金额的格式转化 ￥94,862.57这样的形式
 */
+ (NSString *)jw_stringChangeCNMoneyWithStr:(NSString *)str {
    
    //判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-cn"];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle; //94,862.57这样的形式
    
    //注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    //iOS11之后kCFNumberFormatterCurrencyStyle 前缀变成了CN￥不是￥.这里选择使用kCFNumberFormatterDecimalStyle然后拼接￥符号
    money = [NSString stringWithFormat:@"%@", money];
    
    return money;
}

/**
 * 金额的格式转化
 * str : 金额的字符串
 * numberStyle : 金额转换的格式
 * return  NSString : 转化后的金额格式字符串
 
 * NSNumberFormatter类有个属性numberStyle，是一个枚举型，设置不同的值可以输出不同的数字格式。该枚举包括：
 * 94863
 * NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle,
 
 * 94,862.57
 * NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,
 
 * ￥94,862.57
 * NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle,
 
 * 9,486,257%
 * NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,
 
 * 9.486257E4
 * NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,
 
 * 九万四千八百六十二点五七
 * NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle
 */
+ (NSString *)jw_stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle {
    
    // 判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = numberStyle;
    
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    
    return money;
}

/** 银行卡号格式显示 */
- (NSString *)jw_stringBankCardNumberFormat {
    NSString *str = self;
    NSInteger groupSize = 4;
    NSInteger groupCount = (NSInteger)ceilf((CGFloat)str.length/groupSize);
    
    NSMutableArray *components = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*groupSize + groupSize > str.length) {
            [components addObject:[str substringFromIndex:i*groupSize]];
        } else {
            [components addObject:[str substringWithRange:NSMakeRange(i*groupSize, groupSize)]];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:@" "];
    return groupedString;
}

/** 银行卡号格式加密显示 */
- (NSString *)jw_stringBankCardNumberEncryptFormat{
    NSString *str = self;
    NSInteger groupSize = 4;
    NSInteger groupCount = (NSInteger)ceilf((CGFloat)str.length/groupSize);
    
    NSMutableArray *components = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*groupSize + groupSize > str.length) {
            [components addObject:[str substringFromIndex:i*groupSize]];
        } else {
            [components addObject:@"****"];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:@"    "];
    return groupedString;
}

/** 数字过大格式转化 */
- (NSString *)jw_changeAmountAsset{
    NSString *amountStr = self;
    if(amountStr && ![amountStr isEqualToString:@""]){
        NSInteger num = [amountStr integerValue];
        if(num >= 1000000000000){
            NSString *str = [NSString stringWithFormat:@"%.1f",num/1000000000000.0];
            return[NSString stringWithFormat:@"%@万亿",str];
        }else if(num >= 100000000){
            NSString *str = [NSString stringWithFormat:@"%.1f",num/100000000.0];
            return[NSString stringWithFormat:@"%@亿",str];
        }else if(num >= 10000000){
            NSString *str = [NSString stringWithFormat:@"%.1f",num/10000000.0];
            return [NSString stringWithFormat:@"%@千万",str];
        }else if(num >= 10000){
            NSString *str = [NSString stringWithFormat:@"%.1f",num/10000.0];
            return [NSString stringWithFormat:@"%@万",str];
        }
    }
    return amountStr;
}


@end
