//
//  XJHomeViewController.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJHomeViewController.h"
#import "NextViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "XJTitleButton.h"
#import "XJDropdownMenu.h"
#import "XJOAuthViewController.h"
#import "XJOAuthTool.h"
#import "AFNetworking.h"

@interface XJHomeViewController ()<XJDropdownMenuDelegate>

@end

@implementation XJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    
    [self setupUserInfo];
    
    UIButton *bun = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    bun.backgroundColor = [UIColor redColor];
    [bun addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bun];
}
- (void)click
{
    [self.navigationController pushViewController:[[XJOAuthViewController alloc]init] animated:YES];
}
- (void)setupUserInfo
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    XJOAuthModel *account = [XJOAuthTool account];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        
        account.name = responseObject[@"name"];
        [XJOAuthTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];

}
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    XJOAuthModel *account = [XJOAuthTool account];
    XJTitleButton *titleButton = [[XJTitleButton alloc]init];
    [titleButton setTitle:account.name?account.name:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(dropdownClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.selected = YES;
    self.navigationItem.titleView = titleButton;
}
- (void)friendSearch
{
    
}
- (void)pop
{
}

- (void)dropdownClick:(UIButton *)sender
{
    XJDropdownMenu *menu = [XJDropdownMenu menu];
    menu.delegate = self;
    NextViewController *next = [[NextViewController alloc]init];
    next.view.height = 44*3;
    next.view.width = 150;
    menu.containerController = next;
    [menu showFrom:sender];
}
- (void)dropdownMenuDismiss:(XJDropdownMenu *)dropdownMenu
{
    UIButton *bun = (UIButton *)self.navigationItem.titleView;
    bun.selected = YES;
}
- (void)dropdownMenuShow:(XJDropdownMenu *)dropdownMenu
{
    UIButton *bun = (UIButton *)self.navigationItem.titleView;
    bun.selected = NO;

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
