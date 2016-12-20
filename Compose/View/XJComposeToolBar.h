//
//  XJComposeToolBar.h
//  XJSinaBlog
//
//  Created by kent on 2016/12/16.
//  Copyright © 2016年 kent. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,composeToolButtonType) {
    composeCamerabuttonType=0,
    composeEmoticonbuttonType=1,
    composeMentionbuttonType=2,
    composeToolbar_pictureType=3,
    composeTrendbuttonType=4
};
@class XJComposeToolBar;
@protocol XJComposeToolBarDeletate <NSObject>
@optional
- (void)xjComposeToolBar:(XJComposeToolBar *)toolbar didSelectindex:(composeToolButtonType)type;
@end

@interface XJComposeToolBar : UIView
@property(nonatomic,assign)BOOL showKeyboardButton;
@property(nonatomic,weak)id<XJComposeToolBarDeletate> delegate;
@end
