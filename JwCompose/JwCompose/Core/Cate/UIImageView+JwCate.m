//
//  UIImageView+JwCate.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/12/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIImageView+JwCate.h"
#import "JwPlaceholderView.h"

#define kPlaceholderTag 41270

@implementation UIImageView (JwCate)

- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr{
    NSURL *url = [self jw_urlWithEncodeString:urlStr];
    
    UIView *view = [self viewWithTag:kPlaceholderTag];
    if (view) {
        [view removeFromSuperview];
    }
    
    UIView *placeholderView = [[JwPlaceholderView alloc] init];
    placeholderView.tag = kPlaceholderTag;
    [self addSubview:placeholderView];
    [placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image && placeholderView) {
            [placeholderView removeFromSuperview];
        }
        if (error && placeholderView) {
            //错误
        }
    }];
}

- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder{
    NSURL *url = [self jw_urlWithEncodeString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}

- (void)jw_sd_setImageWithURLStr:(NSString *)urlStr completed:(SDExternalCompletionBlock)completed{
    NSURL *url = [self jw_urlWithEncodeString:urlStr];
    [self sd_setImageWithURL:url completed:completed];
}

- (NSURL *)jw_urlWithEncodeString:(NSString *)string{
    
    if ([string isKindOfClass:[NSURL class]]) {
        return (NSURL *)string;
    }
    if (![string isKindOfClass:[NSString class]]){
        return nil;
    }
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    return url;
}


@end
