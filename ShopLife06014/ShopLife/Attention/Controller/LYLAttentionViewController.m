//
//  LYLAttentionViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLAttentionViewController.h"
#import "LYLDataBase.h"
#import "LYLShopInfoModel.h"
#import "LYLAttentionShopsCell.h"
#import "LYLHeaderView.h"

#import "LYLShopInfoViewController.h"

@interface LYLAttentionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSMutableArray *dataSource;


@property (nonatomic,strong) LYLDataBase *dataBase;

@end

@implementation LYLAttentionViewController
{
//    NSInteger *_loadDataCount;
    NSArray *_shopIdArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"关注";
    
    //loadData加载的次数,来统计数据完全加载完毕
//    _loadDataCount = 0;
    
    [self initTable];
    

    [self loadAllData];
    
    [self addRefresh];
}

- (void)loadAllData{
    
    if (self.collectionView.header.isRefreshing) {
        
        [self.dataSource removeAllObjects];
        
        if (_shopIdArr.count == 0) {
            
            [self.collectionView reloadData];
            [self.collectionView.header endRefreshing ];
        }
    }
    _shopIdArr = [self.dataBase fillAllShopId];

    
    if (_shopIdArr.count>0) {
        //显示菊花
        [self showLoadView];
    }
   
    
    for (NSString *idString in _shopIdArr) {
    
        [self loadData:idString];
    }
    
   
}

#pragma mark -- 集成刷新 --

-(void) addRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        _loadDataCount = 0;
        //加载数据
        
        [self loadAllData];
    }];
    
    self.collectionView.header = header;
}

- (void)loadData:(NSString *)idString
{
    
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
        NSString  *shopURL = [NSString stringWithFormat:ShopInfoURL,idString,@0] ;
        
        [manger GET:shopURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
            //将字典转为model
            
            LYLShopInfoModel *shopInfoModel = [LYLShopInfoModel mj_objectWithKeyValues:responseObject];
            
            [self.dataSource addObject:shopInfoModel];
            
            if (self.dataSource.count  == _shopIdArr.count) {
                [self.collectionView reloadData];
                
                //取消下来刷新效果
                
                [self.collectionView.header endRefreshing ];
                
                //隐藏加载菊花
                [self hideLoadView];
            }
          
            

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"数据请求失败");
            
            [self hideLoadView];
            
            [self.collectionView.header endRefreshing ];
        }];
    
}


#pragma mark -- 初始化视图
- (void)initTable{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置最小间距
    flowLayout.minimumLineSpacing = 15;
    
    //设置方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UIControlView
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
   
  
    
    _collectionView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
 
    
    [self.view addSubview:_collectionView];
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
     [_collectionView registerClass:[LYLHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LYLAttentionShopsCell"  bundle:nil]  forCellWithReuseIdentifier:@"attentionShopCell"];
    
}
//组的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return self.dataSource.count;
    
}


//设置大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    return CGSizeMake(self.view.frame.size.width - 40, 180);
    
}

//创建Item

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        LYLAttentionShopsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attentionShopCell" forIndexPath:indexPath];
        
            if (nil == cell) {
                cell = (LYLAttentionShopsCell *)[[NSBundle mainBundle] loadNibNamed:@"LYLAttentionShopsCell" owner:self options:nil].firstObject;
            }
    
   
        cell.model = self.dataSource[indexPath.item];
    
        cell.layer.cornerRadius = 10.0f;
        cell.layer.masksToBounds = YES;
    
        return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LYLHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        
        [header refreshTitleShopCount:[NSString stringWithFormat:@"%ld",_shopIdArr.count]];
        
        
        return header;

    }
    return nil;
}


#pragma mark -- 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYLShopInfoViewController *shopInfo = [[LYLShopInfoViewController alloc] init];
    
    ShopInfo *shop = [self.dataSource[indexPath.item] shop];
    
    shopInfo.titleName = shop.name;
    shopInfo.ID = shop.sid;
    shopInfo.flag = YES;
    
    shopInfo.pageTranform = YES;
    
    
    
    shopInfo.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:shopInfo animated:YES];
    
    [self.navigationController pushViewController:shopInfo animated:YES];

}

//设置header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 150);
}

//设置边界间距

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 0, 0, 0);
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (LYLDataBase *)dataBase
{
    if (_dataBase == nil) {
        _dataBase = [LYLDataBase shareShopLifeDataBase];
    }
    
    return _dataBase;
}


@end
