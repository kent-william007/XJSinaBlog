//
//  XJStatusFrame.h
//  XJSinaBlog
//
//  Created by kent on 16/6/1.
//  Copyright © 2016年 kent. All rights reserved.
//

// 昵称字体
#define XJStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define XJStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define XJStatusCellSourceFont XJStatusCellTimeFont
// 正文字体
#define XJStatusCellContentFont [UIFont systemFontOfSize:14]

// 被转发微博的正文字体
#define XJStatusCellRetweetContentFont [UIFont systemFontOfSize:13]


#import <Foundation/Foundation.h>
@class XJStatus;

@interface XJStatusFrame : NSObject

@property (nonatomic, strong) XJStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 工具条 */
@property (nonatomic, assign) CGRect toolbarF;



@end
