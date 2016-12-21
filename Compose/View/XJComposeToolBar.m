//
//  XJComposeToolBar.m
//  XJSinaBlog
//
//  Created by kent on 2016/12/16.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJComposeToolBar.h"
@interface XJComposeToolBar()
@property(nonatomic,weak)UIButton *oldButton;
@end
@implementation XJComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self createButton:@"compose_camerabutton_background" hightLightImage:@"compose_camerabutton_background_highlighted" composeType:composeCamerabuttonType];
        [self createButton:@"compose_toolbar_picture" hightLightImage:@"compose_toolbar_picture_highlighted" composeType:composeToolbar_pictureType];
        [self createButton:@"compose_mentionbutton_background" hightLightImage:@"compose_mentionbutton_background_highlighted" composeType:composeMentionbuttonType];
        [self createButton:@"compose_trendbutton_background" hightLightImage:@"compose_trendbutton_background_highlighted" composeType:composeTrendbuttonType];
        [self createButton:@"compose_keyboardbutton_background" hightLightImage:@"compose_keyboardbutton_background_highlighted" composeType:composeEmoticonbuttonType];
        
    }
    return self;
}
- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    UIButton *emotionButton = [self viewWithTag:composeEmoticonbuttonType];
    _showKeyboardButton = showKeyboardButton;
    UIImage *emotionSelect = [UIImage imageNamed:@"compose_emoticonbutton_background"];
    UIImage *emotionSelect_hight = [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"];
    if (!showKeyboardButton) {
        emotionSelect = [UIImage imageNamed:@"compose_keyboardbutton_background"];
        emotionSelect_hight = [UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"];
    }
    [emotionButton setImage:emotionSelect forState:UIControlStateHighlighted];
    [emotionButton setImage:emotionSelect_hight forState:UIControlStateSelected];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger subviewcount = [self.subviews count];
    CGFloat width = self.frame.size.width/subviewcount;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.x = idx * width;
        obj.y = 0;
        obj.width = width;
        obj.height = 44;
    }];
}
- (void)createButton:(NSString *)normalImage hightLightImage:(NSString *)highlightImage composeType:(composeToolButtonType)type
{
    UIButton *bun = [UIButton buttonWithType:UIButtonTypeCustom];
    [bun setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [bun setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    [bun addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    if (type== composeEmoticonbuttonType) {
        bun.selected = YES;
        self.oldButton = bun;
    }
    bun.tag = type;
    [self addSubview:bun];
}

- (void)buttonclick:(UIButton *)sender
{
    self.oldButton.selected = NO;
    self.oldButton = sender;
    sender.selected = YES;
    if ([self.delegate respondsToSelector:@selector(xjComposeToolBar:didSelectindex:)]) {
        [self.delegate xjComposeToolBar:self didSelectindex:sender.tag];
    }
}

@end
