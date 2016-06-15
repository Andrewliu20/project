//
//  LYLShopInfoViewController.h
//  ShopLife
//
//  Created by qianfeng on 16/5/23.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLBaseViewController.h"

@interface LYLShopInfoViewController : LYLBaseViewController


@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,strong) NSString *ID;

@property (nonatomic,assign)BOOL *flag;

//标志是从哪个页面过来的
@property (nonatomic,assign)  BOOL *pageTranform;
@end
