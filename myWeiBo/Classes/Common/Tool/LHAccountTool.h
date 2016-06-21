//
//  LHAccountTool.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHAccount.h"

@interface LHAccountTool : NSObject

+(void)saveAccotunWith:(LHAccount *)account;

+(LHAccount *)account;

@end
