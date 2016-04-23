//
//  XJDropdownMenu.h
//  XJSinaBlog
//
//  Created by Kent on 16/1/6.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJDropdownMenu;
@protocol XJDropdownMenuDelegate<NSObject>
@optional
- (void)dropdownMenuDismiss:(XJDropdownMenu *)dropdownMenu;
- (void)dropdownMenuShow:(XJDropdownMenu *)dropdownMenu;
@end
@interface XJDropdownMenu : UIView
@property (nonatomic,weak)id<XJDropdownMenuDelegate> delegate;
@property (nonatomic,strong)UIViewController *containerController;
@property (nonatomic,strong)UIView *contentView;
+ (XJDropdownMenu *)menu;
- (void)showFrom:(UIView *)from;

@end
