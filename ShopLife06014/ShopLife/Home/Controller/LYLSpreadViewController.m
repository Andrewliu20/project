//
//  LYLSpreadViewController.m
//  ShopLife
//
//  Created by qianfeng on 16/5/19.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLSpreadViewController.h"
#import "MBProgressHUD.h"
@interface LYLSpreadViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation LYLSpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    self.title = @"品牌推广";
    
    //NSLog(@"webURL= %@",self.webURL);
    
    [self loadWebView];
}


- (void)loadWebView
{
    
    //加载菊花
    [self showLoadView];
    
    self.webView = [[UIWebView alloc] initWithFrame: self.view.bounds];

    NSURL *url = [NSURL URLWithString:toLostURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:request];
    
    //self.webView.contentMode = UIViewContentModeScaleAspectFit;

    
    [self showLoadView];
    
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self showLoadView];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     //web加载完成
    
    [self hideLoadView];
}

#pragma mark -- 菊花相关的方法---


- (void) showLoadView

{
    [self.view bringSubviewToFront:self.hud];
    
    //显示
    
    [self.hud show:YES];
}

- (void)hideLoadView
{
    [self.hud hide:YES];
}

- (MBProgressHUD *)hud
{
    
    if(_hud == nil){
        
        
        _hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        _hud.labelText = @"加载中...";
        
        [self.view addSubview:_hud];
        
    }
    
    return _hud;
}


@end
