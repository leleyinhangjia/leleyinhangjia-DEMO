//
//  UIColor+Extension.m
//  LMJTabBarController
//
//  Created by lmj on 15/12/2.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)randColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
}

+ (UIColor *)translateHexStringToColor:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor blackColor];
    }
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rClorValue = [cString substringWithRange:range];
    range.location = 2;
    NSString *gColorValue = [cString substringWithRange:range];
    range.location = 4;
    NSString *bColorValue = [cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rClorValue] scanHexInt:&r];
    [[NSScanner scannerWithString:gColorValue] scanHexInt:&g];
    [[NSScanner scannerWithString:bColorValue] scanHexInt:&b];
    return [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat) b / 255.0f) alpha:1.0f];

    
}
@end
