//
//  UIWindow+Extension.m
//  XJSinaBlog
//
//  Created by xiaojinxing on 16/4/20.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "XJNewfeatureViewController.h"
#import "XJTabBarViewController.h"

@implementation UIWindow (Extension)
- (void)switchViewcontroller
{
    //已经成功登录过
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController =[XJTabBarViewController shareInstance];
    }else{
        self.rootViewController = [[XJNewfeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
@end
