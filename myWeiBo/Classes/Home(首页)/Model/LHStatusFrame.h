//
//  LHStatusFrame.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/23.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NameLabelFont [UIFont systemFontOfSize:14]
#define TimeLabelFont [UIFont systemFontOfSize:13]
@class LHStatus;

@interface LHStatusFrame : NSObject

@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** 高度*/
@property (nonatomic, assign) CGFloat cellHeight;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发昵称+正文 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;


@property (nonatomic, strong) LHStatus *status;


@end
