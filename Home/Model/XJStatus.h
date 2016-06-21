//
//  XJStatus.h
//  XJSinaBlog
//
//  Created by xiaojinxing on 16/4/23.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XJUser;

@interface XJStatus : NSObject
/**
 *  字符串类型的微博ID
 */
@property(nonatomic,copy) NSString *idstr;
/**
 *  微博内容
 */
@property(nonatomic,copy) NSString *text;
/**
 *  微博作者信息 
 */
@property(nonatomic,strong) XJUser *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property(nonatomic, strong)XJStatus *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;


@end
