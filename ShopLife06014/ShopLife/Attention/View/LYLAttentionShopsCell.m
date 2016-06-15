//
//  LYLAttentionShopsCell.m
//  ShopLife
//
//  Created by andrewliu on 16/6/6.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLAttentionShopsCell.h"
#import "UIImageView+WebCache.h"

@interface LYLAttentionShopsCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodNewLabel;


@property (weak, nonatomic) IBOutlet UIImageView *firstImage;

@property (weak, nonatomic) IBOutlet UIImageView *secondImage;

@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;


@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;


@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;


@end

@implementation LYLAttentionShopsCell


- (void)setModel:(LYLShopInfoModel *)model
{
    ShopInfo *shop = model.shop;
    //添加店铺图标
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:shop.shopPic]];
    //添加店铺名字
    self.titleLabel.text = shop.name;
    
    //新添加的宝贝数量(这里的数据是随机数生成的,哈哈哈)
    
    self.goodNewLabel.text = [NSString stringWithFormat:@"新上架%d件宝贝",(arc4random()%20)+1];
    
    
    
    //添加四张图片
    NSMutableArray *picStrArr = [NSMutableArray array];
    for (ItemlistInfo *itemInfo in model.itemList) {
      
        if (!itemInfo.isBig&&picStrArr.count<=4){
            //这里是获取小图片
            [picStrArr addObject: [itemInfo.goodsList[0] pic]];
                    
            [picStrArr addObject:[itemInfo.goodsList[1] pic]];
            
            
        }
   
    }
    
    [self.firstImage sd_setImageWithURL:[NSURL URLWithString:picStrArr[0]]];
    
    [self.secondImage sd_setImageWithURL:[NSURL URLWithString:picStrArr[1]]];
    
    [self.thirdImage sd_setImageWithURL:[NSURL URLWithString:picStrArr[2]]];
    
    [self.fourthImage sd_setImageWithURL:[NSURL URLWithString:picStrArr[3]]];
    
    
    
    //添加物品更新时间(先不处理)
   
    
    
}

@end
