//
//  UIView+JwDefault.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/14.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Jw_ViewState) {
    Jw_ViewStateError = 0,     //加载失败
    Jw_ViewStateNothing = 1,   //什么都没有
};

@interface UIView (JwDefault)

@property (nonatomic, strong) UIView *jw_showBackView;
@property (nonatomic, copy) void(^jw_didShowBackAction)(UIView *view);

- (void)jw_setupShowBackViewWithState:(Jw_ViewState)state;

- (void)jw_setupShowBackViewWithImage:(NSString *)image text:(NSString *)text button:(NSString *)button;

- (void)jw_removeShowBackView;

@end
