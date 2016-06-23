//
//  LHUser.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHUser.h"

@implementation LHUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.isVip = mbtype > 2;
}


@end
