//
//  LHStatusFrame.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/23.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatusFrame.h"
#import "LHStatus.h"
#import "LHUser.m"
#define spacing 10

@implementation LHStatusFrame

-(void)setStatus:(LHStatus *)status{
    //计算frame
    _status = status;
    LHUser *user = status.user;
    
    //头像
    CGFloat iconWH = 50;
    CGFloat iconX = spacing;
    CGFloat iconY = spacing;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxY(self.iconViewF);
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:[UIFont systemFontOfSize:15] maxW:<#(CGFloat)#>]
    
    
    if (status.user.isVip) {
        <#statements#>
    }
    
    
    self.cellHeight = 70;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
