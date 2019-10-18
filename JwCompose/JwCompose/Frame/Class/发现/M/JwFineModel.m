//
//  JwFineModel.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwFineModel.h"

@implementation JwFineModel

//继承父类方法
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        //UITableViewCell只需要高度
        //在初始化数据时计算高度 解决滑动时计算出现卡的情况
        CGFloat height = [self.name jw_heightForLabelWidth:kJwScreenWidth - 20 fontsize:15];
        self.jw_cellSize = CGSizeMake(0, ceil(height) + 20);
    }
    return self;
}

//重写父类方法
+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError *__autoreleasing *)err{
    NSMutableArray *datas = [super arrayOfModelsFromDictionaries:array error:err];
    JwProjectModel *projectModel = [[JwProjectModel alloc] init];
    projectModel.jw_cellName = @"JwFindCell";
    projectModel.jw_isXibCell = NO;
    projectModel.jw_itemCount = datas.count;
    projectModel.jw_itemDatas = datas.copy;
    return [NSMutableArray arrayWithObject:projectModel];
}


@end
