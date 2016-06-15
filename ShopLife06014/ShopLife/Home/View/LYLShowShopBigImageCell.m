//
//  LYLShowShopBigImageCell.m
//  ShopLife
//
//  Created by System Administrator on 16/5/22.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShowShopBigImageCell.h"
#import "LYLGoodShowViewController.h"

@interface LYLShowShopBigImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UIImageView *iocn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;


@property (weak, nonatomic) IBOutlet UIImageView *upImage;


@property (weak, nonatomic) IBOutlet UIImageView *goShopImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UILabel *upLabel;

@end

@implementation LYLShowShopBigImageCell

{
    LYLShowShopModel *_shopModel;
    LYLShowShopViewController *_showShopVC;
}

- (void)setModel:(LYLShowShopModel *)model andShowShopVC:(LYLShowShopViewController *)showShopVC
{
    _shopModel = model;
    _showShopVC = showShopVC;
    
    self.titleLabel.text = [model shop].name;
    
    [self.iocn sd_setImageWithURL:[NSURL URLWithString:[model shop].shopPic ]];
   
  
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
    
    //布局left位置的图片
    
    NSString *leftTopPicURL =  [[[model itemList][1] goodsList][0] pic];
    
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:leftTopPicURL]];

    //价格
    
    self.leftLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.leftLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][1] goodsList][0] price]];
    
    //布局rightTop位置的图片信息
    
    NSString *rightTopPicURL =  [[[model itemList][1] goodsList][1] pic];
    
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:rightTopPicURL]];
    
    
    //价格
    self.rightLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.rightLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][1] goodsList][1] price]];
    //布局dowm位置的图片
    
    NSString *upPicURL = [[[model itemList][2] goodsList][0] pic];
    
    [self.upImage sd_setImageWithURL:[NSURL URLWithString:upPicURL]];
    
    //价格
    self.upLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xzzm_Subject_priceLabelBg@2x"]];
    
    self.upLabel.text = [NSString stringWithFormat:@"¥%@", [[[model itemList][2] goodsList][0] price]];
    
    //shopImage添加手势
    
    //shopicon的手势
    self.iocn.userInteractionEnabled = YES;
    self.shopImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *shopGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
    
    [self.shopImage addGestureRecognizer: shopGesture];
    
     //top位置的手势
    self.priceLabel.userInteractionEnabled = YES;
    self.topImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *topImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageClick)];
    
    [self.topImage addGestureRecognizer: topImageGesture];
    
    //left位置的图片手势
    self.leftLabel.userInteractionEnabled = YES;
    self.leftImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *leftImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftImageClick)];
    
    [self.leftImage addGestureRecognizer: leftImageGesture];
    
    //添加right位置的图片的手势
    self.rightLabel.userInteractionEnabled = YES;
    self.rightImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *rightImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightImageClick)];
    
    [self.rightImage addGestureRecognizer: rightImageGesture];
    
    
    //添加upImage的图片的手势
    self.upLabel.userInteractionEnabled = YES;
    self.upImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *upImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upImageClick)];
    
    [self.upImage addGestureRecognizer: upImageGesture];
    
    //添加进入店铺的手势
    self.goShopImage.userInteractionEnabled = YES;
    
     UITapGestureRecognizer *goShopGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick)];
    
    [self.goShopImage addGestureRecognizer:goShopGesture];
}

- (void)upImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][2] goodsList][0] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];

}

#pragma mark -- rightImage手势的方法的实现
- (void)rightImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][1] goodsList][1] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}

#pragma mark -- leftImage手势的方法实现
- (void)leftImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID =[[[_shopModel itemList][1] goodsList][0] ID];
    [_showShopVC presentViewController:goodShop animated:YES completion:nil];
}

#pragma mark -- topImage手势方法的实现
- (void)topImageClick
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
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
    
}

//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
