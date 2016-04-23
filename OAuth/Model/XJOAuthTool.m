//
//  XJOAuthTool.m
//  XJSinaBlog
//
//  Created by Kent on 11/1/16.
//  Copyright © 2016 kent. All rights reserved.
//
#define Model_Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "XJOAuthTool.h"


@implementation XJOAuthTool
+ (void)saveAccount:(XJOAuthModel *)account
{
    account.created_time = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:Model_Path];
}
+ (XJOAuthModel *)account
{
    XJOAuthModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:Model_Path];
    long long expires_in = [model.expires_in longLongValue];
    NSDate *forwadDate = [model.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    NSComparisonResult result = [forwadDate compare:now];//判断是否过期
    if (result != NSOrderedDescending) {
        return nil;
    }
    return model;
    
}
@end
