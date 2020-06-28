//
//  JwShareModel.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/11/30.
//  Copyright © 2018年 陈警卫. All rights reserved.
//


@interface JwShare : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id images;
@property (nonatomic, strong) NSURL *url;

@end

@interface JwShare_Wechat : JwShare

@property (nonatomic, strong) id thumbImage;
@property (nonatomic, strong) id image;
@property (nonatomic, strong) NSURL *musicFileURL;
@property (nonatomic, strong) NSString *extInfo;
@property (nonatomic, strong) id fileData;
@property (nonatomic, strong) id emoticonData;
@property (nonatomic, strong) NSString *fileExtension;
@property (nonatomic, strong) id sourceFileData;

@end

@interface JwShare_WeChatMiniProgram : JwShare

@property (nonatomic, strong) NSString *description_f;
@property (nonatomic, strong) NSURL *webpageUrl;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) id thumbImage;
@property (nonatomic, strong) id hdThumbImage;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) BOOL withShareTicket;
@property (nonatomic, assign) NSUInteger miniProgramType;

@end

@interface JwShare_QQ : JwShare

@property (nonatomic, strong) NSURL *audioFlashURL;
@property (nonatomic, strong) NSURL *videoFlashURL;
@property (nonatomic, strong) id thumbImage;


@end

@interface JwShare_SinaWeibo : JwShare

@property (nonatomic, strong) NSString *video;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, assign) BOOL isShareToStory;

@end
