//
//  LYLGoodDescViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/3.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLGoodDescViewController.h"

@interface LYLGoodDescViewController ()<UIWebViewDelegate>


@property (nonatomic,strong)  UIWebView *dataWebView;

@end

@implementation LYLGoodDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = self.titleName;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-39);
    
     [self loadWebView];
}

#pragma mark -- 初始化webView
- (void)loadWebView
{
    
    
    
    _dataWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    
    _dataWebView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:GoodDescURL,self.goodsid]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_dataWebView loadRequest:request];
    
    
    [self.view addSubview:_dataWebView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self showLoadView];
}

#pragma mark --实现协议





- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //web加载完成
    
    [self hideLoadView];
}
@end
