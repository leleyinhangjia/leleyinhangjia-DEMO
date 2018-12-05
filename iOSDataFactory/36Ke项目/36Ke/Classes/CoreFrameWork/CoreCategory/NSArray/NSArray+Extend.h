//
//  NSArray+Extend.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extend)

/**
 *  数组转字符串
 */
-(NSString *)string;


/**
 *  数组比较
 */
- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;


/**
 *  数组计算交集
 */
- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/**
 *  数据计算差集
 */
- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end
