//
//  JwProjectModel.h
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwBaseProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JwProjectModel : JwBaseProjectModel

//注册TableViewCell
+ (void)registerTableView:(UITableView *)tableView cellClassWithDatas:(NSArray *)datas;
//注册CollectionViewCell
+ (void)registerCollectionView:(UICollectionView *)collectionView cellClassWithDatas:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
