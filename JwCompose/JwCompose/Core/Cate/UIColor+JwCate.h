//
//  UIColor+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}JwRGBA;

@interface UIColor (JwCate)

/** 十六进制颜色 */
+ (UIColor *)jw_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
/** 十六进制颜色 */
+ (UIColor *)jw_colorWithHex:(NSInteger)hex;

/** 十六进制字符串颜色 */
+ (UIColor *)jw_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/** 十六进制字符串颜色 */
+ (UIColor *)jw_colorWithHexString:(NSString *)hexString;

/**
 取UIColor的rgba
 
 @param color UIColor
 @return rgba数值
 */
JwRGBA jw_rgbaFromUIColor(UIColor *color);
JwRGBA jw_rgbaFromCGColor(CGColorRef color);

/**
 颜色渐变
 
 @param fromColor 起始颜色
 @param toColor 终点颜色
 @param value 渐变速率
 @return 颜色值
 */
+ (UIColor *)jw_colorWithFormColor:(UIColor *)fromColor toColor:(UIColor *)toColor value:(float)value;

/** 获取当前UIColor对象里的红色色值 */
- (CGFloat)jw_red;
/** 获取当前UIColor对象里的绿色色值 */
- (CGFloat)jw_green;
/** 获取当前UIColor对象里的蓝色色值 */
- (CGFloat)jw_blue;
/** 获取当前UIColor对象里的透明色值 */
- (CGFloat)jw_alpha;
/** 获取当前UIColor对象里的hue（色相） */
- (CGFloat)jw_hue;
/** 获取当前UIColor对象里的saturation（饱和度） */
- (CGFloat)jw_saturation;
/** 获取当前UIColor对象里的brightness（亮度） */
- (CGFloat)jw_brightness;
/** 将当前UIColor对象剥离掉alpha通道后得到的色值。相当于把当前颜色的半透明值强制设为1.0后返回 */
- (UIColor *)jw_colorWithoutAlpha;

/**
 *  将自身变化到某个目标颜色，可通过参数progress控制变化的程度，最终得到一个纯色
 */
- (UIColor *)jw_qmui_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress;

/**
 *  计算两个颜色叠加之后的最终色（注意区分前景色后景色的顺序）<br/>
 */
+ (UIColor *)jw_qmui_colorWithBackendColor:(UIColor *)backendColor frontColor:(UIColor *)frontColor;

/**
 *  将颜色A变化到颜色B，可通过progress控制变化的程度
 */
+ (UIColor *)jw_qmui_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;
    
@end
