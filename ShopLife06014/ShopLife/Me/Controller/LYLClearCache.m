//
//  LYLClearCache.m
//  ShopLife
//
//  Created by andrewliu on 16/6/9.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLClearCache.h"
#import "UIImageView+WebCache.h"
@implementation LYLClearCache


//计算单个文件大小
+ (float)fileSizeAtPaht:(NSString *)path{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        
        return size/1024.0/1024.0;
    }
    return 0;
}
//计算目录大小
+ (float)folderSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    float floderSize;
    if ([fileManage fileExistsAtPath:path]) {
        NSArray *chileFiles = [fileManage subpathsAtPath:path];
        for (NSString *fileNaem in chileFiles) {
            NSString *absoluePath = [path stringByAppendingPathComponent:fileNaem];
            
            floderSize += [LYLClearCache fileSizeAtPaht:absoluePath];
        }
        floderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        
        return floderSize;
    }
    
    return 0;
}

//清除缓存
+ (void)clearCache:(NSString *)path{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFile = [fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFile) {
            
            NSString *absoluPath = [path stringByAppendingPathComponent:fileName];
            NSError *error = nil;
            //移除
            [fileManager removeItemAtPath:absoluPath error:&error];
            
            if (error) {
                NSLog(@"%@",error);
            }
        }
    }
    
    [[SDImageCache sharedImageCache]cleanDisk];
}

@end
