//
//  LHStatus.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatus.h"
#import "LHPhotos.h"

@implementation LHStatus


+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls" : [LHPhotos class] };
}

-(NSString *)created_at{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    /**
     *  微博发布时间
     */
    NSDate *creatDate = [format dateFromString:_created_at];
    /**
     *  当前时间
     */
    NSDate *nowDate = [NSDate date];
    
    
    //获得当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmp = [calendar components:unit fromDate:creatDate toDate:nowDate options:0];

    if ([creatDate isThisYear]) { // 今年
        if ([creatDate isYesterday]) { // 昨天
            format.dateFormat = @"昨天 HH:mm";
            return [format stringFromDate:creatDate];
        } else if ([creatDate isToday]) { // 今天
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmp.hour];
            } else if (cmp.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmp.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            format.dateFormat = @"MM-dd HH:mm";
            return [format stringFromDate:creatDate];
        }
    } else { // 非今年
        format.dateFormat = @"yyyy-MM-dd HH:mm";
        return [format stringFromDate:creatDate];
    }

}

-(void)setSource:(NSString *)source{
    //<a href="http://weibo.com/" rel="nofollow">小亭捡来的iPhone</a>

    _source = source;
}

@end
