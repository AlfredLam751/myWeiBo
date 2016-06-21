//
//  LHSaveDataTool.h
//  test
//
//  Created by Alfred Lam on 16/5/24.
//  Copyright © 2016年 Alfred.Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHSaveDataTool : NSObject

//存
+(void)saveValue:(NSString *)value forKey:(NSString *)key;
+(void)saveBool:(BOOL )b forKey:(NSString *)key;

//取
+(BOOL)getBoolForKey:(NSString *)key;
+(id)getValueForkey:(NSString *)key;
@end
