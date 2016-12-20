//
//  XJTextView.h
//  XJSinaBlog
//
//  Created by kent on 2016/12/14.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJTextView : UITextView
@property(nonatomic,strong)NSString *placeHolder;
@property(nonatomic,strong)UIColor *placeHolderColor;
@property(nonatomic,assign)NSInteger maxLength;
@end
