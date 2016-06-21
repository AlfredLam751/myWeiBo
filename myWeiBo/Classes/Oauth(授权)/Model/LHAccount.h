//
//  LHAccount.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHAccount : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *remind_in;
@property (nonatomic, strong) NSDate *current_time;

+(instancetype)accountWith:(NSDictionary *)dict;
@end
