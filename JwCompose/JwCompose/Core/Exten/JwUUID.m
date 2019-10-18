//
//  JwUUID.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/17.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwUUID.h"

@implementation JwUUID

+ (NSString *)jw_uuidRandomString{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid uppercaseString];
}

+ (NSString *)jw_uuidDeviceString{
    return [FCUUID uuidForDevice];
}

@end
