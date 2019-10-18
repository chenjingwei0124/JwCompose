//
//  JwBaseProjectModel.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwBaseProjectModel : JwBaseModel

@property (nonatomic, strong) id<Optional> jw_base;//基类数据
@property (nonatomic, strong) id<Optional> jw_data;//基础数据
@property (nonatomic, strong) NSString *jw_temp;//扩展字段

@property (nonatomic, assign) CGSize jw_cellSize;//显示大小
@property (nonatomic, assign) CGSize jw_headSize;//区头大小
@property (nonatomic, assign) CGSize jw_footSize;//区尾大小
@property (nonatomic, assign) UIEdgeInsets jw_edgeInsets;//边距

@property (nonatomic, assign) CGFloat jw_minimumLineSpacing;//行间距
@property (nonatomic, assign) CGFloat jw_minimumInteritemSpacing;//列间距

@property (nonatomic, strong) NSString *jw_cellName;//cell Identifier
@property (nonatomic, strong) NSString *jw_headName;//header Identifier
@property (nonatomic, strong) NSString *jw_footName;//footer Identifier
@property (nonatomic, assign) BOOL jw_isXibCell;
@property (nonatomic, assign) BOOL jw_isXibHead;
@property (nonatomic, assign) BOOL jw_isXibFoot;

@property (nonatomic, assign) NSInteger jw_itemCount;//item数量
@property (nonatomic, strong) NSMutableArray *jw_itemHeights;//item的高度数组
@property (nonatomic, strong) NSMutableArray *jw_itemDatas;//item数据


@end

NS_ASSUME_NONNULL_END
