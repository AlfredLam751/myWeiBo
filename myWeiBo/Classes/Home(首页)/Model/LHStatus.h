//
//  LHStatus.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LHUser;
@class LHPhotos;

@interface LHStatus : NSObject

/**
 *  微博id
 */
@property (nonatomic, strong) NSString *idstr;
/**
 *  微博正文
 */
@property (nonatomic, strong) NSString *text;
/**
 *  微博的用户数据模型
 */
@property (nonatomic, strong) LHUser *user;
/**
 *  创建时间
 */
@property (nonatomic, strong) NSString *created_at;
/**
 *  微博来源
 */
@property (nonatomic, strong) NSString *source;
/**
 *  配图模型数组
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  转发微博
 */
@property (nonatomic, strong) LHStatus *retweeted_status;

@end
