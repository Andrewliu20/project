//
//  LYLShopImageCell.m
//  ShopLife
//
//  Created by andrewliu on 16/5/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShopImageCell.h"
#import "LYLGoodShowViewController.h"
@interface LYLShopImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;



@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation LYLShopImageCell
{
    GoodslistInfo *_leftGoodsModel;
    GoodslistInfo *_rightGoodsModel;
    LYLShopInfoViewController *_shopInfoVC;
}

- (void)setModel:(GoodslistInfo *)leftGoodsModel andrightModel:(GoodslistInfo *)rightGoodsModel andShopInfoVC:(LYLShopInfoViewController *)shopInfoVC
{
    _leftGoodsModel = leftGoodsModel;
    _rightGoodsModel = rightGoodsModel;
    _shopInfoVC = shopInfoVC;
    
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:leftGoodsModel.pic]];
    
    self.leftLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg"]];
    
    self.leftLabel.text = [NSString stringWithFormat:@"¥%@",leftGoodsModel.price];
    
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:rightGoodsModel.pic]];
    
    self.rightLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg"]];
    
    self.rightLabel.text = [NSString stringWithFormat:@"¥%@",rightGoodsModel.price];

    
    //对图片添加手势,实现跳转
    
    //左边图片
    self.leftLabel.userInteractionEnabled = YES;
    self.leftImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *leftgoodGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftgoodClick)];
    
    [self.leftImage addGestureRecognizer: leftgoodGesture];
    
    //右边图片
    
    self.rightLabel.userInteractionEnabled = YES;
    self.rightImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rightgoodGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightgoodClick)];
    
    [self.rightImage addGestureRecognizer: rightgoodGesture];
    
}

- (void)leftgoodClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID = _leftGoodsModel.ID;
    [_shopInfoVC presentViewController:goodShop animated:YES completion:nil];
}
- (void)rightgoodClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID = _rightGoodsModel.ID;
    [_shopInfoVC presentViewController:goodShop animated:YES completion:nil];
}

//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
