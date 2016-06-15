//
//  LYLShowShopModel.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "JSONModel.h"

@protocol Itemlist



@end

@protocol Goodslist



@end

@class Shop,Itemlist,Goodslist;
@interface LYLShowShopModel : JSONModel
@property (nonatomic, copy) NSString *resStatus;

@property (nonatomic, strong) Shop *shop;

@property (nonatomic, strong) NSArray<Itemlist> *itemList;

@end



@interface Shop : JSONModel

@property (nonatomic, assign) NSInteger credit;

@property (nonatomic, copy) NSString *item_score;

@property (nonatomic, copy) NSString *shopPic;

@property (nonatomic, assign) NSInteger shopPicWidth;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *goodsupdate;

@property (nonatomic, assign) NSInteger shopPicHeight;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *item_score_type;

@end

@interface Itemlist : JSONModel

@property (nonatomic, strong) NSArray<Goodslist> *goodsList;

@property (nonatomic, assign) BOOL isBig;

@end

@interface Goodslist : JSONModel

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

