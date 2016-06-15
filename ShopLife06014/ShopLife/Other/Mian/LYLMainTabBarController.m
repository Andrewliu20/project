//
//  LYLMainTabBarController.m
//  PartTimeJobs
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLMainTabBarController.h"
#import "UITabBarController+LYLAddChirdController.h"


@interface LYLMainTabBarController ()

@end

@implementation LYLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBarControllor];
}

- (void)createTabBarControllor
{
    //tabBar的名字数组
//    NSArray *tabBarNameArray = @[@"逛街",@"捡宝",@"关注",@"分类",@"我"];
    //Controller类名一部分
//    NSArray *controllerArray = @[@"LYLHome",@"LYLReduced",@"LYLAttention",@"LYLClassify",@"LYLMe"];
//    
//    NSArray *tabBarImage = @[@"xzzm_Tabbar_tabbarHome",@"xzzm_Tabbar_tabbarChannel",@"xzzm_Tabbar_tabbarShop",@"xzzm_Tabbar_tabbarGrid",@"xzzm_Tabbar_tabbarAccount"];
    NSArray *controllerArray = @[@"LYLHome",@"LYLReduced",@"LYLAttention",@"LYLMe"];
    
    NSArray *tabBarImage = @[@"xzzm_Tabbar_tabbarHome",@"xzzm_Tabbar_tabbarChannel",@"xzzm_Tabbar_tabbarShop",@"xzzm_Tabbar_tabbarAccount"];
    
    for (int i = 0; i < 4; i++) {
        
        [self addChildViewController:[NSString stringWithFormat:@"%@ViewController",controllerArray[i]] unSelectedImage:tabBarImage[i] selectedImage:[NSString stringWithFormat:@"%@Sel",tabBarImage[i]] titleName:nil];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
