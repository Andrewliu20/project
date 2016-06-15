//
//  LYLShopImageCell.h
//  ShopLife
//
//  Created by andrewliu on 16/5/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLShopInfoModel.h"
#import "UIImageView+WebCache.h"
#import "LYLShopInfoViewController.h"

@interface LYLShopImageCell : UITableViewCell

- (void)setModel:(GoodslistInfo *)leftGoodsModel andrightModel:(GoodslistInfo *)rightGoodsModel andShopInfoVC:(LYLShopInfoViewController *)shopInfoVC;

@end
