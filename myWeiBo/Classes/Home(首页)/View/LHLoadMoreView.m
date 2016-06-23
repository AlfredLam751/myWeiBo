//
//  LHLoadMoreView.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/22.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHLoadMoreView.h"

@implementation LHLoadMoreView

+(instancetype)loadMore{
    LHLoadMoreView *moreView = [[[NSBundle mainBundle] loadNibNamed:@"LHLoadMoreView" owner:nil options:nil] lastObject];
    return moreView;
}

@end
