//
//  LHStatus.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHStatus.h"
#import "LHPhotos.h"

@implementation LHStatus

+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls" : [LHPhotos class] };
}

@end
