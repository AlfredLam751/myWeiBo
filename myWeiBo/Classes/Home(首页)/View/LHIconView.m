//
//  LHIconView.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/28.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHIconView.h"
#import "LHUser.h"

@interface LHIconView ()
@property (nonatomic, strong) UIImageView *verifiedView;
@property (nonatomic, strong) UIImageView *placeholderView;

@end

@implementation LHIconView

-(UIImageView *)placeholderView{
    if (_placeholderView == nil) {
        _placeholderView = [[UIImageView alloc] init];
        [self addSubview:_placeholderView];
    }
    return _placeholderView;
}

-(UIImageView *)verifiedView{
    if (_verifiedView == nil) {
        _verifiedView = [[UIImageView alloc] init];
        [self addSubview:_verifiedView];
    }
    return _verifiedView;
}



-(void)setUser:(LHUser *)user{
    _user = user;
    [self.placeholderView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage: [UIImage imageNamed:@"avatar"]];
    
    /*
     LHUserVerifiedTypeNone = -1, // 没有任何认证
     LHUserVerifiedPersonal = 0,  // 个人认证
     LHUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
     LHUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
     LHUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
     LHUserVerifiedDaren = 220 // 微博达人
     */
    switch (user.verified_type) {
            
        case LHUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case LHUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        case LHUserVerifiedOrgEnterprice:
        case LHUserVerifiedOrgMedia:
        case LHUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderView.frame = self.bounds;
    self.placeholderView.layer.cornerRadius = 25;
    self.placeholderView.layer.masksToBounds = YES;
    self.placeholderView.layer.borderWidth = 5;
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.8;
    self.verifiedView.y = self.height - self.verifiedView.height* 0.8 ;
}


@end
