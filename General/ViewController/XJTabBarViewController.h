//
//  XJTabBarViewController.h
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJTabBar;
@interface XJTabBarViewController : UITabBarController
+ (XJTabBarViewController *)shareInstance;
-(void)clickPlustButton:(XJTabBar *)tabBar;
@end
