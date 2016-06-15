//
//  LYSubjectCell.m
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYSubjectCell.h"
#import "LYLShowShopViewController.h"
#import "LYLAdviceShopViewController.h"

@interface LYLHomeSubjectModel()

@end
@implementation LYSubjectCell
{
    LYLHomeSubjectModel *_model;
    LYLAdviceShopViewController *_shopVC;
}

- (void)setModel:(LYLHomeSubjectModel *)model andHomeVc:homeVC
{
    _model = model;
    _shopVC = homeVC;
    
    [self.BgImage sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    self.title.text = [NSString stringWithFormat:@"\t%@  (%@)",model.title,model.subDate];
    
    [self.BgImage.layer setMasksToBounds:YES];
   // self.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
    [self.title.layer setMasksToBounds:YES];
    
    self.BgImage.layer.cornerRadius = 10.0;
    
    //self.title.layer.cornerRadius = 10.0;
    
    //添加手势
    
    self.BgImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *subjectGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subjectClick)];

    [self.BgImage addGestureRecognizer:subjectGesture];
}

#pragma mark -- 实现手势方法

- (void)subjectClick
{
    LYLShowShopViewController *showShopVC = [[LYLShowShopViewController alloc] init];
    
    showShopVC.subjectId = _model.subjectId;
    showShopVC.title  = _model.title;
    
    
    [_shopVC.navigationController pushViewController:showShopVC animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


@end
