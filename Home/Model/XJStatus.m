//
//  XJStatus.m
//  XJSinaBlog
//
//  Created by xiaojinxing on 16/4/23.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJStatus.h"
#import "MJExtension.h"
#import "XJPhoto.h"
#import "NSDate+Extension.h"
@implementation XJStatus
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[XJPhoto class]};
}
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];

    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if ([createDate isToday]){
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%d分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    return @"";
}

- (void)setSource:(NSString *)source
{
    // 正则表达式 NSRegularExpression
    // 截串 NSString
    if (source != nil && ![source isEqualToString:@""]) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        //    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
        _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];

    }
}

@end
