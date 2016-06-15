//
//  LYLTaoBaoViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/1.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLTaoBaoViewController.h"

@interface LYLTaoBaoViewController ()


@property (nonatomic,strong) UIWebView *infoView;

@end

@implementation LYLTaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
//    [self loadData];
   
}


#pragma mark --加载数据

//- (void) loadData
//{
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//
//    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSLog(@"数据请求成功==%@",responseObject);
//        
//        [self loadWebView];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"数据请求失败");
//    }];
//    
//}

#pragma mark -- 初始化视图
- (void)initUI
{
   
    // 添加左导航栏
    [self addLeftBar];
    
    [self loadWebView];

}


- (void)loadWebView
{
    _infoView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
//    _infoView.backgroundColor = [UIColor greenColor];
    
    
    NSURL *taobaoUrl  = [NSURL URLWithString:self.url];
    
    [_infoView loadRequest:[NSURLRequest requestWithURL:taobaoUrl]];
    
    
    [self.view addSubview:_infoView];

}

- (void)addLeftBar
{
    // 添加左导航栏
    UIImageView  *backImage =  [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 30, 30)];
    backImage.image = [UIImage imageNamed:@"xzzm_Commons_back"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backImage];
    
    
    //对backImage 添加手势
    
    backImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *backGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    
    [backImage addGestureRecognizer:backGesture];

}


//返回上一页
- (void)backClick
{
   
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
