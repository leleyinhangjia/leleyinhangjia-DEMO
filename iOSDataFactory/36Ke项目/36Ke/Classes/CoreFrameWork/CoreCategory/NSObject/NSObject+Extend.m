//
//  NSObject+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "NSObject+Extend.h"

@implementation NSObject (Extend)


#pragma mark  返回任意对象的字符串式的内存地址
- (NSString *)address
{
    return [NSString stringWithFormat:@"%p",self];
}

- (void)callSelectorWithSelString:(NSString *)selString paramObj:(id)paramObj
{
    // 转换为sel
    SEL sel = NSSelectorFromString(selString);
    
    if (![self respondsToSelector:sel]) {
        return;
    }
}

@end
