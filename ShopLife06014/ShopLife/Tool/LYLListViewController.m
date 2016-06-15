//
//  LYLListViewController.m
//  ShopLife
//
//  Created by zhuzheng on 16/5/18.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLListViewController.h"
#import "LYLHomeModel.h"
#import "LYLBaseCell.h"
#import "LYLOtherListCell.h"


@interface LYLListViewController ()




@end

@implementation LYLListViewController
{
    //接收传过来的URL,modelName,dictName
    NSString *_path;
    NSString *_modleName;
    NSString *_dictName;
    NSString *_cellName;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    //加载页面
    [self createTableView];
    
    //刷新的实现
    [self addRefresh];
}

#pragma mark -- 下来刷新和上拉加载 ---

- (void)addRefresh
{
    //下载刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        [self loadData:_path andModelName:_modleName andDictName:_dictName andTopDictName:_cellName];
    }];
    
    self.tableView.header = header;

}


#pragma mark -- 数据加载 --

- (void)loadData:(NSString *)pathURL andModelName:(NSString *) modelName andDictName:(NSString *)dictName andTopDictName:(NSString *)topDictName
{
    _path = pathURL;
    _modleName = modelName;
    _dictName = dictName;
   
    
   //加载菊花
    
    [self showLoadView];
       
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:pathURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"数据请求成功");
       
        if (self.tableView.header.isRefreshing) {
            [self.dataSource removeAllObjects];
        }
        
        //otherList的信息
        NSArray *allData = responseObject[dictName];
         //取得Model类
        NSArray *models =  [NSClassFromString(modelName) arrayOfModelsFromDictionaries:allData];
  
        [self.dataSource addObjectsFromArray:models];
 
     //topList的信息
        NSArray *topListData = responseObject[topDictName];
        
      //  NSLog(@"%@",topListData);
        
        NSArray *topModels = [NSClassFromString(modelName) arrayOfModelsFromDictionaries:topListData];
        
        [self.topListSource addObjectsFromArray:topModels];
        
        [self.tableView reloadData];
        
        //隐藏菊花
        [self hideLoadView];
        
        //停止刷新
        
        [self.tableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败= %@",error);
        
        //隐藏菊花
        [self hideLoadView];
        
          [self.tableView.header endRefreshing];
    }];
    
}

#pragma mark -- 界面视图展现 --

- (void)createTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
    [self.view addSubview:self.tableView];
    
    //self.tableView.backgroundColor = [UIColor redColor];
    
    //设置页面的xy坐标从导航栏开始
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //去除多余的cell中的道道
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //self.tableView.tableHeaderView = [[UIView alloc] init];
 
     [self.tableView registerNib:[UINib nibWithNibName:@"LYLBaseCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"LYLOtherListCell" bundle:nil] forCellReuseIdentifier:@"otherCell"];
}

#pragma mark -- 协议的实现 --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.topListSource.count + self.dataSource.count/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    
    return 150;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (indexPath.row == 0) {
        
        LYLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"LYLBaseCell" owner:self options:nil].firstObject;
        }

       
        cell.model = self.topListSource[indexPath.row];
        
         return cell;
        
    }
    else{

        LYLOtherListCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];

        NSInteger index = indexPath.row * 2 - 2;
        if (self.dataSource.count-2 >= index) {
            LYLHomeModel *topHomeModel = self.dataSource[index];
            LYLHomeModel *topHomeModel2 = self.dataSource[index + 1];
            [cell setModel:topHomeModel andModel:topHomeModel2 andHomeVc:self];
            return cell;
        }
  
        return cell;

    }
}

#pragma mark -- 懒加载 --

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   

}

- (NSMutableArray *)topListSource
{
    if (_topListSource == nil) {
        _topListSource = [NSMutableArray array];
    }
    return _topListSource;
}


@end
