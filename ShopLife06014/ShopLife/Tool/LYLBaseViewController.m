//
//  LYLBaseViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLBaseViewController.h"
#import "MBProgressHUD.h"

@interface LYLBaseViewController ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation LYLBaseViewController





#pragma mark -- 菊花相关的方法---


- (void) showLoadView

{
    [self.view bringSubviewToFront:self.hud];
    
    //显示
    
    [self.hud show:YES];
}

- (void)hideLoadView
{
    [self.hud hide:YES];
}

- (MBProgressHUD *)hud
{

    if(_hud == nil){


        _hud = [[MBProgressHUD alloc]initWithView:self.view];

        _hud.labelText = @"加载中...";

        [self.view addSubview:_hud];

    }

    return _hud;
}

@end
