//
//  UIWindow+Extension.h
//  XJSinaBlog
//
//  Created by xiaojinxing on 16/4/20.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extension)
/*
 这里写成实例方法，供对象调用，同时可以把对象传递过来
 如果改成类方法，那么就没有对象，还需要在switchViewcontroller实例化对象，不合理
 */
- (void)switchViewcontroller;
@end
