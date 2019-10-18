//
//  UIScrollView+JwRefresh.h
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/8.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef NS_ENUM(NSUInteger, Jw_FooterState) {
    Jw_FooterStateDefault = 0,
};

@interface UIScrollView (JwRefresh)

/** 添加下拉方法 */
- (MJRefreshNormalHeader *)jw_mj_headerWithRefreshingBlock:(void(^)(UIScrollView *scrollView))block;
/** 添加上拉方法 */
- (MJRefreshAutoNormalFooter *)jw_mj_footerWithRefreshingState:(Jw_FooterState)state block:(void(^)(UIScrollView *scrollView))block;
/** 添加上拉方法 */
- (MJRefreshAutoNormalFooter *)jw_mj_footerWithRefreshingText:(NSString *)text block:(void(^)(UIScrollView *scrollView))block;

- (void)jw_mj_setFooterIsNoMore:(BOOL)isNoMore;

- (void)jw_mj_setHeaderAlphaHidden:(BOOL)hidden;
- (void)jw_mj_setFooterAlphaHidden:(BOOL)hidden;

- (void)jw_mj_removeHeader;
- (void)jw_mj_removeFooter;


- (void)jw_mj_headerBeginRefreshing;
- (void)jw_mj_headerEndRefreshing;
- (void)jw_mj_setHeaderHidden:(BOOL)hidden;

- (BOOL)jw_mj_isHeaderHidden;
- (BOOL)jw_mj_isHeaderRefreshing;

- (void)jw_mj_footerBeginRefreshing;
- (void)jw_mj_footerEndRefreshing;
- (void)jw_mj_setFooterHidden:(BOOL)hidden;

- (BOOL)jw_mj_isFooterHidden;
- (BOOL)jw_mj_isFooterRefreshing;


@end
