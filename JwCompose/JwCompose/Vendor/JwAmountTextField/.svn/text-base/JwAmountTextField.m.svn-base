//
//  JwAmountTextField.m
//  Jst_ios
//
//  Created by 陈警卫 on 2018/6/11.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwAmountTextField.h"
#define MAX_COUNT_LENGTH 10

@interface JwAmountTextFieldDelegate : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) id <UITextFieldDelegate> delegate;

@end

@interface JwAmountTextField ()

@property (nonatomic, strong) NSNumberFormatter *amountNumberFormatter;
@property (nonatomic, strong) JwAmountTextFieldDelegate *amountTextFieldDelegate;

@property(nonatomic, assign)NSInteger numerical;
@property(nonatomic, assign)NSInteger floatTen;
@property(nonatomic, assign)NSInteger floatDigits;
@property(nonatomic, assign)BOOL isFloat;

@end

@implementation JwAmountTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupAmountTF];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAmountTF];
    }
    return self;
}

- (void)setupAmountTF{
    
    self.amountNumberFormatter = [[NSNumberFormatter alloc] init];
    self.amountNumberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-cn"];
    self.amountNumberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    self.amountNumberFormatter.usesGroupingSeparator = YES;
    
    self.amountTextFieldDelegate = [[JwAmountTextFieldDelegate alloc] init];
    [super setDelegate:self.amountTextFieldDelegate];
    
    self.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.floatTen = -1;
    self.floatDigits = -1;
    self.numerical = 0;
    self.isFloat = NO;
    [self setupBegin];
}

- (NSString *)amount{
    NSNumber *numText =  [self.amountNumberFormatter numberFromString:self.text];
    NSString *amountText = [NSString stringWithFormat:@"%.2f", [numText doubleValue]];
    return amountText;
}

- (void)setAmount:(NSString *)amount{
    self.numerical = [amount doubleValue] * 100;
    NSInteger folatPart = self.numerical % 100;
    
    if(folatPart == 0){
        self.isFloat = NO;
    }else {
        self.isFloat = YES;
    }
    [self setupText];
}

- (void)setupBegin{
    NSString *begin = [self.amountNumberFormatter stringFromNumber:[NSNumber numberWithInteger:0]];
    [self setText:begin];
}

- (void)setupText{
    NSInteger intPart = self.numerical / 100;
    NSInteger folatPart = self.numerical % 100;
    
    NSNumber *number = [NSNumber numberWithInteger:intPart];
    NSString *intStr = [self.amountNumberFormatter stringFromNumber:number];
    
    NSString *folatStr;
    if(folatPart >= 10){
        //两位数
        folatStr = [NSString stringWithFormat:@"%zd",folatPart];
    }else if(folatPart >= 1){
        //一位数
        folatStr = [NSString stringWithFormat:@"0%zd",folatPart];
    }else if(folatPart == 0){
        //00
        folatStr = @"00";
    }
    NSString *showStr = [intStr stringByReplacingCharactersInRange:(NSMakeRange(intStr.length - 2, 2)) withString:folatStr];
    [self setText:showStr];
}

- (NSInteger)getupIntPartLength{
    NSInteger intPart = self.numerical/100;
    NSString *intStr = [NSString stringWithFormat:@"%zd",intPart];
    return [intStr length];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    self.amountTextFieldDelegate.delegate = delegate;
}

- (id<UITextFieldDelegate>) delegate{
    return self.amountTextFieldDelegate.delegate;
}

@end

@implementation JwAmountTextFieldDelegate

- (BOOL)textField:(JwAmountTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self validateNumberPointStr:string]) {
        [self amountFormatWithTextField:textField text:string];
        [textField setupText];
    }
    return NO;
}

- (BOOL)validateNumberPointStr:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789."]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

- (void)amountFormatWithTextField:(JwAmountTextField *)tf text:(NSString *)text{
    if ([text isEqualToString:@""]) {
        if(!tf.isFloat){
            if(tf.numerical >= 1000){
                NSInteger floatPart = tf.numerical % 100;
                tf.numerical /= 1000;
                tf.numerical = tf.numerical*100 + floatPart ;
            }else if(tf.numerical >= 100){
                tf.numerical %= 100;
            }
        }else {
            if(tf.numerical % 100 == 0 && tf.floatTen == -1 && tf.floatDigits == -1){
                //刚点击完小数点
                tf.isFloat = NO;
                tf.numerical /= 1000;
                tf.numerical *= 100;
                tf.floatTen = -1;
                tf.floatDigits = -1;
            }else if(tf.numerical % 10 == 0 && tf.floatDigits == -1){
                //小数点后一位
                tf.numerical /= 100;
                tf.numerical *= 100;
                tf.floatTen = -1;
            }else { //小数点后两位
                tf.numerical /= 10;
                tf.numerical *= 10;
                tf.floatDigits = -1;
            }
        }
    }else{
        if ([text isEqualToString:@"."]) {
            tf.isFloat = YES;
        }else{
            NSInteger itext = [text integerValue];
            if(tf.isFloat){
                if(tf.numerical % 100 == 0  && tf.floatTen == -1 && tf.floatDigits == -1){
                    //刚点击完小数点
                    tf.numerical = tf.numerical + itext*10;
                    tf.floatTen = itext;
                }else if(tf.numerical % 10 == 0  && tf.floatDigits == -1){
                    //小数点后一位
                    tf.numerical = tf.numerical + itext*1;
                    tf.floatDigits = itext;
                }else {
                    //小数点后两位
                }
            }else {
                if([tf getupIntPartLength] < MAX_COUNT_LENGTH){
                    tf.numerical = tf.numerical*10 + itext*100;
                }
            }
        }
    }
}


@end
