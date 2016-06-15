//
//  LYLShopTopCell.m
//  ShopLife
//
//  Created by andrewliu on 16/5/25.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShopTopCell.h"
@interface LYLShopTopCell()
@property (weak, nonatomic) IBOutlet UIImageView *iocnImage;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation LYLShopTopCell

- (void)setModel:(ShopInfo*)model
{
   
    [self.iocnImage sd_setImageWithURL:[NSURL URLWithString:model.shopPic]];
    
    self.titleNameLabel.text = model.name;
    self.descLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_descBg"]];
   // self.descLabel.text = model.shop.item_score_type
    if ([model.item_score_type isEqualToString:@"0"]) {
        self.descLabel.text = [NSString stringWithFormat:@"描述相符:%@ 与同行持平",model.item_score];
    }else
    {
        self.descLabel.text = [NSString stringWithFormat:@"描述相符:%@ 高于同行",model.item_score];
    }


}

//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


@end
