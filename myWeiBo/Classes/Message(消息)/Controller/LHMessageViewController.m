//
//  LHMessageViewController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/18.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHMessageViewController.h"
#import "LHTestViewController.h"


@interface LHMessageViewController ()

@end

@implementation LHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-%ld",indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LHTestViewController *test111 = [[LHTestViewController alloc] init];
    test111.title = @"测试";
    test111.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test111 animated:YES];
    
}

@end
