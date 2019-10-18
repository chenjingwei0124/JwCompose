//
//  UIImage+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JwCate)
/** 颜色图片 */
+ (UIImage *)jw_createImageWithColor:(UIColor *)color;

/** 调整图片大小 */
+ (UIImage *)jw_resizedSizeImage:(UIImage *)image size:(CGSize)size;

/** view转变成image */
+ (UIImage *)jw_imageWithUIView:(UIView *)view;

/** 模糊图片 */
+ (UIImage *)jw_vagueImagerWithImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
