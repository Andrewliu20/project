//
//  LYSubjectCell.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLHomeSubjectModel.h"
#import "UIImageView+WebCache.h"

@interface LYSubjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BgImage;

@property (weak, nonatomic) IBOutlet UILabel *title;


- (void)setModel:(LYLHomeSubjectModel *)model andHomeVc:homeVC;


@end
