//
//  LYLShowShopCell.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLShowShopModel.h"
#import "UIImageView+WebCache.h"
#import "LYLShowShopViewController.h"
@interface LYLShowShopCell : UITableViewCell


- (void)setModel:(LYLShowShopModel *)model andShowShopVC:(LYLShowShopViewController *)showShopVC;

@end
