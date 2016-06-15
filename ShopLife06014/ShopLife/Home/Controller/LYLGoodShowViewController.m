//
//  LYLGoodShowViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/5/27.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLGoodShowViewController.h"
#import "UIImageView+WebCache.h"
#import "LYLShopInfoViewController.h"
#import "LYLGoodModel.h"
#import "LYLTaoBaoViewController.h"
#import "LYLDataBase.h"


@interface LYLGoodShowViewController ()
@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong)  UIImageView *likeImageView;

@property (nonatomic,strong)  LYLGoodModel *model;

@property (nonatomic,strong)  UIImageView *shopimageView;

@property (nonatomic,strong) LYLDataBase *dataBase;

@end

@implementation LYLGoodShowViewController
{
    //用来标志是否like
    BOOL flag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    flag = YES;
    
    self.view.backgroundColor =  [UIColor whiteColor];
    [self loadData];

}


#pragma mark -- 加载数据

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:GoodURL,self.goodID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"数据请求成功==%@",responseObject[@"tbkPageUrl"]);
        
        _model = [[LYLGoodModel alloc] init];
        
        _model.price = responseObject[@"goods"][@"price"];
        _model.title = responseObject[@"goods"][@"title"];
        _model.url = responseObject[@"goods"][@"url"];
        _model.imageList = responseObject[@"goods"][@"imageList"][0];
        _model.detail = responseObject[@"tbkPageUrl"];
        _model.sid = responseObject[@"shop"][@"sid"];
        _model.shopName = responseObject[@"shop"][@"name"];
        //初始化界面
        [self initView:self.model];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败!error=%@",error);
    }];
    
}

#pragma mark -- 初始化界面
- (void)initView:(LYLGoodModel *)model
{
    //商品图片
    UIImageView *goodIamageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    [goodIamageView sd_setImageWithURL:[NSURL URLWithString:model.imageList]];
    
    [self.view addSubview:goodIamageView];
    
    //添加返回上一页面的按钮
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 30, 30)];
    
    self.backImageView.image = [UIImage imageNamed:@"xzzm_Commons_back"];
    
    self.backImageView.userInteractionEnabled = YES;
    goodIamageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *backGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    
    
    [self.backImageView addGestureRecognizer:backGesture];
    
    [goodIamageView addSubview:self.backImageView];

    
    //商品信息
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2+10 , self.view.frame.size.width - 20, 80)];
    
    descLabel.backgroundColor = [UIColor whiteColor];
    descLabel.text = [NSString stringWithFormat:@"宝贝简介:%@", model.title];
    descLabel.textColor = [UIColor blackColor];
    descLabel.numberOfLines = 0;
    
    [self.view addSubview:descLabel];
    
    //价格
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2+80, 100, 80)];
    
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.text = [NSString stringWithFormat:@"¥:%@",model.price];
    priceLabel.textColor = [UIColor orangeColor];
    priceLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:priceLabel];
    
    //detail 详情按钮all_buy
    
    UIImageView *detailImage= [[UIImageView alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height/2+100, 80, 40)];
    
    detailImage.image = [UIImage imageNamed:@"all_buy"];
    
    [self.view addSubview:detailImage];
    
    //对detail添加手势
    
    detailImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *detailGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailClick)];
    
    [detailImage addGestureRecognizer:detailGesture];
    
    
    //添加喜欢按钮
    
    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width/2, 50)];
    
    likeButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:likeButton];
    //在该button上添加like图片
    
    _likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80 , 10, 31, 26)];
    
    //判断是否已经添加喜欢
    if ([self.dataBase isExistGoodsId:self.goodID]) {
        //存在
        _likeImageView.image = [UIImage imageNamed:@"xzzm_Goods_liked"];
        
        
        flag = !flag;
        
    }else
    {
        _likeImageView.image = [UIImage imageNamed:@"xzzm_Goods_like"];
    }
    
  

    
    [likeButton addSubview:_likeImageView];
    
    //对likeImageView 添加手势
    
    _likeImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *likeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeGestureClick)];
    
    [_likeImageView addGestureRecognizer:likeGesture];
    
    
    UIButton *intoShopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,  self.view.frame.size.height - 50, self.view.frame.size.width/2, 50)];
    
    intoShopButton.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:intoShopButton];
    
    //在button上添加进入店铺
    
   _shopimageView = [[UIImageView alloc] initWithFrame:CGRectMake(80 , 10, 31, 26)];
    
    _shopimageView.image = [UIImage imageNamed:@"xzzm_Goods_enterShop"];
    
    [intoShopButton addSubview:self.shopimageView];

    
    //添加进入店铺的手势
    
    self.shopimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *shopGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClick:)];
    [self.shopimageView addGestureRecognizer:shopGesture];

}

#pragma mark -- 进入店铺的手势是实现
- (void)shopClick:(UITapGestureRecognizer *)gesture
{

//    NSLog(@"test");
    
    LYLShopInfoViewController *shopInfo = [[LYLShopInfoViewController alloc] init];
    
    
    shopInfo.titleName = self.model.shopName;
    shopInfo.ID = self.model.sid;
    shopInfo.flag = YES;
    
    UINavigationController *shopNav = [[UINavigationController alloc] initWithRootViewController:shopInfo];
    
//    [self.navigationController pushViewController:shopInfo animated:YES];

    [self presentViewController:shopNav animated:YES completion:nil];
}

#pragma mark -- 详情查看手势的实现

-(void)detailClick
{
//    NSLog(@"这个是详情%@",self.model.url);
    
    LYLTaoBaoViewController *taobaoVC = [[LYLTaoBaoViewController alloc] init];
    taobaoVC.url = self.model.url;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:taobaoVC];
 
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -- liekGesture 手势方法

- (void)likeGestureClick
{
    
    
    
    if (flag) {
        
        //添加物品为喜欢
        
        [self.dataBase addLikeGoodsDB:self.goodID];
        
         self.likeImageView.image = [UIImage imageNamed:@"xzzm_Goods_liked@2x"];
        flag = !flag;
    }else
    {
        
        [self.dataBase deleteLikeGoodsDB:self.goodID];
        self.likeImageView.image = [UIImage imageNamed:@"xzzm_Goods_like@2x"];
        flag = !flag;

    }
   
}


#pragma mark -- 添加返回的视图


- (void)backClick
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (LYLDataBase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [LYLDataBase shareLikeGoodsDataBase];
    }
    
    return _dataBase;
}
@end
