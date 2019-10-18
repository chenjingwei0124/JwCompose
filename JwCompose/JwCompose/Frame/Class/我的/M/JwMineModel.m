//
//  JwMineModel.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwMineModel.h"

@implementation JwMineModel

//继承父类方法
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        //UICollectionCell计算Size
        //根据具体Cell布局计算
        CGFloat cellw = kJwScreenWidth - 20;
        CGFloat titleh = 20;
        CGFloat contenth = [self.name jw_heightForLabelWidth:cellw - 20 fontsize:15];
        CGFloat cellh = 10 + titleh + 10 + contenth + 10;
        self.jw_cellSize = CGSizeMake(cellw, cellh);
        
    }
    return self;
}

//重写父类方法
+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError *__autoreleasing *)err{
    NSMutableArray *datas = [super arrayOfModelsFromDictionaries:array error:err];
    JwProjectModel *projectModel = [[JwProjectModel alloc] init];
    projectModel.jw_cellName = @"JwMineCell";
    projectModel.jw_isXibCell = NO;
    projectModel.jw_itemCount = datas.count;
    projectModel.jw_itemDatas = datas.copy;
    projectModel.jw_edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    projectModel.jw_minimumLineSpacing = 10;
    return [NSMutableArray arrayWithObject:projectModel];
}

@end
