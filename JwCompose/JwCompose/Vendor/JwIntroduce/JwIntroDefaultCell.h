//
//  JwIntroDefaultCell.h
//  ZeroBuy
//
//  Created by 陈警卫 on 2018/9/25.
//  Copyright © 2018年 namei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JwIntroDefaultCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *nowB;

@property (nonatomic, copy) void(^didNowBAction)(void);

@end
