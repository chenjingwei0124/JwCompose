//
//  JwMenuView.m
//  Purchase_iOS
//
//  Created by 陈警卫 on 2018/9/5.
//  Copyright © 2018年 陈警卫. All rights reserved.
//

#import "JwMenuView.h"

@interface JwMenuView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation JwMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:(self.bounds)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.scrollsToTop = NO;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.scrollView];
    self.scrollDirection = JwMenuViewScrollDirectionHorizontal;
    
    self.progressView = [[UIView alloc] init];
}

- (void)setScrollDirection:(JwMenuViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    if (scrollDirection == JwMenuViewScrollDirectionVertical) {
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollView.alwaysBounceHorizontal = NO;
    }
    if (scrollDirection == JwMenuViewScrollDirectionHorizontal) {
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
    }
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressView.backgroundColor = progressColor;
}

- (void)setIsScroll:(BOOL)isScroll{
    _isScroll = isScroll;
    self.scrollView.scrollEnabled = YES;
}

- (void)reloadData{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.scrollView addSubview:self.progressView];
    
    self.cells = [NSMutableArray array];
    [self.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JwMenuItem *item = [[JwMenuItem alloc] init];
        if ([self.dataSource respondsToSelector:@selector(menuView:itemForIndex:)]) {
            item = [self.dataSource menuView:self itemForIndex:idx];
        }
        if (!item.data) {
            item.data = obj;
        }
        item.index = idx;

        JwMenuItem *lastItem = self.cells.lastObject;
        
        CGFloat spaceLineValue = 0;
        if (self.isShowSpaceLine) {
            spaceLineValue = 1;
        }
        
        if (self.scrollDirection == JwMenuViewScrollDirectionHorizontal) {
            
            if (self.isAverageItem) {
                CGFloat averageWidth = (self.jw_width - self.itemEdge.left - self.itemEdge.right - (self.itemSpace + spaceLineValue) * (self.datas.count - 1))/self.datas.count;
                averageWidth = self.averageItemValue == 0 ? averageWidth : self.averageItemValue;
                item.frame = CGRectMake(0, 0, averageWidth, self.jw_height);
            }else{
                item.frame = CGRectMake(0, 0, item.jw_width, self.jw_height);
                
            }
            if (idx == 0) {
                item.jw_x = lastItem.jw_right + self.itemEdge.left;
            }else{
                item.jw_x = lastItem.jw_right + self.itemSpace + spaceLineValue;
            }
            
        }else if (self.scrollDirection == JwMenuViewScrollDirectionVertical) {
            
            if (self.isAverageItem) {
                CGFloat averageHeight = (self.jw_height - self.itemEdge.top - self.itemEdge.bottom - (self.itemSpace + spaceLineValue) * (self.datas.count - 1))/self.datas.count;
                averageHeight = self.averageItemValue == 0 ? averageHeight : self.averageItemValue;
                item.frame = CGRectMake(0, 0, averageHeight, self.jw_height);
            }else{
                item.frame = CGRectMake(0, 0, self.jw_width, spaceLineValue);
                
            }
            if (idx == 0) {
                item.jw_x = lastItem.jw_bottom + self.itemEdge.top;
            }else{
                item.jw_x = lastItem.jw_bottom + self.itemSpace + spaceLineValue;
            }
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [item addGestureRecognizer:tap];
        [self.scrollView addSubview:item];
        
        if (self.isShowSpaceLine) {
            UIView *lineV = [[UIView alloc] init];
            if (self.scrollDirection == JwMenuViewScrollDirectionHorizontal) {
                lineV.frame = CGRectMake(item.jw_right + self.itemSpace * 0.5, 0, 1, item.jw_height * 0.5);
                lineV.jw_centerY = self.jw_height * 0.5;
            }else if (self.scrollDirection == JwMenuViewScrollDirectionVertical) {
                lineV.frame = CGRectMake(0, item.jw_bottom + self.itemSpace * 0.5, item.jw_width, 1);
            }
            lineV.backgroundColor = self.spaceLineColor ?: [UIColor grayColor];
            [self.scrollView addSubview:lineV];
        }
        [self.cells addObject:item];
    }];
    
    JwMenuItem *lastItem = self.cells.lastObject;
    if (self.scrollDirection == JwMenuViewScrollDirectionHorizontal) {
        self.scrollView.contentSize = CGSizeMake(lastItem.jw_right + self.itemEdge.right, self.scrollView.jw_height);
    }
    if (self.scrollDirection == JwMenuViewScrollDirectionVertical) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.jw_width, lastItem.jw_bottom + self.itemEdge.bottom);
    }
    
    if (self.isShowProgress) {
        JwMenuItem *firstItem = self.cells.firstObject;
        
        self.progressView.frame = CGRectMake(firstItem.jw_x + self.progressEdge.left,
                                             firstItem.jw_y + self.progressEdge.top,
                                             firstItem.jw_width - self.progressEdge.left - self.progressEdge.right,
                                             firstItem.jw_height - self.progressEdge.top - self.progressEdge.bottom);
        
        if (self.progressValue > 0) {
            if (self.scrollDirection == JwMenuViewScrollDirectionHorizontal) {
                
                self.progressView.frame = CGRectMake(firstItem.jw_x + self.progressEdge.left,
                                                     firstItem.jw_y + self.progressEdge.top,
                                                     self.progressValue,
                                                     firstItem.jw_height - self.progressEdge.top - self.progressEdge.bottom);
                self.progressView.jw_centerX = firstItem.jw_width * 0.5;
                
            }else if (self.scrollDirection == JwMenuViewScrollDirectionVertical) {
                
                self.progressView.frame = CGRectMake(firstItem.jw_x + self.progressEdge.left,
                                                     firstItem.jw_y + self.progressEdge.top,
                                                     firstItem.jw_width - self.progressEdge.left - self.progressEdge.right,
                                                     self.progressValue);
                self.progressView.jw_centerY = firstItem.jw_height * 0.5;
            }
        }
        
        self.progressView.backgroundColor = self.progressColor;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    JwMenuItem *item = (JwMenuItem *)tap.view;
    if ([self.delegate respondsToSelector:@selector(menuView:didiSelectAtIndex:data:)]) {
        [self.delegate menuView:self didiSelectAtIndex:item.index data:item.data];
    }
}

