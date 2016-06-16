//
//  LYLChannelCell.h
//  ShopLife
//
//  Created by andrewliu on 16/6/2.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLChannelModel.h"
#import "UIImageView+WebCache.h"
#import "LYLReducedViewController.h"

@interface LYLChannelCell : UITableViewCell


@property (nonatomic,assign) CGFloat height;
- (void)setModel:(Itemgoods *)model andVC:(LYLReducedViewController *)homeVC;

@end
