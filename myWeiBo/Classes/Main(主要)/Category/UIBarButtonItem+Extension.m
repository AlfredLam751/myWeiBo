//
//  UIBarButtonItem+Extension.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/19.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+(UIBarButtonItem *)addItemWithTarget:(id)target with:(SEL)select withNormalImage:(NSString *)normalImage withHeightlightImage:(NSString *)heightlightImage{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:heightlightImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
