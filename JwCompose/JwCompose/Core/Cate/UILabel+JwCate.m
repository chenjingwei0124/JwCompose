//
//  UILabel+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/12/12.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UILabel+JwCate.h"
#import <CoreText/CoreText.h>

@implementation UILabel (JwCate)

- (CGFloat)jw_auto_width{
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.bounds.size.height)];
    return ceil(size.width);
}

- (CGFloat)jw_auto_height{
    CGSize size = [self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    return ceil(size.height);
}

- (CGSize)jw_auto_size{
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/** 获取label中内容的行数和每一行的内容 */
- (NSArray *)jw_getLinesArrayOfStringInLabel{
    UILabel *label = self;
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

@end
