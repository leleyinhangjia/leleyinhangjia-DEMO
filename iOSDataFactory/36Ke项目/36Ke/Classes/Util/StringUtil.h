//
//  StringUtil.h
//  LoginDemo
//
//  Created by lmj on 15-9-25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject
// 判断字符串是否为空白
+ (BOOL)isTrimBlank:(NSString *)str;
// 判断字符串是否不为空白
+ (BOOL)isNotTrimBlank:(NSString *)str;
// 判断字符串长度是否在某一范围内
+ (BOOL)isLengthIn:(NSString *)str min:(int)minLength max:(int)maxLength;
// 判断两字符串是否相等，为nil时返回NO
+ (BOOL)isEqualStr1:(NSString *)str1 str2:(NSString *)str2;

@end
