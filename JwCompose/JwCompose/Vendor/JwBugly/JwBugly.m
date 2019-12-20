//
//  JwBugly.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/11/1.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBugly.h"
#import <Bugly/Bugly.h>
#import "JwCommon.h"

#define BUGLY_App_ID @"8634a7ee3c"
#define BUGLY_App_Key @"0f4947a8-74b2-43cd-8942-4d476183a46e"

@interface JwBugly ()<BuglyDelegate>

@end

@implementation JwBugly

- (void)setupBugly{
    
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.delegate = self;
    
#ifdef DEBUG
    config.debugMode = YES;
#else
    config.debugMode = NO;
#endif
    
    config.channel = @"Bugly";
    config.version = [JwCommon jw_commonVersionString];
    
    [Bugly startWithAppId:BUGLY_App_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
}

/** BuglyDelegate */
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    return @"This is an attachment";
}

@end
