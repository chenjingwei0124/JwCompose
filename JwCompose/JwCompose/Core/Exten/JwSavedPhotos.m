//
//  JwSavedPhotos.m
//  ZeroBuy
//
//  Created by 陈警卫 on 2019/1/16.
//  Copyright © 2019年 namei. All rights reserved.
//

#import "JwSavedPhotos.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+JwCate.h"

@interface JwSavedPhotos ()

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation JwSavedPhotos

- (void)jw_setupSavePhotos:(NSArray *)images{
    self.images = images.mutableCopy;
    [self savePhoto];
}

- (void)savePhoto{
    if (self.images.count > 0) {
        UIImage *image = self.images[0];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        if (self.didDoneOver) {
            self.didDoneOver();
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        
    }else{
        [self.images removeObjectAtIndex:0];
    }
    [self savePhoto];
}

- (void)jw_downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock {
    
    dispatch_group_t group = dispatch_group_create();
    //有多张图片URL的数组
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSString *imageUrlStr in imgsArray) {
        dispatch_group_enter(group);
        //需要加载图片的控件(UIImageView, UIButton等)
        UIImageView *imageView = [[UIImageView alloc] init];
        SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
        manager.downloadTimeout = 5;
        [manager downloadImageWithURL:[imageView jw_urlWithEncodeString:imageUrlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                //加载失败
            } else {
                //加载成功
                [imageArr addObject:image];
            }
            dispatch_group_leave(group);
        }];
    }
    //下载图片完成后, 回到主线
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //刷新UI
        if(completionBlock){
            completionBlock(imageArr);
        }
    });
}

- (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count {
    NSMutableArray *resultArray = [NSMutableArray new];
    for(int i=0;i<count;i++) {
        NSObject *obj = [dict objectForKey:@(i)];
        //是image 保存
        if ([obj isKindOfClass:[UIImage class]]) {
            [resultArray addObject:obj];
        }
    }
    return resultArray;
}

//批量下载并插入相册
- (void)jw_setupDownloadSavePhotos:(NSArray *)images{
    [self jw_downloadImages:images completion:^(NSArray *resultArray) {
        [self jw_setupSavePhotos:resultArray];
    }];
}



@end
