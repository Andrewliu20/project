//
//  LYLLikeGoodsCell.m
//  ShopLife
//
//  Created by andrewliu on 16/6/7.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLLikeGoodsCell.h"
#import "UIImageView+WebCache.h"


@interface LYLLikeGoodsCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation LYLLikeGoodsCell
{
    LYLGoodModel  *_model;
}

- (void)setModel:(LYLGoodModel *)model
{
    _model = model;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.imageList]];
    
    self.priceLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@",model.price];
    

}





@end
