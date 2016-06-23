//
//  LHLoadMoreView.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/22.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHLoadMoreView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

+(instancetype)loadMore;

@property (nonatomic, assign) BOOL isLoading;

@end
