//
//  LYLAdviceViewController.m
//  ShopLife
//
//  Created by andrewliu on 16/6/8.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLAdviceViewController.h"

@interface LYLAdviceViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIImageView *boxImage;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UIButton *submitButton;

@property (nonatomic,strong) UIImageView  *descImage;

@end

@implementation LYLAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
   
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

- (void)initView{
    
    self.boxImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-30, 184)];
    
    self.boxImage.image = [UIImage imageNamed:@"xzzm_Settings_feedbackBoxBg"];
    
    [self.view addSubview:self.boxImage];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, self.boxImage.frame.size.width-20, self.boxImage.frame.size.height -30)];
    
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor blackColor];
    
    [self.textView setEditable:YES];
    
    self.textView.delegate = self;
    
    
    
    //设置对齐方式
    self.textView.textAlignment = NSTextAlignmentLeft;
    
    //超出范围可以滑动
    self.textView.scrollEnabled = YES;
    
//    self.textField.textInputView =  [[UIView alloc] ];
    
    
    [self.boxImage addSubview:self.textView];
    
    //在textView添加图片
    
    
    self.descImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, self.textView.frame.size.width, 100)];
    
    self.descImage.image = [UIImage imageNamed:@"xzzm_Settings_feedbackPlaceholder@2x"];
    
    [self.textView addSubview:self.descImage];
    
    //对textView添加手势
    
    self.textView.userInteractionEnabled = YES;
    self.boxImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *textViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewClick)];
    [self.textView addGestureRecognizer:textViewGesture];
    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 102)/2, 230, 102, 29)];
    
    [self.submitButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.submitButton setImage:[UIImage imageNamed:@"xzzm_Settings_feedbackCommitBtn"] forState:UIControlStateNormal];
    
    
    
    
    [self.view addSubview:self.submitButton];
    
    

    
}

#pragma mark -- 实现手势方法
- (void)buttonClick
{
    if (self.textView.text.length == 0 || self.textView.text == nil) {
        
        [self showAlertMsg:@"内容不能为空"];
    }else{
        //添加提交的弹框
        [self showAlert:@"确定提交的内容吗?"];
    }
    
    
}

-(void)showAlert:(NSString *)msg{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:msg preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        
         NSLog(@"%@",self.textView.text);
        self.textView.text = nil;
        
        self.descImage.hidden = NO;
        
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sureAction];
    
    [alert addAction:cancelAction];
    
    //显示
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)showAlertMsg:(NSString *)msg{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    
    //添加选中按钮
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    
    [alert addAction:sureAction];
    
    //显示
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)textViewClick
{
    [self.textView becomeFirstResponder];
}

#pragma mark -- 协议的实现

////将要开始编辑
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//   
//    return YES;
//}
////将要结束编辑
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    [self.textView resignFirstResponder];
//}
//开始编辑
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    NSLog(@"开始编辑");
//    
//   
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length > 0) {
        self.descImage.hidden = YES;
    }
    if (text.length == 0) {
        self.descImage.hidden = NO;
    }
   
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self.textView resignFirstResponder];
}

@end
