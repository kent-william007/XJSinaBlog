//
//  XJUser.m
//  XJSinaBlog
//
//  Created by xiaojinxing on 16/4/23.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJUser.h"

@implementation XJUser
-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}
@end
