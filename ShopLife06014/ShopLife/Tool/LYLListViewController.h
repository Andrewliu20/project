//
//  LYLListViewController.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/18.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLBaseViewController.h"
#import "JSONModel.h"


@interface LYLListViewController : LYLBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


//存储数据
@property (nonatomic,strong) NSMutableArray *dataSource;

//存储topList数据模型
@property (nonatomic,strong) NSMutableArray *topListSource;

//请求数据
- (void)loadData:(NSString *)pathURL andModelName:(NSString *) modelName andDictName:(NSString *)dictName andTopDictName:(NSString *)topDictName ;

@end
