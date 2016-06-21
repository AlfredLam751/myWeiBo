//
//  UIBarButtonItem+Extension.h
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/19.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)addItemWithTarget:(id)target with:(SEL)select withNormalImage:(NSString *)normalImage withHeightlightImage:(NSString *)heightlightImage;

@end
