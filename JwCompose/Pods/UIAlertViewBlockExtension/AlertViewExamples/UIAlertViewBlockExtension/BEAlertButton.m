//
//  BEAlertButton.m
//  AlertViewExamples
//
//  Created by chanhyuk on 2016. 4. 29..
//  Copyright © 2016년 Mangofever. All rights reserved.
//

#import "BEAlertButton.h"

@implementation BEAlertButton

+ (id)cancelButtonWithTitle:(NSString *)title action:(void (^)())action
{
    BEAlertButton *button = [[BEAlertButton alloc] init];
    button.type = BEAlertButtonTypeCancel;
    button.title = title;
    button.action = action;
    
    return button;
}

+ (id)buttonWithTitle:(NSString *)title action:(void (^)())action
{
    BEAlertButton *button = [[BEAlertButton alloc] init];
    button.type = BEAlertButtonTypeOthers;
    button.title = title;
    button.action = action;
    
    return button;
}

@end
