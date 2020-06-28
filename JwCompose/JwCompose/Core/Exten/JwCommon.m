//
//  JwCommon.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/8/30.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwCommon.h"

@implementation JwCommon

/**
 判断字符串
 nil, @"", @"  ", @"\n" 返回 YES
 */
+ (BOOL)jw_isBlankWithString:(NSString *)string{
    if (!string) {
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    string = [self jw_stringCheckWithData:string];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

/**
 校验字符串
 */
+ (NSString *)jw_stringCheckWithData:(id)data{
    if ([data isKindOfClass:[NSNumber class]]) {
        data = ((NSNumber *)data).stringValue;
    }
    if ([data isKindOfClass:[NSString class]]) {
        return data;
    }else{
        return @"";
    }
}

/** Bundle ID */
+ (NSString *)jw_commonBundleIDString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}
/** Version */
+ (NSString *)jw_commonVersionString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}
/** Build ID */
+ (NSString *)jw_commonBuildIDString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}
/** 系统版本 */
+ (NSString *)jw_commonSystemVersionString{
    return [[UIDevice currentDevice] systemVersion];
}
/** 机型iPhone/iPad... */
+ (NSString *)jw_commonLocalizedModelString{
    return [[UIDevice currentDevice] localizedModel];
}
/** 时间戳 */
+ (NSString *)jw_commonTimestampString{
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}
/** 随机数 */
+ (NSString *)jw_commonNonceString{
    int r = arc4random() % 1000000000;
    return [NSString stringWithFormat:@"%06d", r];
}

/** 改变Label中的字体属性 */
+ (void)jw_label:(UILabel *)label texts:(NSArray *)texts keys:(NSArray *)keys values:(NSArray *)values{
    NSMutableAttributedString *attStr = (NSMutableAttributedString *)label.attributedText;
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:NSForegroundColorAttributeName]) {
            NSRange textR = [[attStr string] rangeOfString:texts[idx]];
            [attStr addAttribute:NSForegroundColorAttributeName value:values[idx] range:textR];
        }
        if ([obj isEqualToString:NSFontAttributeName]) {
            NSRange textR = [[attStr string] rangeOfString:texts[idx]];
            [attStr addAttribute:NSFontAttributeName value:values[idx] range:textR];
        }
    }];
    label.attributedText = attStr;
}
/** 改变Label中的字体颜色 */
+ (void)jw_label:(UILabel *)label text:(NSString *)text color:(UIColor *)color{
    NSArray *texts = @[text];
    NSArray *keys = @[NSForegroundColorAttributeName];
    NSArray *values = @[color];
    [JwCommon jw_label:label texts:texts keys:keys values:values];
}
/** 改变Label中的字体大小 */
+ (void)jw_label:(UILabel *)label text:(NSString *)text font:(UIFont *)font{
    NSArray *texts = @[text];
    NSArray *keys = @[NSFontAttributeName];
    NSArray *values = @[font];
    [JwCommon jw_label:label texts:texts keys:keys values:values];
}

/** NSUserDefaults setObject */
+ (void)jw_userDefaultsWithObject:(id)value key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/** NSUserDefaults objectForKey */
+ (id)jw_userDefaultsWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/** NSUserDefaults removeObjectForKey */
+ (void)jw_userDefaultsRemoveKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

/** NSUserDefaults setBool */
+ (void)jw_userDefaultsWithBool:(BOOL)Bool key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:Bool forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** NSUserDefaults boolForKey */
+ (BOOL)jw_userDefaultsBoolWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


/**
 获取字符串分页Range

 @param content 字符串数据
 @param fontsize 字体大小
 @param size 界面大小
 @return Range数组
 */
