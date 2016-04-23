//
//  XJNewfeatureViewController.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJNewfeatureViewController.h"
#import "XJTabBarViewController.h"
@interface XJNewfeatureViewController ()

@end

@implementation XJNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *newButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width, 70)];
    [newButton setTitle:@"新特性" forState:UIControlStateNormal];
    [self.view addSubview:newButton];
    [newButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
}
- (void)click
{
//    [self.navigationController pushViewController:[XJTabBarViewController shareInstance] animated:NO];
    [self presentViewController:[XJTabBarViewController shareInstance] animated:YES completion:^{
        
    }];
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
