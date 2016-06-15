//
//  LYLHomeViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLHomeViewController.h"
#import "LYLHomeModel.h"
#import "LYLSpreadViewController.h"

@interface LYLHomeViewController ()

@end

@implementation LYLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.title = @"逛街";
    
//    [self showLoadView];
    [self showData];
}

- (void)showData
{
    LYLHomeModel *homeModel = [[LYLHomeModel alloc] init];
    
    NSString *modleName = NSStringFromClass([homeModel class]);

    [self loadData:Home_URL andModelName:modleName andDictName:@"otherList" andTopDictName:@"topList"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        LYLSpreadViewController *srepeadVc = [[LYLSpreadViewController alloc] init];
    
        //隐藏这个页面的tabbar
        srepeadVc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:srepeadVc animated:YES];
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

@end
