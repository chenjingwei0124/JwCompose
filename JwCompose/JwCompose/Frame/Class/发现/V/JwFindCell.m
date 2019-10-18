//
//  JwFindCell.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwFindCell.h"

@interface JwFindCell ()

@property (nonatomic, strong) UILabel *contentL;

@end

@implementation JwFindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentL = [[UILabel alloc] init];
        self.contentL.font = [UIFont systemFontOfSize:15];
        self.contentL.textColor = JwColorRandom;
        self.contentL.numberOfLines = 0;
        [self.contentView addSubview:self.contentL];
        
    }
    return self;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.contentL.text = content;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
