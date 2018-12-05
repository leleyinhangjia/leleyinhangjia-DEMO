//
//  NSString+Extension.h
//  LMJTabBarController
//
//  Created by lmj on 15/12/16.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSRange.h>
#import <stdarg.h>
#import <limits.h>
@interface NSString (Extension)


/**
 *  格式化时间日期
 *
 *  @param date   <#date description#>
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/**
 *  NSString转json格式
 *
 *  @return <#return value description#>
 */
//- (id)JSONValue;

@end
