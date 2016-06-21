//
//  LHHomeButton.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHHomeButton.h"

@implementation LHHomeButton

-(void)layoutSubviews{
    [super layoutSubviews];
    //获得按钮的frame
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;

    //获得图片的frame
    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageH = self.imageView.frame.size.height;

    //获得标题文字的frame
    CGFloat titleW = self.titleLabel.frame.size.width;

    //间距
    CGFloat spacing = 5;

    //计算标题文字的x
    CGFloat titleX = (buttonW - imageW - titleW - spacing) * 0.5;
    //计算图片的xy
    CGFloat imageX = titleX + titleW + spacing;
    CGFloat imageY = (buttonH - imageH) * 0.5;
    
    //设置标题文字的尺寸
    self.titleLabel.frame = CGRectMake(titleX, 0, titleW, buttonH);
    //设置图片的尺寸
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);

}

@end
