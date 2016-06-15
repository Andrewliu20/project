//
//  LYLTaoBaoticketViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/4.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLTaoBaoticketViewController.h"

@interface LYLTaoBaoticketViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)  UIWebView *dataWebView;
@end

@implementation LYLTaoBaoticketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];

    self.title = @"淘宝券";
    
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
    
    NSURL *url = [NSURL URLWithString:self.webUrl];
    
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
