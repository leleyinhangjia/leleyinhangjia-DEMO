//
//  StringUtil.m
//  LoginDemo
//
//  Created by lmj on 15-9-25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil
+ (BOOL)isTrimBlank:(NSString *)str {
    return !str || str.length==0;
}

+ (BOOL)isNotTrimBlank:(NSString *)str {
    return str && str.length > 0;
}

+(BOOL)isLengthIn:(NSString *)str min:(int)minLength max:(int)maxLength {
    return str && str.length >= minLength && str.length <= maxLength;
}

+(BOOL)isEqualStr1:(NSString *)str1 str2:(NSString *)str2 {
    return str1 && str2 && [str1 isEqualToString:str2];
}
@end
