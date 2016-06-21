//
//  XJLoadMoreFooter.m
//  XJSinaBlog
//
//  Created by kent on 16/6/1.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJLoadMoreFooter.h"

@implementation XJLoadMoreFooter
+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"XJLoadMoreFooter" owner:nil options:nil]lastObject];
}
@end
