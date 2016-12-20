//
//  XJTabBar.h
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJTabBar;
@protocol XJTabBarDelegate <UITabBarDelegate>
@optional
- (void)clickPlusButtonDelegate:(XJTabBar *)xjTabBar;
@end

@interface XJTabBar : UITabBar
@property (nonatomic,weak)id<XJTabBarDelegate> tabBardelegate;
@end
