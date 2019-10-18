//
//  JwHttpManager.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwHttpManager : NSObject

+ (JwHttpManager *)sharedManager;

- (void)GET:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)POST:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)upload:(NSDictionary *)params point:(NSString *)point imageDictionary:(NSDictionary *)imageDictionary success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;


- (void)GET:(NSDictionary *)params url:(NSString *)url success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)POST:(NSDictionary *)params url:(NSString *)url success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)upload:(NSDictionary *)params url:(NSString *)url imageDictionary:(NSDictionary *)imageDictionary success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
