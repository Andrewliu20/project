//
//  LYLOtherListCell.m
//  ShopLife
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLOtherListCell.h"
#import "LYLAdviceShopViewController.h"
#import "LYLHomeViewController.h"
#import "LYLShowShopViewController.h"

@interface LYLOtherListCell()

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;


@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (nonatomic,strong) LYLHomeViewController *homeVC;

@end

@implementation LYLOtherListCell
{
    LYLHomeModel *_model_1;
    LYLHomeModel *_model_2;
    
    //获得当前cell的tableView
    LYLHomeViewController *_homeVC;
}



- (void)setModel:(LYLHomeModel *)model_1 andModel:(LYLHomeModel *)model_2 andHomeVc:homeVC
{
    
    _model_1 = model_1;
    
    _model_2 = model_2;
    
    _homeVC = homeVC;
    
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:model_1.pic]];
    
    
    self.leftImage.userInteractionEnabled = YES;
    
    
    
    self.leftLabel.text = model_1.title;
  
    
    self.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];

    
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:model_2.pic]];
    
    self.rightImage.userInteractionEnabled = YES;
    
    self.rightLabel.text = model_2.title;
    
    //对图片添加手势
    
    UITapGestureRecognizer *leftGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailShop_1:)];
    
    UITapGestureRecognizer *rightGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailShop_2:)];
    [self.leftImage addGestureRecognizer:leftGesture];
    
    [self.rightImage addGestureRecognizer:rightGesture];
}

#pragma mark -- 查看详细店铺 --
- (void) detailShop_1:(UITapGestureRecognizer *)gesture
{
//    NSLog(@"modelClick = %@",_model_1.subjectid);
    
    
//    UIImageView *imageView = (UIImageView *)gesture.view;
    
    
    
//    LYLOtherListCell *temp = (LYLOtherListCell *)[[[imageView superview] superview ]class];
    
    
    
    if ([_model_1.type isEqualToString:@"subject"]) {
        
        LYLAdviceShopViewController *adviceShopVC = [[LYLAdviceShopViewController alloc] init];
        
        adviceShopVC.subjectId = _model_1.subjectid;
        
        
        adviceShopVC.hidesBottomBarWhenPushed = YES;
        [_homeVC.navigationController pushViewController:adviceShopVC animated:YES];
    }
    
    if ([_model_1.type isEqualToString:@"shop"]) {
        
        LYLShowShopViewController *showShopVC = [[LYLShowShopViewController alloc] init];
        
        showShopVC.subjectId = _model_1.subjectid;
        showShopVC.titleName = _model_1.title;
        showShopVC.hidesBottomBarWhenPushed = YES;
        
        [_homeVC.navigationController pushViewController:showShopVC animated:YES];
    }
    
}

- (void) detailShop_2:(UITapGestureRecognizer *)gesture
{
    LYLShowShopViewController *showShopVC = [[LYLShowShopViewController alloc] init];
    
    showShopVC.subjectId = _model_2.subjectid;
    showShopVC.titleName = _model_2.title;
    
    showShopVC.hidesBottomBarWhenPushed = YES;
    
    [_homeVC.navigationController pushViewController:showShopVC animated:YES];
}


//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
   
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

}

@end
