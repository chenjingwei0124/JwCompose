//
//  JwCommon.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/8/30.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JwCommon : NSObject
/**
 判断字符串
 nil, @"", @"  ", @"\n" 返回 YES
 */
+ (BOOL)jw_isBlankWithString:(NSString *)string;

/**
 校验字符串
 */
+ (NSString *)jw_stringCheckWithData:(id)data;

/** Bundle ID */
+ (NSString *)jw_commonBundleIDString;
/** Version */
+ (NSString *)jw_commonVersionString;
/** Build ID */
+ (NSString *)jw_commonBuildIDString;

/** 系统版本 */
+ (NSString *)jw_commonSystemVersionString;
/** 机型iPhone/iPad... */
+ (NSString *)jw_commonLocalizedModelString;
/** 时间戳 */
+ (NSString *)jw_commonTimestampString;
/** 随机数 */
+ (NSString *)jw_commonNonceString;

/** 改变Label中的字体属性 */
+ (void)jw_label:(UILabel *)label texts:(NSArray *)texts keys:(NSArray *)keys values:(NSArray *)values;
/** 改变Label中的字体颜色 */
+ (void)jw_label:(UILabel *)label text:(NSString *)text color:(UIColor *)color;
/** 改变Label中的字体大小 */
+ (void)jw_label:(UILabel *)label text:(NSString *)text font:(UIFont *)font;

/** NSUserDefaults setObject */
+ (void)jw_userDefaultsWithObject:(id)value key:(NSString *)key;
/** NSUserDefaults objectForKey */
+ (id)jw_userDefaultsWithKey:(NSString *)key;
/** NSUserDefaults removeObjectForKey */
+ (void)jw_userDefaultsRemoveKey:(NSString *)key;

/** NSUserDefaults setBool */
+ (void)jw_userDefaultsWithBool:(BOOL)Bool key:(NSString *)key;
/** NSUserDefaults boolForKey */
+ (BOOL)jw_userDefaultsBoolWithKey:(NSString *)key;

/**
 获取字符串分页Range
 
 @param content 字符串数据
 @param fontsize 字体大小
 @param size 界面大小
 @return Range数组
 */
+ (NSArray *)jw_pageRangeArrayWithContent:(NSString *)content fontsize:(NSInteger)fontsize size:(CGSize)size;

/**
 固定角圆角
 
 @param view 控件
 @param corners 指定角
 @param cornerRadius 圆角值
 @param rect 控件坐标
 */
+ (void)jw_bezierRoundingView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(NSInteger)cornerRadius rect:(CGRect)rect;

/** 获取跟控制器的Window */
+ (UIWindow *)jw_catchWindow;
/** 获取最前的ViewController */
+ (UIViewController *)jw_catchCurrentViewControllerWithViewController:(UIViewController *)vc;
/** 获取当前的ViewController */
+ (UIViewController *)jw_catchCurrentViewController;


/** 程序主目录，可见子目录(3个):Documents、Library、tmp */
+ (NSString *)jw_homePath;
/** 程序目录，不能存任何东西 */
+ (NSString *)jw_appPath;
/** 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据 */
+ (NSString *)jw_docPath;
/** 配置目录，配置文件存这里 */
+ (NSString *)jw_libPrefPath;
/** 缓存目录，系统永远不会删除这里的文件，ITUNES会删除 */
+ (NSString *)jw_libCachePath;
/** 临时缓存目录，APP退出后，系统可能会删除这里的内容 */
+ (NSString *)jw_tmpPath;
/** 判断文件是否存在 否则创建 */
+ (BOOL)jw_fileHasLive:(NSString *)path;


/**获取缓存大小*/
+ (NSString *)getCacheSize;
/**清除缓存*/
+ (void)cleanCache;

@end

NS_ASSUME_NONNULL_END
