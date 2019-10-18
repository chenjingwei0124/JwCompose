//
//  JwProgressHelper.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwProgressHelper.h"
#import "TYWaveProgressView.h"

#define kShowDuration 2.0

@interface JwProgressHelper ()

@end

@implementation JwProgressHelper

+ (MBProgressHUD *)showProgressAnimate{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    return [self showProgressAnimateInView:view];
}

+ (MBProgressHUD *)showProgressAnimateInView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [HUD.bezelView setBackgroundColor:[UIColor clearColor]];
    
    UIImage *image = [UIImage imageNamed:@"hub_loading"];
    TYWaveProgressView *wavePV = [[TYWaveProgressView alloc] initWithFrame:CGRectMake(0, 0, 70, 60)];
    wavePV.backgroundImageView.image = image;
    [wavePV setCenter:CGPointMake(35.0, 30.0)];
    [wavePV startWave];
    HUD.customView = wavePV;
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.backgroundColor = [UIColor clearColor];
    HUD.removeFromSuperViewOnHide = YES;
    [HUD setNeedsDisplay];
    [HUD layoutIfNeeded];
    return HUD;
}


+ (MBProgressHUD *)showProgress{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    return [self showProgressInView:view];
}

+ (void)showError:(NSString *)error{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showError:error inView:view];
}

+ (void)showSuccess:(NSString *)success{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showSuccess:success inView:view];
}

+ (void)showWarning:(NSString *)warning{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showWarning:warning inView:view];
}

+ (void)showText:(NSString *)text{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showText:text inView:view];
}


+ (MBProgressHUD *)showProgressInView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    //HUD.activityIndicatorColor = [UIColor whiteColor];
    HUD.contentColor = [UIColor whiteColor];
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (void)showError:(NSString *)error inView:(UIView *)view {
    [self showCustomView:@"hub_failure" text:error inView:view];
}

+ (void)showSuccess:(NSString *)success inView:(UIView *)view {
    [self showCustomView:@"hub_success" text:success inView:view];
}

+ (void)showWarning:(NSString *)warning inView:(UIView *)view{
    [self showCustomView:@"hub_warning" text:warning inView:view];
}

+ (void)showText:(NSString *)text inView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:15];
    HUD.detailsLabel.text = text;
    
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    HUD.detailsLabel.textColor = [UIColor whiteColor];
    
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:kShowDuration];
}

+ (void)showCustomView:(NSString *)image text:(NSString *)text inView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:15];
    HUD.detailsLabel.text = text;
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    HUD.contentColor = [UIColor whiteColor];
    
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:kShowDuration];
}


@end
