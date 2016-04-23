//
//  XJOAuthTool.h
//  XJSinaBlog
//
//  Created by Kent on 11/1/16.
//  Copyright © 2016 kent. All rights reserved.
//  封装时可以考虑两种方法1.分类 2.自定义类

#import <Foundation/Foundation.h>
//@class XJOAuthModel;
#import "XJOAuthModel.h"

@interface XJOAuthTool : NSObject
+ (void)saveAccount:(XJOAuthModel *)account;
+ (XJOAuthModel *)account;
@end

