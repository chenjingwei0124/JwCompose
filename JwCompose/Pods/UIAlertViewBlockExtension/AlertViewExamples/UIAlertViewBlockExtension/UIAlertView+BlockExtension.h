//
//  UIAlertView+BlockExtension.h
//  AlertViewExamples
//
//  Created by Mango on 2015. 3. 18..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEAlertViewActionDispatcher.h"

@interface UIAlertView (BlockExtension)

@property (strong, nonatomic) BEAlertViewActionDispatcher *actionDispatcher;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message;

- (void)addButtonWithTitle:(NSString *)title action:(void (^)())action;
- (void)addCancelButtonWithTitle:(NSString *)title action:(void (^)())action;

@end

@interface UIAlertView (ConvenientMethods)

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle action:(void (^)())action;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelAction:(void (^)())cancelAction otherButtonTitle:(NSString *)otherButtonTitle otherButtonAction:(void (^)())otherAction;

@end

@interface UIAlertView (Deprecated)

- (void)addButtonWithTitle:(NSString *)title actionBlock:(UIAlertActionBlock)actionBlock;
- (void)addCancelButtonWithTitle:(NSString *)title actionBlock:(UIAlertActionBlock)actionBlock;
- (void)addCancelActionBlock:(UIAlertActionBlock)actionBlock;

@end
