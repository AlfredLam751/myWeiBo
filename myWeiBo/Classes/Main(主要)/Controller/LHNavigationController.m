//
//  LHNavigationController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/18.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHNavigationController.h"

@interface LHNavigationController ()

@end

@implementation LHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(upupup) withNormalImage:@"navigationbar_arrow_up" withHeightlightImage:@"navigationbar_arrow_up"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(downdowndown) withNormalImage:@"navigationbar_arrow_down" withHeightlightImage:@"navigationbar_arrow_down"];
        
    }
    

}

-(void)upupup{
    [self popViewControllerAnimated:YES];
}

-(void)downdowndown{
    [self popToRootViewControllerAnimated:YES];
}

@end
