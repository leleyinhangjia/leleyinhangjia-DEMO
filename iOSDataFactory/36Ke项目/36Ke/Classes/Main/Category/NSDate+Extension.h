//
//  NSDate+Extension.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSData *)toJSONData:(id)theData;

@end
