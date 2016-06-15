//
//  LYLSettingViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/7.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLSettingViewController.h"
#import "LYLAboutViewController.h"
#import "LYLAdviceViewController.h"
#import "UIImageView+WebCache.h"
#import "LYLClearCache.h"
#import "LYLDataBase.h"

@interface LYLSettingViewController ()

@property (nonatomic,strong) UIImageView *adviceImage;


@property (nonatomic,strong) UIImageView *clearCacheImage;

@property (nonatomic,strong) UIImageView *aboutImage;

@end

@implementation LYLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.title = @"设置";
    
    [self initView];
}

- (void)initView{
    
    self.adviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, self.view.frame.size.width - 20, 70)];
    
    self.adviceImage.image = [UIImage imageNamed:@"xzzm_Settings_feedbackBtn@2x"];
    
    [self.view addSubview:self.adviceImage];
    
    self.clearCacheImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100,  self.view.frame.size.width - 20, 70)];
    
    self.clearCacheImage.image = [UIImage imageNamed:@"xzzm_Settings_cleanBtn@2x"];
    [self.view addSubview:self.clearCacheImage];
    
    self.aboutImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 190, self.view.frame.size.width - 20, 70)];
    
    self.aboutImage.image = [UIImage imageNamed:@"xzzm_Settings_aboutBtn"];
    
    [self.view addSubview:self.aboutImage];
    
    //对意见反馈添加点击事件
    
    self.adviceImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *adviceGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adviceClick)];
    [self.adviceImage addGestureRecognizer:adviceGesture];
    
    //对清除缓存添加点击事件
    
    self.clearCacheImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *clearGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearClick)];
    
    [self.clearCacheImage addGestureRecognizer:clearGesture];
    
    //对关于添加点击事件
    self.aboutImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *aboutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutClick)];
    [self.aboutImage addGestureRecognizer:aboutGesture];
    
}

#pragma mark -- 实现点击事件

- (void)adviceClick
{
    LYLAdviceViewController *adviceVC = [[LYLAdviceViewController alloc] init];
    
    adviceVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:adviceVC animated:YES];
}

- (void)clearClick
{
    //获取沙盒路径
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    float size = [LYLClearCache folderSizeAtPath:path];
    
    [self showAlert:[NSString stringWithFormat:@"%.2f",size]];
}

-(void)showAlert:(NSString *)sizeStr{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"缓存大小为:%@M",sizeStr] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        //删除缓存
//        [LYLClearCache clearCache:path];
        
        LYLDataBase *shopDataBase = [LYLDataBase shareShopLifeDataBase];
        
        [shopDataBase deleteAllGoodData];
        
        LYLDataBase *goodDataBase = [LYLDataBase shareLikeGoodsDataBase];
        
        [goodDataBase deleteAllGoodData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sureAction];
    
    [alert addAction:cancelAction];
    
    //显示
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)aboutClick
{
    LYLAboutViewController *aboutVC = [[LYLAboutViewController alloc] init];
    aboutVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:aboutVC animated:YES];
}





@end
