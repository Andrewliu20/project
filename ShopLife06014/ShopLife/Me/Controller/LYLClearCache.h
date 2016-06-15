//
//  LYLClearCache.h
//  ShopLife
//
//  Created by andrewliu on 16/6/9.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  清除缓存
 */
@interface LYLClearCache : NSObject


//计算目录大小
+ (float)folderSizeAtPath:(NSString *)path;

//清除缓存
+ (void)clearCache:(NSString *)path;

@end
