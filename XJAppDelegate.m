//
//  AppDelegate.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJAppDelegate.h"
#import "XJTabBarViewController.h"
#import "NextViewController.h"
#import "XJNewfeatureViewController.h"
#import "XJOAuthViewController.h"
#import "XJOAuthTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"
@interface XJAppDelegate ()

@end

@implementation XJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
    
    if ([XJOAuthTool account]) {
        [self.window switchViewcontroller];
    }else{
         self.window.rootViewController = [[XJOAuthViewController alloc]init];
    }
    
    [self.window makeKeyAndVisible];
    NSLog(@"%@",NSHomeDirectory());
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //申请后台运行beginBackgroundTaskWithExpirationHandler。
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //1.取消下载
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    //2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

@end
