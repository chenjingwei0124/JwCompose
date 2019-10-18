//
//  UIImageView+JwCate.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/12/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImageManager.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (JwCate)

/**
 加载图片(已设置placeholder)

 @param urlStr 图片链接字符串
 */
- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr;

/**
 加载图片

 @param urlStr 图片链接字符串
 @param placeholder 预览图
 */
- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/**
 加载图片

 @param urlStr 图片链接字符串
 @param completed 返回参数
 */
- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr completed:(SDExternalCompletionBlock)completed;

/**
 图片链接编码

 @param string 链接
 @return 请求网址
 */
- (NSURL *)jw_urlWithEncodeString:(NSString *)string;

@end
