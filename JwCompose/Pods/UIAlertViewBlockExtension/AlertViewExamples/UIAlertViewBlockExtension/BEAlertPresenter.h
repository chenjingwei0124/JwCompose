//
//  BEAlertPresenter.h
//  AlertViewExamples
//
//  Created by chanhyuk on 2016. 5. 2..
//  Copyright © 2016년 Mangofever. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BEAlertViewBuilder;

@interface BEAlertPresenter : NSObject

@property (nonatomic, weak) BEAlertViewBuilder *builder;

- (void)show;

@end
