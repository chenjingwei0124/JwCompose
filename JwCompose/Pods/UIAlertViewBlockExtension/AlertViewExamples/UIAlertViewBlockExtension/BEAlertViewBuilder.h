//
//  BEAlertViewBuilder.h
//  AlertViewExamples
//
//  Created by chanhyuk on 2016. 4. 29..
//  Copyright © 2016년 Mangofever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEAlertPresenter.h"
#import "BEAlertButton.h"

typedef void (^UIAlertActionVoidBlock) (void);

@interface BEAlertViewBuilder : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, readonly) BEAlertPresenter *presenter;

- (void)addCancelButtonWithTitle:(NSString *)title action:(UIAlertActionVoidBlock)action;
- (void)addButtonWithTitle:(NSString *)title action:(UIAlertActionVoidBlock)action;

@end

