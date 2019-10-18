//
//  JwJailBreak.m
//  e-bank
//
//  Created by 陈警卫 on 2017/6/21.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "JwJailBreak.h"
#import <dlfcn.h>
#import <sys/stat.h>
#import <string.h>
#import <stdlib.h>
#import <mach-o/dyld.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation JwJailBreak

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
#define USER_APP_PATH @"/User/Applications/"
#define CYDIA_APP_PATH "/Applications/Cydia.app"

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

- (void)jw_checkJailBreakWithSuccess:(void (^)(void))success{
    
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            if (success) {
                success();
            }
        }
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        if (success) {
            success();
        }
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        if (success) {
            success();
        }
    }
    if (printEnv()) {
        if (success) {
            success();
        }
    }
    
    struct stat stat_info;
    if (0 == stat(CYDIA_APP_PATH, &stat_info)) {
        if (success) {
            success();
        }
    }
    if (0 == stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info)) {
        if (success) {
            success();
        }
    }
    if (0 == stat("/var/lib/cydia/", &stat_info)) {
        if (success) {
            success();
        }
    }
    if (0 == stat("/var/cache/apt", &stat_info)) {
        if (success) {
            success();
        }
    }

    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"lib:%s",dylib_info.dli_fname);
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {
            if (success) {
                success();
            }
        }
    }
}

char* printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}

@end
