//
//  BEAlertViewBuilder.m
//  AlertViewExamples
//
//  Created by chanhyuk on 2016. 4. 29..
//  Copyright © 2016년 Mangofever. All rights reserved.
//

#import "BEAlertViewBuilder.h"

@implementation BEAlertViewBuilder {
    BEAlertPresenter * _presenter;
}

- (id)init {
    self = [super init];
    if (self) {
        self.buttons = [NSMutableArray array];
        _presenter = [[BEAlertPresenter alloc] init];
        _presenter.builder = self;
    }
    
    return self;
}

- (void)addCancelButtonWithTitle:(NSString *)title action:(UIAlertActionVoidBlock)action {
    BEAlertButton *button = [BEAlertButton cancelButtonWithTitle:title action:action];
    if (button) {
        [self.buttons addObject:button];
    }
}
- (void)addButtonWithTitle:(NSString *)title action:(UIAlertActionVoidBlock)action {
    BEAlertButton *button = [BEAlertButton buttonWithTitle:title action:action];
    if (button) {
        [self.buttons addObject:button];
    }
}

- (BEAlertPresenter *)presenter
{
    return _presenter;
}

@end

