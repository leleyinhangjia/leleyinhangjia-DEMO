//
//  ZLyLive.m
//  MiaoBo
//
//  Created by mpgy on 2017/3/10.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import "ZLyLive.h"

@implementation ZLyLive
- (UIImage *)starImage
{
    if (self.starlevel) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19", self.starlevel]];
    }
    return nil;
}

@end
