//
//  XJTitleButton.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//
#define XJMargin 10;
#import "XJTitleButton.h"

@implementation XJTitleButton
-(instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:image(@"navigationbar_arrow_down") forState:UIControlStateNormal];
        [self setImage:image(@"navigationbar_arrow_up")   forState:UIControlStateSelected];
    }
    return self;
}
//在系统计算和设置完按钮尺寸后，在修改尺寸。
-(void)setFrame:(CGRect)frame
{
    //先获取系统计算出来的尺寸，在加XJMargin的长度，然后传给父控件。
    frame.size.width += XJMargin;
    [super setFrame:frame];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;

    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XJMargin;
    
//    NSLog(@"title:%@ imageView;%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.imageView.frame));
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
