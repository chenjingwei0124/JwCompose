//
//  BEAlertPresenter.m
//  AlertViewExamples
//
//  Created by chanhyuk on 2016. 5. 2..
//  Copyright © 2016년 Mangofever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEAlertPresenter.h"
#import "BEAlertButton.h"
#import "UIAlertView+BlockExtension.h"
#import "BEAlertViewBuilder.h"
#import <objc/runtime.h>

@interface UIAlertController (Private)

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation UIAlertController (Private)

@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow
{
    objc_setAssociatedObject(self, @selector(alertWindow), alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow
{
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

- (void)prepareWindow
{
    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.rootViewController = [[UIViewController alloc] init];
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    self.alertWindow.windowLevel = topWindow.windowLevel + 1;
    [self.alertWindow makeKeyAndVisible];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}

@end

@implementation BEAlertPresenter

- (void)show
{
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.builder.title message:self.builder.message preferredStyle:UIAlertControllerStyleAlert];
        [alertController prepareWindow];
        
        for (BEAlertButton *button in self.builder.buttons) {
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            if (button.type == BEAlertButtonTypeCancel) {
                style = UIAlertActionStyleCancel;
            }
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:button.title style:style
                                                                 handler:^(UIAlertAction *action) {
                                                                     if(button.action) {
                                                                         button.action();
                                                                     }
                                                                 }];
            [alertController addAction:cancelAction];
        }
        
        [alertController.alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.builder.title message:self.builder.message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        alertView.actionDispatcher = [[BEAlertViewActionDispatcher alloc] init];
        
        for (BEAlertButton *button in self.builder.buttons) {
            if (button.type == BEAlertButtonTypeCancel) {
                [alertView addCancelButtonWithTitle:button.title action:button.action];
            } else {
                [alertView addButtonWithTitle:button.title action:button.action];
            }
        }
        [alertView show];
    }
}

@end
