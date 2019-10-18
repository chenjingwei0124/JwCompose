//
//  JwSavedPhotos.h
//  ZeroBuy
//
//  Created by 陈警卫 on 2019/1/16.
//  Copyright © 2019年 namei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwSavedPhotos : NSObject

//批量插入相册
- (void)jw_setupSavePhotos:(NSArray *)images;
//批量插入相册结束回调
@property (nonatomic, copy) void(^didDoneOver)(void);
//批量下载图片
- (void)jw_downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock;

//批量下载并插入相册 完成时回调didDoneOver
- (void)jw_setupDownloadSavePhotos:(NSArray *)images;

@end
