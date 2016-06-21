//
//  LHTabBarController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/18.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHTabBarController.h"
#import "LHHomeViewController.h"
#import "LHDiscoverViewController.h"
#import "LHMessageViewController.h"
#import "LHProfileViewController.h"
#import "LHNavigationController.h"

@interface LHTabBarController ()

@end

@implementation LHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LHHomeViewController *homeVc = [[LHHomeViewController alloc] init];
    [self addChildViewWith:homeVc titleName:@"首页" withTitleImage:@"tabbar_home" withSelectedImageName:@"tabbar_home_highlighted"];
    
    LHMessageViewController *messageVc = [[LHMessageViewController alloc] init];
    [self addChildViewWith:messageVc titleName:@"消息" withTitleImage:@"tabbar_message_center" withSelectedImageName:@"tabbar_message_center_highlighted"];
    
    LHDiscoverViewController *discoverVc = [[LHDiscoverViewController alloc] init];
    [self addChildViewWith:discoverVc titleName:@"发现" withTitleImage:@"tabbar_discover" withSelectedImageName:@"tabbar_discover_highlighted"];
    
    LHProfileViewController *profileVc = [[LHProfileViewController alloc] init];
    [self addChildViewWith:profileVc titleName:@"我" withTitleImage:@"tabbar_profile" withSelectedImageName:@"tabbar_profile_highlighted"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//导航控制器的抽取
-(void)addChildViewWith:(UIViewController *)childVc titleName:(NSString*)titleName withTitleImage:(NSString*)imageName withSelectedImageName:(NSString *)selectedImageName{
    
//    childVc.view.backgroundColor = LHRandomColor;
    
//    childVc.tabBarItem.title = titleName;
//    childVc.navigationItem.title = titleName;
    //上面两句等同于这一句
    childVc.title = titleName;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    LHNavigationController *nav = [[LHNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}

@end
