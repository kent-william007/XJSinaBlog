//
//  XJOAuthViewController.m
//  XJSinaBlog
//
//  Created by Kent on 11/1/16.
//  Copyright © 2016 kent. All rights reserved.
//
#define HUD_TAG 102
#import "XJOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "XJTabBarViewController.h"
#import "XJNewfeatureViewController.h"
#import "XJOAuthModel.h"
#import "XJOAuthTool.h"
#import "UIWindow+Extension.h"

@interface XJOAuthViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}

@end

@implementation XJOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=665902450&redirect_uri=http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    web.delegate = self;
    [self.view addSubview:web];

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request);
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger fromIndex = range.location + range.length;
        NSString *codeStr = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:codeStr];
        
        //禁止加载回调地址
        return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"665902450";
    params[@"client_secret"] = @"a9be41b6402905e8e9118266916ffae4";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       
        XJOAuthModel *oauthModel = [XJOAuthModel accountWithDict:responseObject];
        [XJOAuthTool saveAccount:oauthModel];
        
        //获取当前的主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //通过keyWindow这个示例去转换keyWindow的rootViewController
        [window switchViewcontroller];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        
        [MBProgressHUD hideHUD];
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
