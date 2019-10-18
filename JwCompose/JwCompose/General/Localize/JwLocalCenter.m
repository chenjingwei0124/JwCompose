//
//  JwLocalCenter.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwLocalCenter.h"

#define kLocalCenter @"LocalCenter"
#define kLocalCenter_User @"LocalCenter_User"
#define kLocalCenter_isLogined @"LocalCenter_isLogined"

@implementation JwLocalCenter

+ (instancetype)shared{
    static JwLocalCenter *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [self read];
        if (share == nil) {
            share = [[JwLocalCenter alloc] init];
        }
    });
    return share;
}

+ (instancetype)read{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalCenter];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else{
        return nil;
    }
}

- (void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLocalCenter];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    NSData *data = [self.userModel toJSONData];
    [aCoder encodeObject:data forKey:kLocalCenter_User];
    [aCoder encodeBool:self.isLogined forKey:kLocalCenter_isLogined];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    NSData *userData = [aDecoder decodeObjectForKey:kLocalCenter_User];
    self.userModel = [[JwUserModel alloc] initWithData:userData error:nil];
    self.isLogined = [aDecoder decodeBoolForKey:kLocalCenter_isLogined];
    return self;
}

@end
