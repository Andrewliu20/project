//
//  LYLShopInfoViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/23.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShopInfoViewController.h"
#import "LYLShopInfoModel.h"
#import "LYLShowShopModel.h"
#import "LYLShopTopCell.h"
#import "MJExtension.h"
#import "LYLShopImageCell.h"
#import "LYLShopBigImageCell.h"
#import "LYLDataBase.h"
#import "LYLMainTabBarController.h"

@interface LYLShopInfoViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *itemListArray;

@property (nonatomic,strong) UIImageView *attentionImageView;

@property (nonatomic,strong) LYLDataBase *dataBase;

@end

@implementation LYLShopInfoViewController
{
    NSInteger _page;
    NSString * _listtime;
    NSInteger _indexPathRow;
    BOOL _attentionFlag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listtime = nil;;
    _page = 0;
    _attentionFlag = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    self.title = self.titleName;
    
    [self initTableView];
    
    [self loadData];
    
    [self addRefresh];
}


#pragma mark -- 集成刷新 --

-(void) addRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 0;
        _listtime = nil;
        //加载数据
        
        [self loadData];
    }];
    
    self.tableView.header = header;
    // 集成上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _listtime = [self.dataSource[_page] listtime];
        _page += 1;
        
        [self loadData];
    }];
    
    // 添加刷新尾部
    self.tableView.footer = footer;
}

- (void)loadData
{
    //显示菊花
    [self showLoadView];
    NSString *shopURL;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    if (_page == 0) {
        shopURL = [NSString stringWithFormat:ShopInfoURL,self.ID,[NSString stringWithFormat:@"%zd",_page]] ;
        
//        NSLog(@"%@",shopURL);
    }else
    {
         shopURL = [NSString stringWithFormat:ShopNextInfoURL,self.ID,[NSString stringWithFormat:@"%zd",_page],_listtime] ;
    }
    [manger GET:shopURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.tableView.header.isRefreshing) {
            [self.itemListArray removeAllObjects];
            [self.dataSource removeAllObjects];
        }
        
        //将字典转为model
        
        LYLShopInfoModel *shopInfoModel = [LYLShopInfoModel mj_objectWithKeyValues:responseObject];
      
        _listtime = shopInfoModel.listtime;
        
        [self.dataSource addObject:shopInfoModel];
        
        [self.itemListArray addObjectsFromArray:shopInfoModel.itemList];
        
        [self.tableView reloadData];
        
        //数据加载完毕,取消菊花效果
        
        [self hideLoadView];
        
        //取消下来刷新效果
        
        [self.tableView.header endRefreshing ];
        
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败");
        
        [self hideLoadView];
        
        [self.tableView.header endRefreshing ];
        
        [self.tableView.footer endRefreshing];
    }];
   
}


- (void)initTableView {
    
    //判断如果是从单个物品的页面进入店铺,需要在该页面添加一个返回按钮(LYLShowShioViewController)
    if (self.flag) {
        
        
        UIImageView  *backImage =  [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 30, 30)];
        backImage.image = [UIImage imageNamed:@"xzzm_Commons_back"];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backImage];
        
        
        //对backImage 添加手势
        
        backImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *backGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)];
        
        [backImage addGestureRecognizer:backGesture];
        
        //添加右边的导航栏
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(goHomeClick)];
    }


    
    // 获取实际高度
    //  CGFloat height = SCREENHEIGHT - 64 - 49;
    // CGRectMake(0, 0, SCREENWIDTH, height)
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    [self.view addSubview:self.tableView];
    
    
    
    //在self.view 最上层添加一个imageViw
    
    self.attentionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-90, self.view.frame.size.height - 100, 94, 22)];
    
    
    //需要判断是否已经关注
    if ([self.dataBase isExistShopId:self.ID]) {
      //已经关注该店铺
        self.attentionImageView.image = [UIImage imageNamed:@"xzzm_Shop_unFollow"];
        _attentionFlag = !_attentionFlag;
    }else{
        //没有关注该店铺
         self.attentionImageView.image = [UIImage imageNamed:@"xzzm_Shop_follow"];
    }
    
    [self.view addSubview:self.attentionImageView];
    
   // 对关注店铺添加手势
    
    self.attentionImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *attentionGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionClick)];
    
    [self.attentionImageView addGestureRecognizer:attentionGesture];
    
    //去除多余的cell中的道道
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LYLShopTopCell" bundle:nil] forCellReuseIdentifier:@"shopTopCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"LYLShopBigImageCell" bundle:nil] forCellReuseIdentifier:@"bigImageCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LYLShopImageCell" bundle:nil] forCellReuseIdentifier:@"smallImageCell"];
}


