//
//  LYLAboutViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/8.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLAboutViewController.h"
#define SCREEN_H self.view.frame.size.height
#define SCREEN_W self.view.frame.size.width
@interface LYLAboutViewController ()

@property (nonatomic,strong) UIImageView *versionImage;

@property (nonatomic,strong) UIImageView *checkeVersionImage;

@property (nonatomic,strong) UILabel *descLabel ;

@property (nonatomic,strong) UILabel *versionLael;

@property (nonatomic,strong) UILabel *contactLabel;
@end

@implementation LYLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);

    
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView{
    
    _versionImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W/10,SCREEN_H/10, SCREEN_W-(SCREEN_W/10)*2, SCREEN_H/10)];
    
    _versionImage.image = [UIImage imageNamed:@"xzzm_Settings_aboutMessageBg"];
    
    [self.view addSubview:self.versionImage];
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    _versionLael = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_W-(SCREEN_W/10)*2, SCREEN_H/10)];
    _versionLael.text = [NSString stringWithFormat:@"版本:     %@",version];
    _versionLael.textAlignment = NSTextAlignmentLeft;
    
    _versionLael.font = [UIFont systemFontOfSize:17];
    
    [self.versionImage addSubview:self.versionLael];
    
    
    _checkeVersionImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W/10,SCREEN_H/4, SCREEN_W-(SCREEN_W/10)*2, SCREEN_H/10)];
    
    _checkeVersionImage.image = [UIImage imageNamed:@"xzzm_Settings_versionCheckBtn"];
    
    [self.view addSubview:self.checkeVersionImage];
    
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/5, SCREEN_H/1.2, SCREEN_W-(SCREEN_W/5)*2, SCREEN_H/20)];
    
    _descLabel.text = @"烟台Binary网络有限公司";
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.numberOfLines = 0;
    
    [self.view addSubview:self.descLabel];
    
    _contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/5, SCREEN_H/1.1 ,SCREEN_W-(SCREEN_W/5)*2, SCREEN_H/20)];
    _contactLabel.text = @"合作事宜联系:andrewliu20@163.com";
    _contactLabel.textAlignment = NSTextAlignmentCenter;
    _contactLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.contactLabel];
    
    //对检测新版本添加手势
    
    self.checkeVersionImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *checkVersionGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkVersionClick)];
    
    [self.checkeVersionImage addGestureRecognizer:checkVersionGesture];
}


- (void)checkVersionClick
{
    [self alertView:@"已经是最新版本"];
}

- (void)alertView:(NSString *)msg {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示消息" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:alertAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
