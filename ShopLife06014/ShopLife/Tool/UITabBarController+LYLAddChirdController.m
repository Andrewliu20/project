//
//  UITabBarController+LYLAddChirdController.m
//  01_GiftApp
//
//  Created by qianfeng on 16/5/16.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "UITabBarController+LYLAddChirdController.h"


@implementation UITabBarController (LYLAddChirdController)



- (void)addChildViewController:(NSString *)controllerName unSelectedImage:(NSString *)unSelectImageName selectedImage:(NSString *)selectImageName titleName:(NSString *)titleName
{
    UITabBarItem *guideItem = [[UITabBarItem alloc] initWithTitle:titleName image:[UIImage imageNamed:unSelectImageName ] selectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    Class controller = NSClassFromString(controllerName);
    
    UIViewController *tempVC = [[controller alloc] init];
    
    
    
    tempVC.tabBarItem = guideItem;
    
    tempVC.title = titleName;
    
    
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tempVC];
    
    
   
    
    [self addChildViewController:nav];
}



@end
