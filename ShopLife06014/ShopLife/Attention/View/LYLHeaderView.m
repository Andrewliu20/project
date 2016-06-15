//
//  LYLHeaderView.m
//  ShopLife
//
//  Created by andrewliu on 16/6/7.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLHeaderView.h"

@interface LYLHeaderView()


@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation LYLHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView{

    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    
    self.bgImageView.image = [UIImage imageNamed:@"xzzm_MyStreet_topBg.png"];
    
    [self addSubview:self.bgImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 60, 100, 18)];
    
    [self.bgImageView addSubview:self.titleLabel];
}

- (void)refreshTitleShopCount:(NSString *)count
{
    
    self.titleLabel.text = [NSString stringWithFormat:@"共关注了%@个店铺",count];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor greenColor];
}


@end
