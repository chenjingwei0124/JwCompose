//
//  JwWeakScriptMessageDelegate.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/12/17.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwWeakScriptMessageDelegate.h"

@implementation JwWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptMessageDelegate{
    self = [super init];
    if (self) {
        _scriptMessageDelegate = scriptMessageDelegate;
    }
    return self;
}

/**
 必须实现如下方法 然后把方法向外传递
 通过接收JS传出消息的name进行捕捉的回调方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([self.scriptMessageDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptMessageDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}


@end
