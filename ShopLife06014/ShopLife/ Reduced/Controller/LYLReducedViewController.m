//
//  LYLReducedViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLReducedViewController.h"
#import "LYLChannelModel.h"
#import "LYLChannelCell.h"
#define VIEWWIDTH self.view.frame.size.width

@interface LYLReducedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *descArr;
}

@property (nonatomic,strong) NSMutableArray *dataSource;



@property (nonatomic,strong) UITableView *tableView;

@end

@implementation LYLReducedViewController
{
    NSInteger *_page;
    NSMutableArray *_heightSizeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    self.navigationItem.title = @"捡宝";

    [self initTable];
    
    [self loadData];
    
    [self addRefresh];
}

#pragma mark -- 集成下来刷新和上拉加载

- (void)addRefresh
{
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 0;
        
        [self loadData];
    }];
    
    self.tableView.header = header;
    
    //上啦
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page += 1;
        
        [self loadData];
    }];
    
    self.tableView.footer = footer;
    
    
}

- (void)loadData{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [self showLoadView];
    
    [manager GET:[NSString stringWithFormat:Reduced_URL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (self.tableView.header.isRefreshing) {
            [self.dataSource removeAllObjects];
        }
        
        LYLChannelModel *model = [LYLChannelModel mj_objectWithKeyValues:responseObject];
        
        
        
        [self.dataSource addObjectsFromArray:model.rows];
       
        
        
        [self.tableView reloadData];
        
        [self hideLoadView];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"数据请求失败");
        [self hideLoadView];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    
}

- (void)initTable{
    
    _heightSizeArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _tableView.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    //去除多余的cell中的道道
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_tableView];
    
    self.tableView.rowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYLChannelCell" bundle:nil] forCellReuseIdentifier:@"channelCell"];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if (descArr.count == 4) {
////        return 750;
////    }else
////    {
////        return 700;
////    }
//    
//    
//  //  计算cell的中text的高度
//    
//    
//    Itemgoods *itemGoods = [self.dataSource[indexPath.row] itemgoods];
//    
//    if (itemGoods.attr != nil) {
//        
//        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
//         CGSize size = [itemGoods.attr boundingRectWithSize:CGSizeMake(VIEWWIDTH-20, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//        
//       
//        [_heightSizeArray addObject:[NSString stringWithFormat:@"%lf",size.height]];
//        
//        
//    }
//    
//    
//    
//    return 450 + [_heightSizeArray[indexPath.row] floatValue];
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 0;
    }else
    {
        
        return self.dataSource.count;
        
       
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LYLChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (LYLChannelCell *)[[NSBundle mainBundle]loadNibNamed:@"LYLChannelCell" owner:self options:nil].firstObject;
    }
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    Itemgoods *itemGoods = [self.dataSource[indexPath.row] itemgoods];

   
    [cell setModel:itemGoods andVC:self];
    
   
    return cell;
}




- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}


@end
