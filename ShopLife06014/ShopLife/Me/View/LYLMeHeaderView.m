//
//  LYLMeHeaderView.m
//  ShopLife
//
//  Created by andrewliu on 16/6/7.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLMeHeaderView.h"
#import "LYLSettingViewController.h"


@interface LYLMeHeaderView()

@property (nonatomic,strong) UIImageView *headerBgImage;

@property (nonatomic,strong) UIImageView *iconImage;

@property (nonatomic,strong) UIImageView *settingImage;

@property (nonatomic,strong) UILabel *descLabel;

@end

@implementation LYLMeHeaderView
{
    LYLMeViewController *_meVC;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.headerBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.headerBgImage.image = [UIImage imageNamed:@"xzzm_Shop_headerBg@2x"];
    
    [self addSubview:self.headerBgImage];
    
    
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-30, self.frame.size.height/2-30, 60,60 )];
    
    self.iconImage.image = [UIImage imageNamed:@"xzzm_Me_headerPortrait@2x"];
    
    
    
    [self.headerBgImage addSubview:self.iconImage];
    
    self.settingImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-45, 20, 30, 30)];
    
    self.settingImage.image = [UIImage imageNamed:@"xzzbk_home_settingBtn@2x"];
    
    [self.headerBgImage addSubview:self.settingImage];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-40, self.frame.size.height-40, 100, 20)];
    
//    self.descLabel.backgroundColor = [UIColor redColor];
    
    [self.headerBgImage addSubview:self.descLabel];
    
    
    //对设置添加手势
    
    self.settingImage.userInteractionEnabled = YES;
    self.headerBgImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *settingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingClick:)];
    
    [self.settingImage addGestureRecognizer:settingGesture];
    
}

#pragma mark -- 实现设置手势方法
- (void)settingClick:(UITapGestureRecognizer *)gesture
{
//    self.getGestureBlock(gesture);
    
    LYLSettingViewController *settingVC = [[LYLSettingViewController alloc]init];
    
    settingVC.hidesBottomBarWhenPushed = YES;
    
    [_meVC.navigationController pushViewController:settingVC animated:YES];
    
}




- (void)refreshGoogsCount:(NSString *)count andVC:(LYLMeViewController *)meVC
{
    _meVC = meVC;
    self.descLabel.text = [NSString stringWithFormat:@"我喜欢的商品(%@)",count];
    
    self.descLabel.textColor = [UIColor greenColor];
    
    self.descLabel.font = [UIFont systemFontOfSize:13];
    
}
@end
