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
/**
 *  会员类型 >2才是会员
 */
@property (nonatomic, assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  是否是Vip
 */
@property (nonatomic, assign) BOOL isVip;
@end
