//
//  LHStatuesToolBar.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/27.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHStatus;

@interface LHStatuesToolBar : UIView

@property (nonatomic, strong) LHStatus *status;

+(instancetype)toolBar;

@end
