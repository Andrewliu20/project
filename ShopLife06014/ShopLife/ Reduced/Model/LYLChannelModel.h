//
//  LYLChannelModel.h
//  ShopLife
//
//  Created by andrewliu on 16/6/2.
//  Copyright © 2016年 andrewliu. All rights reserved.
//


#import "MJExtension.h"


@class Taobaoconfig,Rows,Itemgoods;
@interface LYLChannelModel : NSObject


@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, strong) NSArray *rows;

@property (nonatomic, assign) BOOL resStatus;

@property (nonatomic, strong) NSArray *topList;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) Taobaoconfig *taobaoConfig;

@end
@interface Taobaoconfig : NSObject

@property (nonatomic, copy) NSString *goodsTbkScript;

@property (nonatomic, copy) NSString *taobaokeurl;

@property (nonatomic, copy) NSString *goodsTaobaoScript;

@property (nonatomic, assign) NSInteger waitTime;

@property (nonatomic, copy) NSString *hideAppNoticeScript;

@end

@interface Rows : NSObject

@property (nonatomic, strong) Itemgoods *itemgoods;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger itemtype;

@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, assign) BOOL isshow;

@property (nonatomic, assign) NSInteger itemid;

@end

@interface Itemgoods : NSObject

@property (nonatomic, copy) NSString *sharecount;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *picurl;

@property (nonatomic, copy) NSString *newtime;


@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, copy) NSString *discountprice;

@property (nonatomic, copy) NSString *shopid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *sale;

@property (nonatomic, copy) NSString *sourcegoodsid;

@property (nonatomic, copy) NSString *config;

@property (nonatomic, assign) BOOL isfavor;

@property (nonatomic, copy) NSString *goodsid;

@property (nonatomic, assign) BOOL isshare;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *attr;

@end




