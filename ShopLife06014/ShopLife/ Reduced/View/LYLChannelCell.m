//
//  LYLChannelCell.m
//  ShopLife
//
//  Created by andrewliu on 16/6/2.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "LYLChannelCell.h"
#import "LYLGoodDescViewController.h"
#import "LYLTaoBaoticketViewController.h"

@interface LYLChannelCell()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UIImageView *goodImage;


@property (weak, nonatomic) IBOutlet UIWebView *descWebView;



@property (weak, nonatomic) IBOutlet UILabel *upPriceLable;

@property (weak, nonatomic) IBOutlet UIImageView *ticketImage;

@property (weak, nonatomic) IBOutlet UIImageView *seeImage;




@end

@implementation LYLChannelCell

{
    Itemgoods *_modle;
    LYLReducedViewController *_channelVC;
    NSDictionary *_dataDict;
     NSString *_descHtmlStr;
}

- (void)setModel:(Itemgoods *)model andVC:(LYLReducedViewController *)homeVC
{
    _modle = model;
    _channelVC = homeVC;
    
    
    self.titleLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.discountprice];
     self.upPriceLable.text = [NSString stringWithFormat:@"¥ %@",model.discountprice];
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
    
    
    //切割字符串处理model.attr
    
    NSArray *descArr = [model.attr componentsSeparatedByString:@"\r\n\r\n"];
    
   
    
    if (descArr.count == 3) {
        _descHtmlStr = [NSString stringWithFormat:@"<html><body><font color='#FF0000'>%@</font><br><font>%@</font><br><font>%@</font></body></html> ",descArr[0],descArr[1],descArr[2]];
    }else if (descArr.count == 4){
        
   
        _descHtmlStr = [NSString stringWithFormat:@"<html><body><font color='#FF0000'>%@</font><br><font>%@</font><br><font>%@</font><br><br><font>%@</font></body></html> ",descArr[0],descArr[1],descArr[2],descArr[3]];
    }else if(descArr.count == 2){
        _descHtmlStr = [NSString stringWithFormat:@"<html><body><font color='#FF0000'>%@</font><br><font>%@</font></body></html> ",descArr[0],descArr[1]];
        
    }else if(descArr.count == 5){
        _descHtmlStr = [NSString stringWithFormat:@"<html><body><font color='#FF0000'>%@</font><br><font>%@</font><br><font>%@</font><br><font>%@</font><br><font>%@</font></body></html> ",descArr[0],descArr[1],descArr[2],descArr[3],descArr[4]];
       
    }else{
         _descHtmlStr = _modle.attr;
    }
    
    self.descWebView.backgroundColor = [UIColor clearColor];
//    self.descWebView.backgroundColor = [UIColor redColor];
    [self.descWebView loadHTMLString:_descHtmlStr baseURL:nil];
    
   self.descWebView.scrollView.scrollEnabled = NO;
    
    self.descWebView.userInteractionEnabled = NO;
    //对图片添加手势
    
    self.goodImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *goodImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodImageClick)];
    
    [self.goodImage addGestureRecognizer:goodImageGesture];
    
    
    //获取数据中点击领券的跳转的链接
    
    //字符串转字典(将json里面的config解析为字典)
    
    
    _dataDict = [self stringToDict:model.config];
    
    [self.ticketImage setHidden:NO];
    
    
    if ([_dataDict[@"couponUrl"]isEqualToString:@""]) {
        
        [self.ticketImage setHidden:YES];
    }else
    {
        //对领券添加手势
        self.ticketImage.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *ticketImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ticketImageClick)];
        
        [self.ticketImage addGestureRecognizer:ticketImageGesture];
        
        
    }
    
    
    
    
    //对去看看图片添加手势
    self.seeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *seeImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodImageClick)];
    
    [self.seeImage addGestureRecognizer:seeImageGesture];
    
    
}



//字符串转字典

- (NSDictionary *)stringToDict:(NSString *) config{
    
    
    if (config == nil) {
        return  nil;
    }
    
    NSData *jsonData = [config 	dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        NSLog(@"转换失败");
        return  nil;
    }
    
    return dict;
    
}

#pragma mark --图片信息手势的实现

- (void)goodImageClick
{
    
    LYLGoodDescViewController *goodDescVC = [[LYLGoodDescViewController alloc] init];
    
    goodDescVC.goodsid = _modle.goodsid;
    goodDescVC.titleName = _modle.title;
    
    goodDescVC.hidesBottomBarWhenPushed = YES;
    
    [_channelVC.navigationController pushViewController:goodDescVC animated:YES];
    
    
}


-(void)ticketImageClick
{
    
    LYLTaoBaoticketViewController *taoBaoTicketVC = [[LYLTaoBaoticketViewController alloc] init];
    
    taoBaoTicketVC.hidesBottomBarWhenPushed = YES;
    taoBaoTicketVC.webUrl = _dataDict[@"couponUrl"];
    
    [_channelVC.navigationController pushViewController:taoBaoTicketVC animated:YES];
}




//重写几种方法


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