+ (NSArray *)jw_pageRangeArrayWithContent:(NSString *)content fontsize:(NSInteger)fontsize size:(CGSize)size{
    
    NSDate *date = [NSDate date];
    
    NSString *text = content;
    //需要确定字体才能获取正确的range
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontsize];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
    
    NSMutableArray *pageRanges = [NSMutableArray array];
    NSInteger rangeIndex = 0;
    
    for (NSInteger i = 0; i < NSIntegerMax; i++) {
        
        NSAttributedString *childStr = [attStr attributedSubstringFromRange:NSMakeRange(rangeIndex, attStr.length - rangeIndex)];
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)childStr);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
        CFRange cfRange = CTFrameGetVisibleStringRange(frame);
        
        NSRange range = {rangeIndex, cfRange.length};
        [pageRanges addObject:[NSValue valueWithRange:range]];
        
        rangeIndex += range.length;
        
        CGPathRelease(path);
        CFRelease(frame);
        CFRelease(frameSetter);
        
        if (rangeIndex >= attStr.length) {
            break;
        }
    }
    
    NSTimeInterval millionSecond = [[NSDate date] timeIntervalSinceDate:date];
    DLog(@"耗时%lf", millionSecond);
    return (NSArray *)pageRanges;
}

/**
 固定角圆角

 @param view 控件
 @param corners 指定角
 @param cornerRadius 圆角值
 @param rect 控件坐标
 */
+ (void)jw_bezierRoundingView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(NSInteger)cornerRadius rect:(CGRect)rect{
    if (CGRectEqualToRect(rect, CGRectZero)) {
        rect = view.bounds;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

/** 获取跟控制器的Window */
+ (UIWindow *)jw_catchWindow{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *target in windows) {
            if (target.windowLevel == UIWindowLevelNormal) {
                window = target;
                break;
            }
        }
    }
    return window;
}

/** 获取最前的ViewController */
+ (UIViewController *)jw_catchCurrentViewControllerWithViewController:(UIViewController *)vc{
    UIViewController *currentVC;
    if ([vc presentedViewController]) {
        while ([vc presentedViewController]) {
            vc = [vc presentedViewController];
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        currentVC = [self jw_catchCurrentViewControllerWithViewController:[(UITabBarController *)vc selectedViewController]];
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        currentVC = [self jw_catchCurrentViewControllerWithViewController:[(UINavigationController *)vc visibleViewController]];
    } else {
        currentVC = vc;
    }
    return currentVC;
}

/** 获取当前的ViewController */
+ (UIViewController *)jw_catchCurrentViewController{
    UIViewController *rootVC = [self jw_catchWindow].rootViewController;
    UIViewController *currentVC = [self jw_catchCurrentViewControllerWithViewController:rootVC];
    return currentVC;
}


/** 程序主目录，可见子目录(3个):Documents、Library、tmp */
+ (NSString *)jw_homePath{
    return NSHomeDirectory();
}
/** 程序目录，不能存任何东西 */
+ (NSString *)jw_appPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
/** 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据 */
+ (NSString *)jw_docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
/** 配置目录，配置文件存这里 */
+ (NSString *)jw_libPrefPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}
/** 缓存目录，系统永远不会删除这里的文件，ITUNES会删除 */
+ (NSString *)jw_libCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}
/** 临时缓存目录，APP退出后，系统可能会删除这里的内容 */
+ (NSString *)jw_tmpPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}
/** 判断文件是否存在 否则创建 */
+ (BOOL)jw_fileHasLive:(NSString *)path{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO){
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return YES;
}

/**获取缓存大小*/
+ (NSString *)getCacheSize{
    //得到缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    //首先判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        for (NSString * fileName in childFile) {
            //缓存文件绝对路径
            NSString * absolutPath = [path stringByAppendingPathComponent:fileName];
            size = size + [manager attributesOfItemAtPath:absolutPath error:nil].fileSize;
        }
        //计算sdwebimage的缓存和系统缓存总和
        size = size + [SDImageCache sharedImageCache].totalDiskSize;
    }
    return [NSString stringWithFormat:@"%.2fM",size / 1024 / 1024];
}

/**清除缓存*/
+ (void)cleanCache{
    //获取缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
    //判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        //逐个删除缓存文件
        for (NSString *fileName in childFile) {
            NSString * absolutPat = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:absolutPat error:nil];
        }
        //删除sdwebimage的缓存
        [[SDImageCache sharedImageCache] clearMemory];
    }
}


@end
