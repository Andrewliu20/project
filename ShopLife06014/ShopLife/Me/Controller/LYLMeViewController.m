//
//  LYLMeViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLMeViewController.h"
#import "LYLMeHeaderView.h"
#import "LYLDataBase.h"
#import "LYLGoodModel.h"
#import "LYLGoodShowViewController.h"
#import "LYLLikeGoodsCell.h"
#import "LYLSettingViewController.h"
#import "UMSocial.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>


@interface LYLMeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UMSocialUIDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) LYLDataBase *dataBase;

@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation LYLMeViewController

{
    NSArray *_goodsId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";

    [self initTable];
    
   
    [self loadAllData];

    
    [self addRefresh];
}

#pragma mark -- 集成刷新 --

-(void) addRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //加载数据
        
        [self loadAllData];
    }];
    
    self.collectionView.header = header;
}

- (void)loadAllData
{
    
     _goodsId = [self.dataBase fillAllGoodsId];
    if (self.collectionView.header.isRefreshing) {
        
        [self.dataSource removeAllObjects];
        
        if (_goodsId.count == 0) {
            
             [self.collectionView.header endRefreshing ];
            [self.collectionView reloadData];
        }
    }
    
    if (_goodsId.count>0) {
        //显示菊花
        [self showLoadView];
    }
    
    
    for (NSString *idString in _goodsId) {
        
        [self loadData:idString];
    }


}

- (void)loadData:(NSString *)goodID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    
    [manager GET:[NSString stringWithFormat:GoodURL,goodID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"数据请求成功==%@",responseObject[@"tbkPageUrl"]);
        
        LYLGoodModel *model = [[LYLGoodModel alloc] init];
        
        model.price = responseObject[@"goods"][@"price"];
        model.title = responseObject[@"goods"][@"title"];
        model.url = responseObject[@"goods"][@"url"];
        model.imageList = responseObject[@"goods"][@"imageList"][0];
        model.detail = responseObject[@"tbkPageUrl"];
        model.sid = responseObject[@"shop"][@"sid"];
        model.shopName = responseObject[@"shop"][@"name"];
        //初始化界面
        [self.dataSource addObject:model];
        
        if (self.dataSource.count  == _goodsId.count) {
            [self.collectionView reloadData];
            
            //取消下来刷新效果
            
            [self.collectionView.header endRefreshing ];
            
            //隐藏加载菊花
            [self hideLoadView];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败!error=%@",error);
        [self.collectionView.header endRefreshing ];
        
        //隐藏加载菊花
        [self hideLoadView];
    }];

}

#pragma mark -- 初始化界面
- (void)initTable{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 10;
    
    //设置方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建collectionView
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[LYLMeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LYLLikeGoodsCell"  bundle:nil]  forCellWithReuseIdentifier:@"likeGoodsCell"];

    
}



#pragma mark -- 实现collection的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (_goodsId.count==0) {
//        return 1;
//    }
    return self.dataSource.count;
}

//设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 15, 120);
}

//创建Item

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LYLLikeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"likeGoodsCell" forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = (LYLLikeGoodsCell *)[[NSBundle mainBundle] loadNibNamed:@"LYLLikeGoodsCell" owner:self options:nil];
    }
    
    
    [cell setModel:self.dataSource[indexPath.item]];
    
  

    UILongPressGestureRecognizer *goodGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(goodLongPressClick:)];
    
    
    
    goodGesture.minimumPressDuration = 1;
    [cell.contentView addGestureRecognizer:goodGesture];
    
    return cell;
    
}


- (void)goodLongPressClick:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
        
        
      
        CGPoint point = [gesture locationInView:self.collectionView];
        NSIndexPath *pahtIndex = [self.collectionView indexPathForItemAtPoint:point];
       
        
       
        
        LYLGoodModel *model = self.dataSource[pahtIndex.item];
        
        
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:model.imageList
         ];
        
        //分享到QQ好友
        [UMSocialData defaultData].extConfig.qqData.title = model.title;

        [UMSocialData defaultData].extConfig.qqData.url = model.url;
        
//        //分享到QQ空间
      
        [UMSocialData defaultData].extConfig.qzoneData.title = model.title;
        [UMSocialData defaultData].extConfig.qzoneData.url= model.url;
        
       
        //分享到微博
        [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@ %@",model.shopName,model.url];
        
        
        //分享到微信好友
        [UMSocialData defaultData].extConfig.wechatSessionData.title = model.title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = model.url;
        
        //分享到微信朋友圈
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = model.title;
//        [UMSocialData defaultData].extConfig.wechatTimelineData.url = model.url;
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"575a8a4667e58e1807002240"
                                          shareText:model.shopName
                                         shareImage:nil
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                           delegate:self];
        
      

    }
    
 
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    return YES;
   
}
//分享成功回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


// header的实现
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LYLMeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        
        [header refreshGoogsCount:[NSString stringWithFormat:@"%zd",self.dataSource.count] andVC:self];
        
        //添加回调实现点击设置跳转
        
//        [header setGetGestureBlock:^(UITapGestureRecognizer * gesture) {
//            
//            LYLSettingViewController *settingVC = [[LYLSettingViewController alloc]init];
//            
//            [self.navigationController pushViewController:settingVC animated:YES];
//        }];
        return header;
        
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYLGoodShowViewController *goodShop = [[LYLGoodShowViewController alloc] init];
    
    goodShop.goodID = _goodsId[indexPath.row];
    [self presentViewController:goodShop animated:YES completion:nil];
}

//设置header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 150);
}

//设置边界间距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 10, 5, 10);
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray   array];
    }
    return _dataSource;
}

- (LYLDataBase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [LYLDataBase shareLikeGoodsDataBase];
    }
    return _dataBase;
}


@end
