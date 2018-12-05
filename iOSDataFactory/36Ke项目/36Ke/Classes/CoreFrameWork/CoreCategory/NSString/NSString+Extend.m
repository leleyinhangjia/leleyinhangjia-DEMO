//
//  NSString+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (NSDate *)date
{
    NSTimeInterval timeInterval = self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

@end
