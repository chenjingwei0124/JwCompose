//
//  JwMineCell.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/12.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwMineCell.h"

@interface JwMineCell ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;

@end

@implementation JwMineCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleL = [[UILabel alloc] init];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.textColor = JwColorRandom;
        self.titleL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleL];
        
        self.contentL = [[UILabel alloc] init];
        self.contentL.font = [UIFont systemFontOfSize:16];
        self.contentL.textColor = JwColorRandom;
        self.contentL.numberOfLines = 0;
        self.contentL.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.contentL];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setModel:(JwMineModel *)model{
    _model = model;
    
    self.titleL.text = model.Id;
    self.contentL.text = model.name;
}

@end