#pragma mark -- 实现关注店铺的手势

- (void)attentionClick
{
    
    if (_attentionFlag) {
        
        //没有关注店铺
        
        if ([self.dataBase deleteShopInfoDB:self.ID]) {
            
            self.attentionImageView.image = [UIImage imageNamed:@"xzzm_Shop_follow"];
            _attentionFlag = !_attentionFlag;
        }else{
            NSLog(@"取消关注店铺失败!");
            
        }
        
        
    }else
    {
        //已关注店铺
        
        if ([self.dataBase addShopInfoDB:self.ID]) {
            
            self.attentionImageView.image = [UIImage imageNamed:@"xzzm_Shop_unFollow"];
            _attentionFlag = !_attentionFlag;
        }else
        {
            NSLog(@"关注店铺失败");
        }
        
       
    }
    
}

//返回主页

- (void)goHomeClick
{
    LYLMainTabBarController *homeVC = [[LYLMainTabBarController alloc] init];

    [self presentViewController:homeVC animated:YES completion:nil];
}

//返回上一页
- (void)backClick:(UITapGestureRecognizer *)gesture
{
    if (self.flag) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (self.pageTranform) {
        
        LYLMainTabBarController *homeVC = [[LYLMainTabBarController alloc] init];
        
        
        homeVC.selectedIndex = 2;
        
        [self presentViewController:homeVC animated:YES completion:nil];
        
    }
}



#pragma mark -- tableView的代理实现 －－

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }else if(indexPath.row == 1 ){
        return 25;
    }
    
     BOOL flag = [self.itemListArray[indexPath.row-2] isBig];
    if (flag) {
        return 300;
    }else
    {
        return 200;
    }
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.dataSource.count == 0) {
        return 0;
    }else
    {
        _indexPathRow = self.itemListArray.count+1;
        return  self.itemListArray.count + 2;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
         LYLShopTopCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"shopTopCell"];
        
        cell.model = [self.dataSource[0] shop];
  
        return cell;
    }
    else if (indexPath.row == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        cell.textLabel.text = [self.dataSource[_page] dateName];
        
        return cell;
        
    }else
    {
        BOOL flag =  [self.itemListArray[indexPath.row - 2] isBig];
        
        if (flag) {
            LYLShopBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bigImageCell"];
            [cell setGoodsModel:[self.itemListArray[indexPath.row - 2] goodsList][0] andVC:self];
           
            return cell;
        }else
        {
            LYLShopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"smallImageCell"];
            
            
            [ cell setModel:[self.itemListArray[indexPath.row - 2] goodsList][0]  andrightModel:[self.itemListArray[indexPath.row - 2] goodsList][1] andShopInfoVC:self];
            
            return cell;
        }
    }
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    if (_page == 0) {
//        return nil;
//    }else
//    {
//         return [self.dataSource[_page] dateName];
//    }
//   
//}

#pragma mark -- 懒加载 －－

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSMutableArray *)itemListArray
{

    if (_itemListArray == nil) {
        _itemListArray = [NSMutableArray array];
    }
    return _itemListArray;
}
#pragma mark -- 数据库懒加载
- (LYLDataBase *)dataBase
{
    if (_dataBase == nil) {
        
        _dataBase = [LYLDataBase shareShopLifeDataBase];
    }
    return _dataBase;
}


@end
