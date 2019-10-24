//
//  AppDelegate+JwCate.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/10/24.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "AppDelegate+JwCate.h"

@implementation AppDelegate (JwCate)

- (void)jw_userDidTakeScreenshot:(NSNotification *)notifi{
    [JwScreenshot showScreenshotComplete:nil];
}

@end
