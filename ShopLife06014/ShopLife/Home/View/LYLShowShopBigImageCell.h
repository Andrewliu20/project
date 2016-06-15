//
//  LYLShowShopBigImageCell.h
//  ShopLife
//
//  Created by System Administrator on 16/5/22.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLShowShopModel.h"
#import "UIImageView+WebCache.h"
#import "LYLShopInfoViewController.h"
#import "LYLShowShopViewController.h"

@interface LYLShowShopBigImageCell : UITableViewCell

- (void)setModel:(LYLShowShopModel *)model andShowShopVC:(LYLShowShopViewController *)showShopVC;
@end