- (void)setValueWithOffset:(CGFloat)offset width:(CGFloat)width count:(NSInteger)count{
    if (width <= 0) {
        return;
    }
    offset = offset >= 0.0 ? offset : 0.0;
    offset = offset < width * (count - 1) ? offset : width * (count - 1);
    
    CGFloat value = offset / width;
    value = value - floor(value);
    
    NSInteger fromIndex = offset/width;
    NSInteger toIndex = fromIndex + 1;
    
    [self setValue:value fromIndex:fromIndex toIndex:toIndex];
}

- (void)setValue:(CGFloat)value fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    JwMenuItem *fromCell;
    JwMenuItem *toCell;
    if (fromIndex >= 0 && fromIndex < self.cells.count) {
        fromCell = self.cells[fromIndex];
    }
    if (toIndex >= 0 && toIndex < self.cells.count) {
        toCell = self.cells[toIndex];
    }
    fromCell.rate = 1.0 - value;
    toCell.rate = value;
    
    //清除其他cell的rate
    if (value == 0) {
        [self clearCellContentWitFromIndex:fromIndex toIndex:toIndex];
    }
    //进度条
    if (self.isShowProgress) {
        if (self.scrollDirection == JwMenuViewScrollDirectionHorizontal) {
            
            if (self.progressValue > 0){
                self.progressView.jw_centerX = fromCell.jw_centerX + (toCell.jw_centerX - fromCell.jw_centerX) * value;
            }else{
                CGRect rect = CGRectZero;
                rect.origin.x = fromCell.jw_x + self.progressEdge.left + (toCell.jw_x - fromCell.jw_x) * value;
                rect.size.width = fromCell.jw_width - self.progressEdge.left - self.progressEdge.right + (toCell.jw_width - fromCell.jw_width) * value;
                rect.origin.y = self.progressView.jw_y;
                rect.size.height = self.progressView.jw_height;
                self.progressView.frame = rect;
            }
        }else if (self.scrollDirection == JwMenuViewScrollDirectionVertical){
            if (self.progressValue > 0){
                self.progressView.jw_centerX = fromCell.jw_centerX + (toCell.jw_centerX - fromCell.jw_centerX) * value;
            }else{
                CGRect rect = CGRectZero;
                rect.origin.y = fromCell.jw_y + self.progressEdge.top + (toCell.jw_y - fromCell.jw_y) * value;
                rect.size.height = fromCell.jw_height - self.progressEdge.top - self.progressEdge.bottom + (toCell.jw_height - fromCell.jw_height) * value;
                
                rect.origin.x = self.progressView.jw_x;
                rect.size.width = self.progressView.jw_width;
                self.progressView.frame = rect;
            }
        }
    }
    
    [self refreshContenOffsetWithtoIndex:toIndex];
}

//让选中的item位于中间
- (void)refreshContenOffsetWithtoIndex:(NSInteger)toIndex{
    JwMenuItem *toCell;
    if (toIndex > 0 && toIndex < self.cells.count) {
        toCell = self.cells[toIndex - 1];
    }else{
        return;
    }
    CGRect frame = toCell.frame;
    CGFloat itemX = frame.origin.x;
    CGFloat width = self.scrollView.frame.size.width;
    CGSize contentSize = self.scrollView.contentSize;
    if (itemX > width/2.0) {
        CGFloat targetX;
        if ((contentSize.width - itemX) <= width/2.0) {
            targetX = contentSize.width - width;
        } else {
            targetX = frame.origin.x - width/2.0 + frame.size.width/2.0;
        }
        if (targetX + width > contentSize.width) {
            targetX = contentSize.width - width;
        }
        [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)clearCellContentWitFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    [self.cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JwMenuItem *cell = obj;
        if (idx != fromIndex && idx != toIndex) {
            [cell setRate:0.0f];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
