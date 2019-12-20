//
//  JwWeakScriptMessageDelegate.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/12/17.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptMessageDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptMessageDelegate;

@end

NS_ASSUME_NONNULL_END
