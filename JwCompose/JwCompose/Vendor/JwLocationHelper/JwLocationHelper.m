//
//  JwLocationHelper.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/6.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwLocationHelper.h"

@interface JwLocationHelper ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation JwLocationHelper

+ (JwLocationHelper *)shareManager{
    static JwLocationHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[JwLocationHelper alloc] init];
    });
    return helper;
}

- (void)startLocation{
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 20;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"JwLocationHelper 定位服务未打开");
        if ([self.delegate respondsToSelector:@selector(location:didFailed:close:)]) {
            [self.delegate location:self didFailed:nil close:YES];
        }
        if (self.didLocationFailed) {
            self.didLocationFailed(nil, YES);
        }
    }
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        if ([self.delegate respondsToSelector:@selector(location:didSuccess:)]) {
            [self.delegate location:self didSuccess:placemark];
        }
        if (self.didLocationSuccess) {
            self.didLocationSuccess(placemark);
        }
    }];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(location:didFailed:close:)]) {
        [self.delegate location:self didFailed:nil close:[error code] == kCLErrorDenied];
    }
    if (self.didLocationFailed) {
        self.didLocationFailed(nil, [error code] == kCLErrorDenied);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"JwLocationHelper 等待定位授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"JwLocationHelper 定位授权失败");
    }
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

@end
