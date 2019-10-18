//
//  JwLocationHelper.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class JwLocationHelper;

@protocol JwJwLocationDelegate <NSObject>

- (void)location:(JwLocationHelper *)helper didSuccess:(CLPlacemark *)placemark;
- (void)location:(JwLocationHelper *)helper didFailed:(NSError *)error close:(BOOL)close;

@end

@interface JwLocationHelper : NSObject

@property (nonatomic, weak) id<JwJwLocationDelegate> delegate;

@property (nonatomic, copy) void(^didLocationSuccess)(CLPlacemark *placemark);
@property (nonatomic, copy) void(^didLocationFailed)(NSError *error, BOOL close);

+ (JwLocationHelper *)shareManager;
- (void)startLocation;

@end
