//
//  AppDelegate.m
//  ShopLife
//
//  Created by qianfeng on 16/5/17.
//  Copyright © 2016年 andrewliu. All rights reserved.
//

#import "AppDelegate.h"
#import "LYLMainTabBarController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //添加友盟appkey
   
    
    [self shareToApp];
    
    [self initWindow];
   
    return YES;
}

#pragma mark -- 友盟第三方分享

- (void)shareToApp
{
    //设置友盟社会化组件appkey
     [UMSocialData setAppKey:@"575a8a4667e58e1807002240"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx55b65ad5e959494e" appSecret:@"1aea41f029affb2e5046158e0a846f05" url:@"http://www.umeng.com/social"];
  
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105461006" appKey:@"AhiCF4M8O6XRnnl1" url:@"http://a.m.taobao.com"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3043635140"
                                              secret:@"4f4d0c72fa9c80be3d46b5f845d375b7"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

#pragma mark --  友盟分享配置系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}




- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    LYLMainTabBarController *mainTabBar = [[LYLMainTabBarController alloc] init];
    
    self.window.rootViewController = mainTabBar;
    
    [self.window makeKeyAndVisible];
}



@end
