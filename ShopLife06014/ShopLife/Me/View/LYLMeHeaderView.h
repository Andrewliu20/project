//
//  LYLMeHeaderView.h
//  ShopLife
//
//  Created by andrewliu on 16/6/7.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLMeViewController.h"
@interface LYLMeHeaderView : UICollectionReusableView


- (void)refreshGoogsCount:(NSString *)count andVC:(LYLMeViewController *)meVC;

@property (nonatomic,copy) void (^getGestureBlock)(UITapGestureRecognizer *);
@end
