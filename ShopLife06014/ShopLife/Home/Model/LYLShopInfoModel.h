//
//  LYLShopInfoModel.h
//  ShopLife
//
//  Created by andrewliu on 16/5/24.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "MJExtension.h"

@class ShopInfo,ItemlistInfo,GoodslistInfo;
@interface LYLShopInfoModel:NSObject



@property (nonatomic, copy) NSString *dateName;

@property (nonatomic, strong) ShopInfo *shop;

@property (nonatomic, copy) NSString *listtime;

@property (nonatomic,strong) NSArray *itemList;



@end


@interface ShopInfo : NSObject

@property (nonatomic, assign) NSInteger credit;

@property (nonatomic, copy) NSString *item_score;

@property (nonatomic, copy) NSString *shopPic;

@property (nonatomic, copy) NSString *item_score_percent;

@property (nonatomic, assign) NSInteger shopPicWidth;

@property (nonatomic, assign) NSInteger shopcatcount;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *goodsupdate;

@property (nonatomic, assign) NSInteger shopPicHeight;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *item_score_type;

@end


@interface ItemlistInfo : NSObject

@property (nonatomic, strong) NSArray *goodsList;

@property (nonatomic, assign) BOOL isBig;

@end

@interface GoodslistInfo : NSObject

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *discountprice;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, copy) NSString *sale;

@end

