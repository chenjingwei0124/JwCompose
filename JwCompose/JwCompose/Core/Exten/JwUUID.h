//
//  JwUUID.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/17.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCUUID.h"

@interface JwUUID : NSObject

/** 随机UUID */
+ (NSString *)jw_uuidRandomString;
/** 唯一UUID */
+ (NSString *)jw_uuidDeviceString;

@end
