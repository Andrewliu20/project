//
//  LYLAdviceShopViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/20.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLAdviceShopViewController.h"
#import "LYLHomeSubjectModel.h"
#import "LYSubjectCell.h"

@interface LYLAdviceShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;



@end

@implementation LYLAdviceShopViewController
{
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小编精选";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _page = 0;
    
    [self initTableView];
    
    [self loadData];
 
    [self addRefresh];
    
}



- (void)addRefresh
{
    //下载刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //还原页码
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


#pragma mark -- 页面加载 --

- (void)initTableView {
    // 获取实际高度
    //  CGFloat height = SCREENHEIGHT - 64 - 49;
    // CGRectMake(0, 0, SCREENWIDTH, height)
   
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
    //去除多余的cell中的道道
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 49, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LYSubjectCell" bundle:nil] forCellReuseIdentifier:@"subjectCell"];
}




#pragma mark -- 协议的实现 --


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    LYSubjectCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"subjectCell"];
    if (!cell) {
        cell = [[LYSubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"subjectCell"];
    }
    
    [cell setModel:self.dataSource[indexPath.row] andHomeVc:self];
//    cell.model = ;
    
    return cell;

    
}


#pragma mark --加载数据 --
- (void)loadData

{
    //加载菊花
    [self showLoadView];
    
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *currentPage = [NSString stringWithFormat:@"%zd",_page];
    
    [manager GET:[NSString stringWithFormat:HomeDetailSuject_URL,self.subjectId,currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"数据加载成功 = %@",responseObject);
        if (self.tableView.header.isRefreshing) {
            // 先清空数组中原来的内容
            
            
            [self.dataSource removeAllObjects];
        }
    
        
        NSArray *allData = responseObject[@"subjectList"];
        
        NSArray *models = [LYLHomeSubjectModel arrayOfModelsFromDictionaries:allData];
        
        [self.dataSource addObjectsFromArray:models];
        
        //刷新表格
        
        [self.tableView reloadData];
        
        [self hideLoadView];
        //停止刷新
        [self.tableView.header endRefreshing] ;
        
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据加载失败");
        
        [self hideLoadView];
        [self.tableView.header endRefreshing] ;
        
        [self.tableView.footer endRefreshing];
    }];
    
    
}


#pragma mark -- 懒加载-- 

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return  _dataSource;
}

@end
