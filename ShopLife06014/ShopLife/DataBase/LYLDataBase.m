//
//  LYLDataBase.m
//  ShopLife
//
//  Created by andrewliu on 16/6/6.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLDataBase.h"

@implementation LYLDataBase


+ (instancetype)shareShopLifeDataBase{
    
    static LYLDataBase *_db = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        
        //获取数据库的存储路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/shopLife.db"];
        
        //初始化数据库
        _db = [[LYLDataBase alloc] initWithPath:path];
        
        //打开数据库
        [_db open];
        
        //创建表
        [_db createTable];
        
        
    });
    
    return _db;
}



#pragma mark -- 创建表

- (void)createTable
{
    NSString *sql = @"create table if not exists shopsInfo(id varchar(20) primary key)";
    
    //执行表
    [self executeUpdate:sql];
}



//添加店铺信息(id)

- (BOOL)addShopInfoDB:(NSString *)shopId{
    
    NSString *sql = @"insert into  shopsInfo(id) values(?)";
    
    if ([self executeUpdate:sql,shopId]) {
        return YES;
    }else
    {
        NSLog(@"添加失败");
        return NO;
    }

}

//删除店铺信息(id)

- (BOOL)deleteShopInfoDB:(NSString *)shopId
{
    
    NSString *sql = @"delete from shopsInfo where id = ?";
    
    if ([self executeUpdate:sql,shopId]) {
        
        return YES;
    }else
    {
        NSLog(@"删除失败!");
        return NO;
    }
    
    return YES;
}

//
- (NSArray *)fillAllShopId{
    
    NSMutableArray *idArray = [NSMutableArray array];
    
    
    NSString *sql = @"select * from shopsInfo";
    FMResultSet *set = [self executeQuery:sql];
    
    while (set.next) {
        [idArray addObject:[set objectForColumnName:@"id"]];
    }
    
    
    return idArray;
}

- (BOOL)isExistShopId:(NSString *)shopId
{
    
    NSString *sql = @"select * from shopsInfo where id = ?";
    
    FMResultSet *result = [self executeQuery:sql,shopId];
    
    if (result.next) {
        
        return YES;
    }else{
        
        return  NO;
    }
    
}

- (BOOL)deleteAllShopData{

    NSString *sql = @"delete from shopsInfo";
    
    if ([self executeUpdate:sql]) {
        return YES;
    }
    return NO;
}
/**
 *  实现对喜欢商品的数据操作
 */

+ (instancetype)shareLikeGoodsDataBase
{
    static LYLDataBase *_goodDB = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        //获取数据库的存储路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/likeGoods.db"];
        
        //初始化数据库
        _goodDB = [[LYLDataBase alloc] initWithPath:path];
        
        //打开数据库
        [_goodDB open];
        
        //创建表
        [_goodDB createGoodsTable];
        
        
    });
    
    return _goodDB;

}

- (void)createGoodsTable
{
    NSString *sql = @"create table if not exists likeGoods(id varchar(20) primary key)";
    
    //执行表
    [self executeUpdate:sql];
}



//添加店铺信息(id)

- (BOOL)addLikeGoodsDB:(NSString *)goodId{
    
    NSString *sql = @"insert into  likeGoods(id) values(?)";
    
    if ([self executeUpdate:sql,goodId]) {
//        NSLog(@"添加成功");
        return YES;
    }else
    {
        NSLog(@"添加失败");
        return NO;
    }
    
}

//删除店铺信息(id)

- (BOOL)deleteLikeGoodsDB:(NSString *)goodId
{
    
    NSString *sql = @"delete from likeGoods where id = ?";
    
    if ([self executeUpdate:sql,goodId]) {
//        NSLog(@"删除成功");
        return YES;
    }else
    {
//        NSLog(@"删除失败!");
        return NO;
    }
    
    return YES;
}

//
- (NSArray *)fillAllGoodsId{
    
    NSMutableArray *idArray = [NSMutableArray array];
    
    
    NSString *sql = @"select * from likeGoods";
    FMResultSet *set = [self executeQuery:sql];
    
    while (set.next) {
        [idArray addObject:[set objectForColumnName:@"id"]];
    }
    
    
    return idArray;
}

- (BOOL)isExistGoodsId:(NSString *)goodId
{
    
    NSString *sql = @"select * from likeGoods where id = ?";
    
    FMResultSet *result = [self executeQuery:sql,goodId];
    
    if (result.next) {
        
        return YES;
    }else{
        
        return  NO;
    }
    
}

- (BOOL)deleteAllGoodData
{
    NSString *sql = @"delete from likeGoods";
    
    if ([self executeUpdate:sql]) {
        return YES;
        
    }
    return NO;
}

@end
