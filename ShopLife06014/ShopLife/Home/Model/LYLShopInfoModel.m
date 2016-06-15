//
//  LYLShopInfoModel.m
//  ShopLife
//
//  Created by andrewliu on 16/5/24.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShopInfoModel.h"

@implementation LYLShopInfoModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"itemListInfo":@"itemList"};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"itemList":@"ItemlistInfo"
             };
}
@end

@implementation ShopInfo

@end

@implementation ItemlistInfo
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"goodsList":@"GoodslistInfo"
             };
}
@end


@implementation GoodslistInfo

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end


