//
//  LHStatuesCell.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/23.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHStatusFrame;

@interface LHStatuesCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) LHStatusFrame *statusFrame;

@end
