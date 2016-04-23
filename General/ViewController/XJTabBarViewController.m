//
//  XJTabBarViewController.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJTabBarViewController.h"
#import "XJHomeViewController.h"
#import "XJMessageViewController.h"
#import "XJDiscoverViewController.h"
#import "XJProfileViewController.h"
#import "XJTabBarViewController.h"
#import "XJNavigationViewController.h"
#import "XJTabBar.h"
@interface XJTabBarViewController ()<XJTabBarDelegate>

@end

@implementation XJTabBarViewController

+ (XJTabBarViewController *)shareInstance
{
    static dispatch_once_t onceToken;
    static XJTabBarViewController *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[XJTabBarViewController alloc]init];
    });
    return shareInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    XJHomeViewController *homeVC = [[XJHomeViewController alloc]init];
    [self addChildViewController:homeVC title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    XJMessageViewController *messageVC = [[XJMessageViewController alloc]init];
    [self addChildViewController:messageVC title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    XJDiscoverViewController *discoverVC = [[XJDiscoverViewController alloc]init];
    [self addChildViewController:discoverVC title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    XJProfileViewController *pofileVC = [[XJProfileViewController alloc]init];
    [self addChildViewController:pofileVC title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    
    XJTabBar *tabBar = [[XJTabBar alloc]init];
    tabBar.tabBardelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image  selectImage:(NSString *)selectImage
{
    childVC.title = title;
    childVC.tabBarItem.image =  [image(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [image(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];;
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    XJNavigationViewController *nav = [[XJNavigationViewController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
}
-(void)clickPlustButton:(XJTabBar *)tabBar
{
    NSLog(@"clickPlustBUtton %@",tabBar);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
