//
//  XJNetWorking.m
//  XJSinaBlog
//
//  Created by kent on 16/7/4.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJNetWorking.h"
#import "AFNetworking.h"
@implementation XJNetWorking
{
    requestSuccessBlock success;
    requestFailureBlock failure;
}
+ (XJNetWorking *)sharedInstance
{
    static XJNetWorking *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance = [[XJNetWorking alloc]init];
    });
    return shareInstance;
}
-(void)getUrl:(NSString *)url actionParams:(NSMutableDictionary *)params method:(NSString*)method success:(requestSuccessBlock)requestSuccess failur:(requestFailureBlock)failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        requestSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}
@end
