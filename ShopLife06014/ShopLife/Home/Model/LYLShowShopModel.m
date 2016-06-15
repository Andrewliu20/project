//
//  LYLShowShopModel.m
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShowShopModel.h"


@implementation LYLShowShopModel


+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"itemList" : [Itemlist class]};
}


@end

@implementation Shop

@end

@implementation Itemlist

+ (NSDictionary *)objectClassInArray{
    return @{@"goodsList" : [Goodslist class]};
}

@end


@implementation Goodslist


+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ID"}];
}

@end


