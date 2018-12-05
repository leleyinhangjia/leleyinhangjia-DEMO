//
//  NSArray+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)

- (NSString *)string
{
    if (self == nil || self.count == 0) {
        return @"";
    }
    
    NSMutableString *str = [NSMutableString string];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,",obj];
    }];
    
    // 删除最后一个','
    NSString *strForRight = [str substringWithRange:NSMakeRange(0, str.length- 1)];
    
    return strForRight;
}

- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array
{
    NSSet *set1 = [NSSet setWithArray:self];
    
    NSSet *set2 = [NSSet setWithArray:array];
    
    return [set1 isEqual:set2];
}

- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray
{
    NSMutableArray *intersectionArray = [NSMutableArray array];
    
    if (self.count == 0) {
        return nil;
    }
    
    if (otherArray == nil) {
        return nil;
    }
    
    // 遍历
    for (id obj in self) {
        if (![otherArray containsObject:obj]) {
            continue;
        }
        
        // 添加
        [intersectionArray addObject:obj];
    }
    
    return intersectionArray;
}

- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray
{
    if (self == nil) {
        return nil;
    }
    
    if (otherArray == nil) {
        return self;
    }
    
    NSMutableArray *minusArray = [NSMutableArray arrayWithArray:self];
    
    // 遍历
    for (id obj in otherArray) {
        if (![self containsObject:obj]) {
            continue;
        }
        
        // 添加
        [minusArray removeObject:obj];
    }
    
    return minusArray;
}

@end
