//
//  LYLShowShopCell.m
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShowShopCell.h"
#import "LYLShopInfoViewController.h"
#import "LYLGoodShowViewController.h"

@interface LYLShowShopCell() 

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;



@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (weak, nonatomic) IBOutlet UIImageView *leftTopImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UIImageView *rightTopImage;


@property (weak, nonatomic) IBOutlet UIImageView *leftUpImage;


@property (weak, nonatomic) IBOutlet UIImageView *rightUpImage;

@property (weak, nonatomic) IBOutlet UIImageView *goShopImage;

@property (weak, nonatomic) IBOutlet UILabel *rightTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;


@property (weak, nonatomic) IBOutlet UILabel *rightUpLabel;


@property (weak, nonatomic) IBOutlet UILabel *leftUpLabel;

@end

@implementation LYLShowShopCell
{
    LYLShowShopViewController *_showShopVC;
    LYLShowShopModel *_shopModel;
}

- (void)setModel:(LYLShowShopModel *)model andShowShopVC:(LYLShowShopViewController *)showShopVC
{
    _showShopVC = showShopVC;
    _shopModel = model;
    
    self.titleLabel.text = [model shop].name ;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[model shop].shopPic ]];
    
    if ([[model shop].item_score_type isEqualToString:@"0"]) {
         self.descLabel.text = [NSString stringWithFormat:@"描述相符:%@ 与同行持平",[model shop].item_score];
    }else
    {
         self.descLabel.text = [NSString stringWithFormat:@"描述相符:%@ 高于同行",[model shop].item_score];
    }
    
    
    
    //布局top位置的商品信息图片
    
    NSString *picURL =  [[[model itemList][0] goodsList][0] pic];
    
    [self.topImage sd_setImageWithURL:[NSURL URLWithString: picURL]];
    
    //该物品的价格
    self.priceLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",[[[model itemList][0] goodsList][0] price]];
    
    //布局leftTop位置的图片
    
    NSString *leftTopPicURL =  [[[model itemList][1] goodsList][0] pic];
    
    [self.leftTopImage sd_setImageWithURL:[NSURL URLWithString:leftTopPicURL]];
    
    //该物品的价格
    
    self.leftTopLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.leftTopLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][1] goodsList][0] price]];
    
    //布局rightTop位置的图片信息
    
    NSString *rightTopPicURL =  [[[model itemList][1] goodsList][1] pic];
    
    [self.rightTopImage sd_setImageWithURL:[NSURL URLWithString:rightTopPicURL]];
    
    //价格
    self.rightTopLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    self.rightTopLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][1] goodsList][1] price]];
    
   //布局leftUp位置的图片
    NSString *leftUpPicURL =  [[[model itemList][2] goodsList][0] pic];
    
    [self.leftUpImage sd_setImageWithURL:[NSURL URLWithString:leftUpPicURL]];
    
    
    //价格
    self.leftUpLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.leftUpLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][2] goodsList][0] price]];
    
    //布局rightUp位置的图片
    
    NSString *rightUpPicURL =  [[[model itemList][2] goodsList][1] pic];
    
    [self.rightUpImage sd_setImageWithURL:[NSURL URLWithString:rightUpPicURL]];
    
    //价格
    
    self.rightUpLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.rightUpLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][2] goodsList][1] price]];
    
    
    
    //对点击事件添加手势
    
    //shopImage添加手势
    
    self.icon.userInteractionEnabled = YES;
    self.shopImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *shopGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
    
    [self.shopImage addGestureRecognizer: shopGesture];
    
    //top位置的手势
    self.priceLabel.userInteractionEnabled = YES;
    self.topImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *topImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageClick)];
    
    [self.topImage addGestureRecognizer: topImageGesture];
    
    //lefttop位置的图片手势
    self.leftTopLabel.userInteractionEnabled = YES;
    self.leftTopImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *leftTopImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTopImageClick)];
    
    [self.leftTopImage addGestureRecognizer: leftTopImageGesture];
    
    //添加righttop位置的图片的手势
    self.rightTopLabel.userInteractionEnabled = YES;
    self.rightTopImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rightTopImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTopImageClick)];
    
    [self.rightTopImage addGestureRecognizer: rightTopImageGesture];

    
    //leftup位置的图片手势
    self.leftUpLabel.userInteractionEnabled = YES;
    self.leftUpImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *leftUpImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftUpImageClick)];
    
    [self.leftUpImage addGestureRecognizer: leftUpImageGesture];
    
    //添加rightUP位置的图片的手势
    self.rightUpLabel.userInteractionEnabled = YES;
    self.rightUpImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rightUpImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightUpImageClick)];
    
    [self.rightUpImage addGestureRecognizer: rightUpImageGesture];
    
    //添加进入店铺的手势
    self.goShopImage.userInteractionEnabled = YES;
     UITapGestureRecognizer *goShopGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
    [self.goShopImage addGestureRecognizer:goShopGesture];
}
#pragma mark -- rightTopImage手势的方法的实现
- (void)rightUpImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][2] goodsList][1] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
    
    
}

#pragma mark -- leftTopImage手势的方法实现
- (void)leftUpImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][2] goodsList][0] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}


#pragma mark -- rightTopImage手势的方法的实现
- (void)rightTopImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][1] goodsList][1] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}

#pragma mark -- leftTopImage手势的方法实现
- (void)leftTopImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][1] goodsList][0] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}


#pragma mark -- topImage手势方法的实现
- (void)topImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][0] goodsList][0] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}

#pragma mark -- shop手势方法的实现

- (void)shopClick
{
    
    LYLShopInfoViewController *shopInfo = [[LYLShopInfoViewController alloc] init];
    
    
    shopInfo.titleName =  [_shopModel shop].name;
    shopInfo.ID = [_shopModel shop].sid;
    
    [_showShopVC.navigationController pushViewController:shopInfo animated:YES];
    
//    [_showShopVC presentViewController:shopInfo animated:YES completion:nil];
}

//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


@end
