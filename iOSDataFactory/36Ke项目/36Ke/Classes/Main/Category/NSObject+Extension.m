//
//  NSObject+Extension.m
//  LMJTabBarController
//
//  Created by lmj on 15/12/16.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (NSString *)JSONRepresentation
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"%@",[error description]);
           
        }
         NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
        return result;
    }
    return @"";
}

@end
