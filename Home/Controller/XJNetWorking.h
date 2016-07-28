//
//  XJNetWorking.h
//  XJSinaBlog
//
//  Created by kent on 16/7/4.
//  Copyright © 2016年 kent. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 请求成功block
 */
typedef void (^requestSuccessBlock)(id responseObj);

/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError *error);

@interface XJNetWorking : NSObject
+ (XJNetWorking *)sharedInstance;
-(void)getUrl:(NSString *)url actionParams:(NSMutableDictionary *)params method:(NSString*)method success:(requestSuccessBlock)requestSuccess failur:(requestFailureBlock)failure;

@end
