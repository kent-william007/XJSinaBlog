//
//  XJStatusPhotosView.h
//  XJSinaBlog
//
//  Created by kent on 16/6/3.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJStatusPhotosView : UIView
@property (nonatomic,copy) NSArray *photos;

+ (CGSize)sizeWithCount:(int)count;
@end
