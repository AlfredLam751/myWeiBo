//
//  LHUser.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHUser : NSObject
/** 用户名*/
@property (nonatomic, strong) NSString *name;
/** 用户id*/
@property (nonatomic, strong) NSString *idstr;
/** 用户头像小图*/
@property (nonatomic, strong) NSString *profile_image_url;
@end
