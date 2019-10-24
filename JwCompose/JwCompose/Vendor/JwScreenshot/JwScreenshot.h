//
//  JwScreenshot.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/24.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwScreenshot : NSObject

/** 获取截屏 */
+ (UIImage *)imageWithScreenshot;

/** view生成image */
+ (UIImage *)imageWithScreenshotWithView:(UIView *)view;

/** 显示截图 */
+ (void)showScreenshotComplete:(nullable void(^)(UIImage *image))complete;
+ (void)showScreenshotTap:(UITapGestureRecognizer *)tap;

@end

NS_ASSUME_NONNULL_END
