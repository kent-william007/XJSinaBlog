//
//  XJStatusCell.h
//  XJSinaBlog
//
//  Created by kent on 16/6/1.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJStatusFrame;

@interface XJStatusCell : UITableViewCell
+ (instancetype)cellWithTableview:(UITableView *)tableview;
@property(nonatomic, strong)XJStatusFrame *statusFrame;
@end
