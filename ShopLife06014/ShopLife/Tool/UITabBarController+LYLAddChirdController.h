//
//  UITabBarController+LYLAddChirdController.h
//  01_GiftApp
//
//  Created by qianfeng on 16/5/16.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (LYLAddChirdController)


/**
 *  添加子控制器
 *
 *  @param controllerName    控制器的名称
 *  @param unSelectImageName 未选择图片的名字
 *  @param selectImageName   选中图片的名字
 */
- (void)addChildViewController:(NSString *)controllerName unSelectedImage:(NSString *)unSelectImageName selectedImage:(NSString *)selectImageName titleName:(NSString *)titleName;

@end
