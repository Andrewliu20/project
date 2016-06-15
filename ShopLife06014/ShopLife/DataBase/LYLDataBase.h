//
//  LYLDataBase.h
//  ShopLife
//
//  Created by andrewliu on 16/6/6.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "FMDatabase.h"

@interface LYLDataBase : FMDatabase


//实现对店铺信息的添加

+ (instancetype)shareShopLifeDataBase;

//添加店铺信息(id)

- (BOOL)addShopInfoDB:(NSString *)shopId;

//删除店铺信息(id)

- (BOOL)deleteShopInfoDB:(NSString *)shopId;

//查看关注店铺的所有id

- (NSArray *)fillAllShopId;

//删除所有

- (BOOL)deleteAllShopData;


//判断是否存在某一个店铺的id

- (BOOL)isExistShopId:(NSString *)shopId;

/**
 *  对喜欢商品的数据操作
 */

+ (instancetype)shareLikeGoodsDataBase;


- (BOOL)addLikeGoodsDB:(NSString *)goodId;

- (BOOL)deleteLikeGoodsDB:(NSString *)goodId;

- (NSArray *)fillAllGoodsId;

- (BOOL)isExistGoodsId:(NSString *)goodId;
- (BOOL)deleteAllGoodData;
@end
