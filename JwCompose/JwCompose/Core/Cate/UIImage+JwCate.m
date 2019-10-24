//
//  UIImage+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/7/25.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIImage+JwCate.h"

@implementation UIImage (JwCate)
/** 颜色图片 */
+ (UIImage *)jw_createImageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/** 调整图片大小 */
+ (UIImage *)jw_resizedSizeImage:(UIImage *)image size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

/** view转变成image */
+ (UIImage *)jw_imageWithUIView:(UIView *)view{
    CGSize imageSize = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(image);
    return [UIImage imageWithData:imageData];
}

/** 模糊图片 */
+ (UIImage *)jw_vagueImagerWithImage:(UIImage *)image withBlurLevel:(CGFloat)blur{
    
    CIImage *ciimage = [[CIImage alloc]initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];
    
    [filter setValue:ciimage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey:@"inputRadius"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *bluerImage = [UIImage imageWithCGImage:outImage];
    return bluerImage;
}


@end
