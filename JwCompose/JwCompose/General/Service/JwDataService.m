//
//  JwDataService.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwDataService.h"

@implementation JwDataService

/** 分类 /api/app/firstEntry
 */
- (void)firstEntrySuccess:(void (^)(NSMutableArray *entrys, id data))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param = [self defaultParam:param];
    
    NSString *point = @"firstEntry";
    point = [self nodePoint:point];
    
    [self.httpManager POST:param point:point success:^(id data) {
        
        NSArray *info = data[@"data"];
        NSMutableArray *entrys = [JwClassifyModel arrayOfModelsFromDictionaries:info error:nil];
        success(entrys, data);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
