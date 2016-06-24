//
//  LHStatusFrame.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/23.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatusFrame.h"
#import "LHStatus.h"
#import "LHUser.h"
#import "LHPhotos.h"

#define spacing 10


@implementation LHStatusFrame

-(void)setStatus:(LHStatus *)status{
    //计算frame
    _status = status;
    LHUser *user = status.user;
    NSArray *photos = status.pic_urls;
    
    //头像
    CGFloat iconWH = 50;
    CGFloat iconX = spacing;
    CGFloat iconY = spacing;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxY(self.iconViewF) + spacing;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:NameLabelFont maxW:MAXFLOAT];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + spacing;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    //创建时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + spacing;
    CGSize timeSize = [self sizeWithText:status.created_at font:TimeLabelFont maxW:MAXFLOAT];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //微博来源
    CGFloat soucreX = CGRectGetMaxX(self.timeLabelF) + spacing;
    CGFloat soucreY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:TimeLabelFont maxW:MAXFLOAT];
    self.sourceLabelF = (CGRect){{soucreX,soucreY},sourceSize};
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + spacing;
    CGFloat maxW = ScreenWidth - 2 * spacing;
    CGSize contentSize = [self sizeWithText:status.text font:TimeLabelFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat originalH = 0;
    
    //配图
    if (photos.count) {
        CGFloat photoX = iconX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) +spacing;
        CGFloat photoW = 100 ;
        CGFloat photoH = 100;
        self.photoViewF = CGRectMake(photoX, photoY, photoW, photoH);
        originalH = CGRectGetMaxY(self.photoViewF) + spacing;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + spacing;
    }
    
    
    //原创微博view
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = ScreenWidth;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    //cell高度
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
