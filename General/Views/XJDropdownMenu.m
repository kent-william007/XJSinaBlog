//
//  XJDropdownMenu.m
//  XJSinaBlog
//
//  Created by Kent on 16/1/6.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJDropdownMenu.h"
@interface XJDropdownMenu()
@property (nonatomic,strong)UIImageView *containView;
@end
@implementation XJDropdownMenu
//想要调用懒加载，就需要用到get方法:self.containView 如果是用_containView不能调用
-(UIImageView *)containView
{  
    if (!_containView) {
        UIImageView *grayBackImageView = [[UIImageView alloc]init];
        grayBackImageView.image = [UIImage imageNamed:@"popover_background"];
        grayBackImageView.userInteractionEnabled = YES;
        [self addSubview:grayBackImageView];
        _containView = grayBackImageView;
    }
    return _containView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (XJDropdownMenu *)menu
{
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)from
{
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    
    [lastWindow addSubview:self];
    
    self.frame = lastWindow.bounds;

    CGRect newRect = [from convertRect:from.bounds toView:lastWindow];
    
    _containView.centerX = CGRectGetMidX(newRect);
    _containView.y = CGRectGetMaxY(newRect);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuShow:)]) {
        [self.delegate dropdownMenuShow:self];
    }


}
- (void)setContainerController:(UIViewController *)containerController
{
    _containerController = containerController;
    self.contentView = containerController.view;
}
- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    contentView.x = 10;
    contentView.y = 15;
    self.containView.width = CGRectGetMaxX(contentView.frame) + 10;
    self.containView.height = CGRectGetMaxY(contentView.frame) + 11;
    [self.containView addSubview:contentView];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDismiss:)]) {
        [self.delegate dropdownMenuDismiss:self];
    }

}

@end
