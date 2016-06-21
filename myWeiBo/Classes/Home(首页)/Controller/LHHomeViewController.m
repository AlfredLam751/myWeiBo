//
//  LHHomeViewController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/18.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHHomeViewController.h"

@interface LHHomeViewController ()

@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(friendsearch) withNormalImage:@"navigationbar_friendsearch" withHeightlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(pop) withNormalImage:@"navigationbar_pop" withHeightlightImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
//    [titleBtn sizeToFit];
    titleBtn.width = 150;
    titleBtn.height = 30;
    [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 100 , 0, 0)];
    
    self.navigationItem.titleView = titleBtn;
    
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
}

-(void)titleBtnClick{
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    
//    UIView *coverView = [[UIView alloc] init];
//    coverView.frame = self.view.bounds;
//    coverView.backgroundColor = [UIColor clearColor];
//    
//    [window addSubview:coverView];
//    
//    UIImageView *dropDownMenu = [[UIImageView alloc] init];
//    dropDownMenu.image = [UIImage imageNamed:@"popover_background"];
//    dropDownMenu.width = 200;
//    dropDownMenu.height = 200;
//    
//    [window addSubview:dropDownMenu];
}

-(void)friendsearch{

    LHLog(@"friendsearch");
}

-(void)pop{
    LHLog(@"pop");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
