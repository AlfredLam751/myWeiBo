//
//  LHStatuesToolBar.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/27.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatuesToolBar.h"
#import "LHStatus.h"

@interface LHStatuesToolBar ()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;
@property (nonatomic, strong) UIButton *retweetBtn;
@property (nonatomic, strong) UIButton *commentBtn;;
@property (nonatomic, strong) UIButton *unlikeBtn;

@end

@implementation LHStatuesToolBar

#pragma mark 懒加载
-(NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolBar{
    return [[LHStatuesToolBar alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.retweetBtn = [self toolBarAddBtnWithTitle:@"转发" ImageName:@"timeline_icon_retweet"];
        self.commentBtn = [self toolBarAddBtnWithTitle:@"评论" ImageName:@"timeline_icon_comment"];
        self.unlikeBtn = [self toolBarAddBtnWithTitle:@"1" ImageName:@"timeline_icon_unlike"];
        
        [self setupdivide];
        [self setupdivide];
        
        
    }
    return self;
}
-(void)setupdivide{
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.image = [UIImage imageNamed:@"timeline_card_bottom_line_highlighted"];
    [self addSubview:divideView];
    [self.dividers addObject:divideView];
}

-(UIButton *)toolBarAddBtnWithTitle:(NSString *)title ImageName:(NSString *)imageName{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:LHRandomColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.btns.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; ++i) {
        UIButton *btn = self.btns[i];
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    NSInteger divideCount = self.dividers.count;
    CGFloat diviedX = 0;
    CGFloat diviedY = 0;
    CGFloat diviedW = 1;
    CGFloat diviedH = self.height;
    for (int i = 0; i < divideCount; ++i) {
        UIImageView *divideView = self.dividers[i];
        diviedX = (i + 1) * btnW ;
        divideView.frame = CGRectMake(diviedX, diviedY, diviedW, diviedH);
    }
}

-(void)setStatus:(LHStatus *)status{
    _status = status;
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.retweetBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.unlikeBtn title:@"赞"];
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
