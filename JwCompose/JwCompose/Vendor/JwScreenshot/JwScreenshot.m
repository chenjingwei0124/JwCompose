//
//  JwScreenshot.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/24.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwScreenshot.h"

@implementation JwScreenshot

/** 获取截屏 */
+ (UIImage *)imageWithScreenshot{
    UIWindow *window = [JwCommon jw_catchWindow];
    UIImage *image = [JwScreenshot imageWithScreenshotWithView:window];
    return image;
}

/** view生成image */
+ (UIImage *)imageWithScreenshotWithView:(UIView *)view{
    CGSize imageSize = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(image);
    return [UIImage imageWithData:imageData];
}

/** 显示截图 */
+ (void)showScreenshotComplete:(void(^)(UIImage *image))complete{
    UIImage *image = [JwScreenshot imageWithScreenshot];
    NSLog(@"%@", image);
    if (image) {
        UIWindow *window = [JwCommon jw_catchWindow];
        UIView *backView = [[UIView alloc] init];
        backView.jw_height = window.jw_height * 0.9;
        backView.jw_width = backView.jw_height * image.size.width/image.size.height;
        backView.jw_centerX = window.jw_width * 0.5;
        backView.jw_centerY = window.jw_height * 0.5;
        backView.layer.cornerRadius = 8;
        backView.layer.masksToBounds = YES;
        backView.backgroundColor = JwColorRandom;
        [window addSubview:backView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(10, 10, backView.jw_width - 20, backView.jw_height - 20);
        [backView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showScreenshotTap:)];
        [backView addGestureRecognizer:tap];
        
        if (complete) {
            complete(image);
        }
    }
}

+ (void)showScreenshotTap:(UITapGestureRecognizer *)tap{
    UIView *view = tap.view;
    [view removeFromSuperview];
}

@end
