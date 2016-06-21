//
//  LHSaveDataTool.m
//  test
//
//  Created by Alfred Lam on 16/5/24.
//  Copyright © 2016年 Alfred.Lam. All rights reserved.
//

#import "LHSaveDataTool.h"

@implementation LHSaveDataTool

+(void)saveValue:(NSString *)value forKey:(NSString *)key{
    if (key == nil || key.length == 0) {
        return;
    }
    //获得偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    //立即同步
    [defaults synchronize];
}

+(void)saveBool:(BOOL)b forKey:(NSString *)key{
    if (key == nil || key.length == 0) {
        return;
    }
    //获得偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:b forKey:key];
    //立即同步
    [defaults synchronize];
}

+(BOOL)getBoolForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults boolForKey:key];
}

+(id)getValueForkey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults valueForKey:key];
}

@end
