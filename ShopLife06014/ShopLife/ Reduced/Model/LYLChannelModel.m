//
//  LYLChannelModel.m
//  ShopLife
//
//  Created by andrewliu on 16/6/2.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLChannelModel.h"

@implementation LYLChannelModel



+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"rows":@"Rows"};
}

@end
@implementation Taobaoconfig

@end


@implementation Rows

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end

@implementation Itemgoods

@end






