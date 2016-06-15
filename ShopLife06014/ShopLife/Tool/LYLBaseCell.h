//
//  LYLBaseCell.h
//  ShopLife
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "LYLHomeModel.h"

@interface LYLBaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageInfo;



@property (nonatomic,strong) LYLHomeModel *model;


@end
