//
//  XJStatusToolbar.h
//  XJSinaBlog
//
//  Created by kent on 16/6/2.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJStatus;
@interface XJStatusToolbar : UIView
+ (instancetype)toolbar;
@property(nonatomic, strong)XJStatus *status;
@end
