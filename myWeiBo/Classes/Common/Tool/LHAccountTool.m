//
//  LHAccountTool.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHAccountTool.h"


@implementation LHAccountTool

+(void)saveAccotunWith:(LHAccount *)account{
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}

+(LHAccount *)account{
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"];
    LHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    
    //比较时间有没有过期
    NSDate *nowDate = [NSDate date];
    NSDate *overDate = [account.current_time dateByAddingTimeInterval:[account.expires_in longLongValue]];
    NSComparisonResult result = [nowDate compare:overDate];
    if (result == NSOrderedAscending) {
        return account;
    }
    
    
    return nil;
}

@end
