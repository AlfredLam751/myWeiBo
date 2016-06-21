//
//  UIWindow+LHWindow.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "UIWindow+LHWindow.h"
#import "LHAccountTool.h"
#import "LHSaveDataTool.h"
#import "LHNewfeatureController.h"
#import "LHOauthViewController.h"
#import "LHTabBarController.h"

@implementation UIWindow (LHWindow)


-(void)switchRootViewController{
    LHAccount *account = [LHAccountTool account];
    
    if (account) { //如果有值就不用登陆
        NSString *version = @"Version";
        NSString *oldVersion = [LHSaveDataTool getValueForkey:version];
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        if ([oldVersion isEqualToString:currentVersion]) {
            UITabBarController *tabbarVc = [[LHTabBarController alloc] init];
            self.rootViewController = tabbarVc;
        }else{
            LHNewfeatureController *newFeature = [[LHNewfeatureController alloc] init];
            self.backgroundColor = [UIColor whiteColor];
            self.rootViewController = newFeature;
            [LHSaveDataTool saveValue:currentVersion forKey:version];
        }
    }else{ //没有值就加载加载accesstoken
        LHOauthViewController *oauthVc = [[LHOauthViewController alloc] init];
        
        self.rootViewController = oauthVc;
    }
}

@end
