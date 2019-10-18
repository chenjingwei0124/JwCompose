//
//  UIScrollView+JwRefresh.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/8/8.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "UIScrollView+JwRefresh.h"
#import "JwDIYHeader.h"

@implementation UIScrollView (JwRefresh)

- (MJRefreshNormalHeader *)jw_mj_headerWithRefreshingBlock:(void(^)(UIScrollView *scrollView))block{
    Weak(self);
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)[JwDIYHeader headerWithRefreshingBlock:^{
        if (block) {
            block(wself);
        }
    }];
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (block) {
//            block(wself);
//        }
//    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    return header;
}

- (MJRefreshAutoNormalFooter *)jw_mj_footerWithRefreshingState:(Jw_FooterState)state block:(void(^)(UIScrollView *scrollView))block{
    Weak(self);
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block(wself);
        }
    }];
    self.mj_footer = footer;
    [self jw_mj_setFooter:(MJRefreshAutoNormalFooter *)self.mj_footer state:state];
    return footer;
}

/** 添加上拉方法 */
- (MJRefreshAutoNormalFooter *)jw_mj_footerWithRefreshingText:(NSString *)text block:(void(^)(UIScrollView *scrollView))block{
    Weak(self);
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block(wself);
        }
    }];
    self.mj_footer = footer;
    [self jw_mj_setFooter:(MJRefreshAutoNormalFooter *)self.mj_footer text:text];
    return footer;
}

- (void)jw_mj_setFooter:(MJRefreshAutoNormalFooter *)footer text:(NSString *)text{
    footer.stateLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
    [footer.stateLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [footer setTitle:text forState:MJRefreshStateNoMoreData];
}

- (void)jw_mj_setFooter:(MJRefreshAutoNormalFooter *)footer state:(Jw_FooterState)state{
    NSString *tip = nil;
    switch (state) {
        case Jw_FooterStateDefault:
            tip = @"— 我是有底线的哦！—";
            break;
        default:
            tip = @"— 我是有底线的哦！—";
            break;
    }
    [self jw_mj_setFooter:footer text:tip];
}

- (void)jw_mj_setFooterIsNoMore:(BOOL)isNoMore{
    if (isNoMore) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer resetNoMoreData];
    }
}

- (void)jw_mj_setHeaderAlphaHidden:(BOOL)hidden{
    __block UIView *header = self.mj_header;
    [UIView animateWithDuration:0.25 animations:^{
        header.alpha = hidden ? 0 : 1;
    }];
}

- (void)jw_mj_setFooterAlphaHidden:(BOOL)hidden{
    __block UIView *footer = self.mj_footer;
    [UIView animateWithDuration:0.25 animations:^{
        footer.alpha = hidden ? 0 : 1;
    }];
}

- (void)jw_mj_removeHeader{
    if (self.mj_header && self.mj_header.superview){
        if ([self.mj_header isRefreshing]){
            [self.mj_header endRefreshing];
        }
        [self.mj_header removeFromSuperview];
    }
}

- (void)jw_mj_removeFooter{
    if (self.mj_footer && self.mj_footer.superview){
        if ([self.mj_footer isRefreshing]){
            [self.mj_footer endRefreshing];
        }
        [self.mj_footer removeFromSuperview];
    }
}


- (void)jw_mj_headerBeginRefreshing{
    [self.mj_header beginRefreshing];
    self.mj_footer.hidden = YES;
}
- (void)jw_mj_headerEndRefreshing{
    [self.mj_header endRefreshing];
    self.mj_footer.hidden = NO;
}
- (void)jw_mj_setHeaderHidden:(BOOL)hidden{
    self.mj_header.hidden = hidden;
}

- (BOOL)jw_mj_isHeaderHidden{
    return self.mj_header.isHidden;
}
- (BOOL)jw_mj_isHeaderRefreshing{
    return self.mj_header.isRefreshing;
}

- (void)jw_mj_footerBeginRefreshing{
    [self.mj_footer beginRefreshing];
}
- (void)jw_mj_footerEndRefreshing{
    [self.mj_footer endRefreshing];
}
- (void)jw_mj_setFooterHidden:(BOOL)hidden{
    self.mj_footer.hidden = hidden;
}

- (BOOL)jw_mj_isFooterHidden{
    return self.mj_footer.isHidden;
}
- (BOOL)jw_mj_isFooterRefreshing{
    return self.mj_footer.isRefreshing;
    
}

@end
