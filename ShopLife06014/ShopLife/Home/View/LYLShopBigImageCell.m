//
//  LYLShopBigImageCell.m
//  ShopLife
//
//  Created by andrewliu on 16/5/26.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShopBigImageCell.h"
#import "LYLGoodShowViewController.h"

@interface LYLShopBigImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation LYLShopBigImageCell
{
    GoodslistInfo *_goodsModel;
    LYLShopInfoViewController *_shopInfoVC;
}
- (void)setGoodsModel:(GoodslistInfo *)goodsModel andVC:(LYLShopInfoViewController *)shopInfoVC
{
    _goodsModel = goodsModel;
    _shopInfoVC = shopInfoVC;
    
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.pic]];

    
    self.priceLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg"]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsModel.price];
    
    //对图片添加手势,实现跳转
    self.priceLabel.userInteractionEnabled = YES;
    self.shopImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *goodGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodClick)];
    
    [self.shopImage addGestureRecognizer: goodGesture];
    
}

- (void)goodClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    
    goodShop.goodID = _goodsModel.ID;
    
    
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
