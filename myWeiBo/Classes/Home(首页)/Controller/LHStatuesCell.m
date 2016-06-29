//
//  LHStatuesCell.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/23.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatuesCell.h"
#import "LHStatusFrame.h"
#import "LHStatus.h"
#import "LHUser.h"
#import "LHPhotos.h"
#import "LHStatuesToolBar.h"
#import "LHIconView.h"

@interface LHStatuesCell()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) LHIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) PYPhotosView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;


/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发昵称+正文 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) PYPhotosView *retweetPhotoView;

/**
 *  工具条
 */
@property (nonatomic, weak) LHStatuesToolBar *toolView;

@end

@implementation LHStatuesCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"myWeiBo";
    LHStatuesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LHStatuesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


//在这里初始化cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LHRGBColor(240, 240, 240, 1.0);
    //初始化原创微博
    [self setupOriginalView];
    //初始化转发微博
    [self setupRetweetView];
    //初始化工具条
    [self setupToolView];
    
    return self;
}

-(void)setupOriginalView{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    /** 头像 */
    LHIconView *iconView = [[LHIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    PYPhotosView *photoView = [PYPhotosView photosView];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    self.contentLabel.numberOfLines = 0;
}

-(void)setupRetweetView{
    //转发整体View
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;

    /** 转发昵称+正文 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    self.retweetContentLabel.numberOfLines = 0;
    
    /** 转发配图 */
    PYPhotosView *retweetPhotoView = [PYPhotosView photosView];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

-(void)setupToolView{
    LHStatuesToolBar *toolView = [LHStatuesToolBar toolBar];
    [self.contentView addSubview:toolView];
    self.toolView = toolView;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame{
    
    //原创微博
    
    LHStatus *status = statusFrame.status;
    LHUser *user = status.user;
    NSArray *photos = status.pic_urls;

    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        //common_icon_membership_level1
        self.vipView.contentMode = UIViewContentModeCenter;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 配图 */
    if (photos.count) {
        NSMutableArray *newPhoto = [NSMutableArray array];
        for (int i = 0; i < photos.count; ++i) {
            LHPhotos *photo = photos[i];
            [newPhoto addObject:photo.thumbnail_pic];
        }
        self.photoView.hidden = NO;
        self.photoView.frame =statusFrame.photoViewF;
        self.photoView.photos = newPhoto;
        self.photoView.pageType = PYPhotosViewPageTypeLabel;
//        self.photoView.py_y = 20 + 64;
    }else{
        self.photoView.hidden = YES;
        self.photoView.frame = statusFrame.photoViewF;
    }

    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    self.nameLabel.font = NameLabelFont;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    self.timeLabel.font = TimeLabelFont;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    self.sourceLabel.font = TimeLabelFont;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.font = TimeLabelFont;
    self.contentLabel.text = status.text;
    
    
    //转发微博
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        LHStatus *retweed_status = status.retweeted_status;
        LHUser *retweed_user = retweed_status.user;
        NSArray *retweedPhotos = retweed_status.pic_urls;
        
        //转发微博整体
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetView.backgroundColor = [UIColor grayColor];
        
        //转发微博昵称+正文
        NSString *nameAndContent = [NSString stringWithFormat:@"%@:%@",retweed_user.name,retweed_status.text];
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = nameAndContent;
        self.retweetContentLabel.font = TimeLabelFont;
        
        //转发微博配图
        if (retweedPhotos.count) {
            self.retweetPhotoView.hidden = NO;
            NSMutableArray *retweetNewPhoto = [NSMutableArray array];
            for (int i = 0; i < retweedPhotos.count; ++i) {
                LHPhotos *retweetPhoto = retweedPhotos[i];
                [retweetNewPhoto addObject:retweetPhoto.thumbnail_pic];
            }
            self.retweetPhotoView.frame =statusFrame.retweetPhotoViewF;
            self.retweetPhotoView.photos = retweetNewPhoto;
            self.retweetPhotoView.pageType = PYPhotosViewPageTypeLabel;
            
        }else{
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            self.retweetPhotoView.hidden = NO;

        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    //工具条
    self.toolView.frame = statusFrame.toolViewF;
    self.toolView.status = status;


}



@end
