//
//  NSData+Extension.m
//  LMJTabBarController
//
//  Created by lmj on 15/12/16.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "NSData+Extension.h"

@implementation NSData (Extension)

- (id)JSONValue
{
    NSError *error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    if (error)
        NSLog(@"%@", [error description]);
    return obj;
    
}

@end
