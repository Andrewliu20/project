//
//  LYLShowShopViewController.m
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLShowShopViewController.h"
#import "LYLShowShopModel.h"
#import "LYLShowShopCell.h"
#import "LYLShowShopBigImageCell.h"

@interface LYLShowShopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;



@end

@implementation LYLShowShopViewController
{
    NSInteger _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //页码
    _page = 0;
    
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
        
        [self loadData];
    }];
    
    self.tableView.header = header;

    // 集成上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page += 1;
        
        [self loadData];
    }];
    
    // 添加刷新尾部
    self.tableView.footer = footer;

    
}


#pragma mark -- 加载数据 --
- (void)loadData
{
     //显示菊花
    [self showLoadView];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    [manger GET:[NSString stringWithFormat:HomeDetailShop_URL,self.subjectId,[NSString stringWithFormat:@"%zd",_page]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

      
        if (self.tableView.header.isRefreshing) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *shops = responseObject[@"shopList"];
        
        NSArray *models = [LYLShowShopModel arrayOfModelsFromDictionaries:shops];
        
        [self.dataSource addObjectsFromArray:models];
        
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
    
    
       
       // 获取实际高度
    //  CGFloat height = SCREENHEIGHT - 64 - 49;
    // CGRectMake(0, 0, SCREENWIDTH, height)
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //从导航栏下面开始计算坐标
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //去除多余的道
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
   
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    // 注册cell
   
    [self.tableView registerNib:[UINib nibWithNibName:@"LYLShowShopCell" bundle:nil] forCellReuseIdentifier:@"showShopCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYLShowShopBigImageCell" bundle:nil] forCellReuseIdentifier:@"showShopBigCell"];
}



#pragma mrak -- 协议的实现 --

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL b = [[self.dataSource[indexPath.row] itemList][2] isBig];
    if (!b) {
        return  730;
    }else
    {
        return 925;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //得到self.dataSource数组中的itemList数据中的isBig值，用这个值判断使用那个自定义的cell
    
    BOOL b = [[self.dataSource[indexPath.row] itemList][2] isBig];
    
    if (!b) {
        
        LYLShowShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showShopCell"];

        
    [cell setModel:self.dataSource[indexPath.row] andShowShopVC:self];
    return cell;
        
    }else
    {
        
        LYLShowShopBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"showShopBigCell"];


        [cell setModel:self.dataSource[indexPath.row] andShowShopVC:self];
        
        return cell;

        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 懒加载 --

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
