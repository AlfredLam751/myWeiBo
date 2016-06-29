//
//  LHUser.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LHUserVerifiedTypeNone = -1, // 没有任何认证
    LHUserVerifiedPersonal = 0,  // 个人认证
    LHUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    LHUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    LHUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    LHUserVerifiedDaren = 220 // 微博达人
}LHUserVerified_type;

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
/**
 *  加V类型
 */
@property (nonatomic, assign) LHUserVerified_type verified_type;
@end
