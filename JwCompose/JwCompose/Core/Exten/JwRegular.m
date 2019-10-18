//
//  JwRegular.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/17.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwRegular.h"

@implementation JwRegular
//判断是否包含中文符号
+ (BOOL)validateChinaSymbols:(NSString *)str first:(BOOL)first{
    NSArray *chainSyms = @[@"，", @"、", @"。", @"？", @"【", @"】", @"{", @"}", @"（", @"）", @"！", @"/“", @"/”", @"：", @"；"];
    if (first) {
        NSString *f = [str substringToIndex:1];
        return [chainSyms containsObject:f];
    }else{
        __block BOOL isCon = NO;
        [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if ([chainSyms containsObject:substring]) {
                isCon = YES;
                return;
            }
        }];
        return isCon;
    }
}

//验证登录密码 6-16位
+ (BOOL)validateLoginPassword:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    if(str.length > 7 && str.length < 17){
        return YES;
    }else{
        return NO;
    }
}

//验证姓名
+ (BOOL)validateNameString:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//验证数字
+ (BOOL)validateNumber:(NSString*)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)validateNumberWithString:(NSString *)str{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}
//验证数字和小数点
+ (BOOL)validateNumberPoint:(NSString*)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789."]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}
//验证金额格式 小数点后一位或两位
+ (BOOL)validateAmount:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^\\d+(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}
//验证邮箱
+ (BOOL)validateEmail:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

//验证手机号码
+ (BOOL)validatePhone:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//验证邮政编码
+ (BOOL)validateZipcode:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^[1-9]\\d{5}｜000000$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//验证固定号码 不带有"-"
+ (BOOL)validateTelephone:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

//验证固定号码 带有"-"
+ (BOOL)validateTelephoneFormat:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}｜((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//验证中文字 20个字内
+ (BOOL)validateChinese:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^[\u4E00-\u9FA5]{1,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//简单验证身份证
+ (BOOL)validateIDCard:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

//身份证
+ (BOOL)validateIdentityCard:(NSString *)str{
    if (![JwRegular validateIDCard:str]) {
        return NO;
    }
    //省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *area = [str substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:area]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return NO;
    }
    ///加权因子
    NSArray *idCardWiArr = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码
    NSArray *idCardYArr = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //15位转18位
    if (str.length == 15) {
        NSMutableString *mstr = [NSMutableString stringWithString:str];
        [mstr insertString:@"19" atIndex:6];
        NSInteger idCardWiSum = 0;
        for(int i = 0; i < 17; i++) {
            NSInteger subStrIndex = [[mstr substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArr objectAtIndex:i] integerValue];
            idCardWiSum += subStrIndex * idCardWiIndex;
        }
        NSInteger idCardMod = idCardWiSum%11;
        [mstr insertString:idCardYArr[idCardMod] atIndex:[mstr length]];
        str = mstr;
    }
    
    //判断生日是否合法
    NSRange range = NSMakeRange(6, 8);
    NSString *datestr = [str substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0; i < 17; i++) {
        NSInteger subStrIndex = [[str substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArr objectAtIndex:i] integerValue];
        idCardWiSum += subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod = idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast = [str substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod == 2) {
        if(![idCardLast isEqualToString:@"X"] || ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArr objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//验证银行卡
+ (BOOL)validateBankCarNum:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    NSString * lastNum = [[str substringFromIndex:(str.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[str substringToIndex:(str.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (long i =(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 == 0) ? YES : NO;
}

//密码验证 YES表示同时包含数字和英文字符
+ (BOOL)validatePassword:(NSString *)str{
    if (str == nil || str.length <= 0) {
        return NO;
    }
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //英文条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合英字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    if (tNumMatchCount == str.length) {
        //全部符合数字，表示沒有英文
        return NO;
    } else if (tLetterMatchCount == str.length) {
        //全部符合英文，表示沒有数字
        return NO;
    } else if (tNumMatchCount + tLetterMatchCount == str.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return YES;
    } else {
        return NO;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
}

//只包含数字和字母的密码，固定位数
+ (BOOL)validateContainLetterAndNumWithMaxChars:(NSInteger)max
                                      minChars:(NSInteger)min
                                           str:(NSString *)str{
    //只能是数字和字母的混合
    NSString *regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%ld,%ld}$", (long)min, (long)max];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

@end
