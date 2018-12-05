//
//  NSString+Extension.m
//  LMJTabBarController
//
//  Created by lmj on 15/12/16.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // zzz表示时区，zzz可以删除,这样返回的日期字符将步包含时区信息 +0000
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//- (id)JSONValue
//{
//    NSError *error = nil;
//    
//    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
//    if (error)
//        NSLog(@"%@", [error description]);
//    return obj;
//}


@end
