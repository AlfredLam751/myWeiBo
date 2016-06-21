//
//  LHStatus.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LHUser;

@interface LHStatus : NSObject

@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) LHUser *user;

@end
