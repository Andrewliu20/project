//
//  LYLShopBigImageCell.h
//  ShopLife
//
//  Created by andrewliu on 16/5/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLShopInfoModel.h"
#import "UIImageView+WebCache.h"
#import "LYLShopInfoViewController.h"
@interface LYLShopBigImageCell : UITableViewCell

- (void)setGoodsModel:(GoodslistInfo *)goodsModel andVC:(LYLShopInfoViewController *)shopInfoVC;


@end
