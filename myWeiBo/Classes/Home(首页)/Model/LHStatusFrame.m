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

- (CGSize)sizeWithCount:(int)count
{

    ///Users/apple/Desktop/课堂共享/05-iPhone项目/1018/代码/黑马微博2期35-相册/黑马微博2期/Classes/Home(首页)/View/HWStatusPhotosView.m 列数
    int cols = (count >= 3)? 3 : count;
    CGFloat photosW = cols * 70 + (cols - 1) * 5;
    
    // 行数
    int rows = (count + 3 - 1) / 3;
    CGFloat photosH = rows * 70 + (rows - 1) * 5;
    
    return CGSizeMake(photosW, photosH);
}


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
        self.photoViewF = (CGRect){{photoX, photoY}, [self sizeWithCount:(int)photos.count]};
        originalH = CGRectGetMaxY(self.photoViewF) + spacing;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + spacing;
    }
    
    
    //原创微博view
    CGFloat originalX = 0;
    CGFloat originalY = 0 + spacing;
    CGFloat originalW = ScreenWidth;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    //工具条
    CGFloat toolX = 0;
    CGFloat toolY = 0;
    CGFloat toolW = ScreenWidth;
    CGFloat toolH = 36;
    
    //转发微博
    if (status.retweeted_status) {
        LHStatus *retweetStatus = status.retweeted_status;
        LHUser *retweetUser = retweetStatus.user;
        NSArray *retweetPhotos = retweetStatus.pic_urls;
        NSString *nameAndContent = [NSString stringWithFormat:@"%@:%@",retweetUser.name,retweetStatus.text];
        
        //转发微博昵称和正文
        CGFloat retweetContentLabelX = iconX;
        CGFloat retweetContentLabelY = iconY;
        CGFloat retweetContentLabelW = ScreenWidth - 2 * spacing;
        CGSize retweetContentLabelSize = [self sizeWithText:nameAndContent font:TimeLabelFont maxW:retweetContentLabelW];
        self.retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        //转发微博配图
        CGFloat retweetH = 0;
        if (retweetPhotos.count) {
            CGFloat retweetPhotoX = iconX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) +spacing;
            self.retweetPhotoViewF = (CGRect){{retweetPhotoX, retweetPhotoY},[self sizeWithCount:(int)retweetPhotos.count] };
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + spacing;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + spacing;
        }
        
        //转发微博整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = ScreenWidth;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        //cell高度
        toolY = CGRectGetMaxY(self.retweetViewF);
        
    }else{
        
        toolY = CGRectGetMaxY(self.originalViewF);
        
    }
    
    //工具条frame
    self.toolViewF = CGRectMake(toolX, toolY , toolW, toolH);

    //cell高度
    self.cellHeight = CGRectGetMaxY(self.toolViewF);

}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
