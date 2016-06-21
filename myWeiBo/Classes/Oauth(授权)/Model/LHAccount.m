//
//  LHAccount.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHAccount.h"

@implementation LHAccount

+(instancetype)accountWith:(NSDictionary *)dict{
    LHAccount *accont = [[self alloc] init];
    accont.uid = dict[@"uid"];
    accont.expires_in = dict[@"expires_in"];
    accont.access_token = dict[@"access_token"];
    accont.remind_in = dict[@"remind_in"];
    accont.current_time = [NSDate date];
    return accont;
}

-(void)setName:(NSString *)name{
    _name = name;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.current_time forKey:@"current_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.current_time = [aDecoder decodeObjectForKey:@"current_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
