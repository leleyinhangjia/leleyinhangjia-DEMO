//
//  NSDate+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "NSDate+Extend.h"

@interface NSDate ()

@property (nonatomic,strong,readonly) NSDate *ymdDate;

@end

@implementation NSDate (Extend)


- (NSString *)timestamp
{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return [timeString copy];
}

- (NSDateComponents *)components
{
    // 创建日历
    NSCalendar *calendar= [NSCalendar currentCalendar];
    
    // 定义成分
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self];
}

- (BOOL)isThisYear
{
    // 取出给定时间的components
    NSDateComponents *dateComponents = self.components;
    
    // 取出当前时间的components
    NSDateComponents *nowComponents = [NSDate date].components;
    
    // 直接对比年成分是否一致即可
    BOOL res = dateComponents.year == nowComponents.year;
    
    return res;
}

- (BOOL)isToday
{
    // 差值为0天
    return [self calWithValue:0];
}

- (BOOL)isYesToday
{
    // 差值为一天
    return [self calWithValue:1];
}

- (BOOL)calWithValue:(NSInteger)value{
    // 得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents = self.ymdDate.components;
    
    // 得到当前时间的处理后的时间components
    NSDateComponents *nowComponents = [NSDate date].ymdDate.components;
    
    // 比较
    BOOL res = dateComponents.year == nowComponents.year && dateComponents.month == nowComponents.month && (dateComponents.day + value) == nowComponents.day;
    
    return res;
}

- (NSDate *)ymdDate
{
    // 定义fmt
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 设置格式:取出时分秒
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 得到字符串格式的时间
    NSString *dateString = [fmt stringFromDate:self];
    
    // 转date
    NSDate *date = [fmt dateFromString:dateString];
    
    return date;
}

@end
