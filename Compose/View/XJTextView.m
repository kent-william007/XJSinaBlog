//
//  XJTextView.m
//  XJSinaBlog
//
//  Created by kent on 2016/12/14.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJTextView.h"

@interface XJTextView()<UITextViewDelegate>

@end

@implementation XJTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}
- (void)textViewDidChange:(NSNotification *)noti
{
    if (self.maxLength) {
        XJTextView *textview = [noti object];
        if (textview.text.length > self.maxLength) {
            textview.text = [textview.text substringToIndex:self.maxLength];
        }
    }
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}
//调用setFont，setText这些方法时，也需要动态改变placeHolder的样式。
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    //这个方法会调用drawRect
    [self setNeedsDisplay];
}
//drawRect会把当前画布的内容先清除，然后再重新开始绘画
- (void)drawRect:(CGRect)rect
{
    //self.hasText判断文本框是否有内容
    if (self.hasText) return;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName]= self.placeHolderColor?self.placeHolderColor:[UIColor lightTextColor];
    attributes[NSFontAttributeName] = self.font;
    [self.placeHolder drawWithRect:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-5) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

@end
