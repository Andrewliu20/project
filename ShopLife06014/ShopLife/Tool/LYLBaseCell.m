//
//  LYLBaseCell.m
//  ShopLife
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLBaseCell.h"

@implementation LYLBaseCell



- (void)setModel:(LYLHomeModel *)model
{
    
    
    
    _model = model;
    [self.imageInfo sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    
    [self.imageInfo.layer setMasksToBounds:YES];
    
    self.imageInfo.layer.cornerRadius = 10.0;
    
    self.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
   
   // self.backgroundColor = [UIColor redColor];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    
//}
//
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    
//}

@end
