//
//  AppDelegate.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/8/29.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "AppDelegate.h"
#import "JwTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/** 进入菜单界面 */
- (void)showRootController{
    [self.window.rootViewController removeFromParentViewController];
    [self.window removeAllSubviews];
    self.window.rootViewController = [[JwTabBarController alloc] init];
}

/** 键盘高度计算以及BarTool */
- (void)initKeyboardManager {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.toolbarTintColor = [UIColor blackColor];
    manager.previousNextDisplayMode = IQPreviousNextDisplayModeDefault;
    manager.enableAutoToolbar = NO;
    manager.shouldShowToolbarPlaceholder = NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self showRootController];
    
    [self initKeyboardManager];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
