//
//  JwBaseTableCell.m
//  JwPart
//
//  Created by 陈警卫 on 2020/5/15.
//  Copyright © 2020 陈警卫. All rights reserved.
//

#import "JwBaseTableCell.h"

@implementation JwBaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProjectModel:(JwProjectModel *)projectModel{
    _projectModel = projectModel;
}

@end
