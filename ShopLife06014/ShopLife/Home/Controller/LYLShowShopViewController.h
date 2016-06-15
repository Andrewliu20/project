//
//  LYLShowShopViewController.h
//  ShopLife
//
//  Created by zhuzheng on 16/5/21.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLBaseViewController.h"

@interface LYLShowShopViewController : LYLBaseViewController

//分类id
@property (nonatomic,strong) NSString *subjectId;

//分类名字

@property (nonatomic,strong) NSString *titleName;

@property (nonatomic,strong)UITableView *tableView;



@end
