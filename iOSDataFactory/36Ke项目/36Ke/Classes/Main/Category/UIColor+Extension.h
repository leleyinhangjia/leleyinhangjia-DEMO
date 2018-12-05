//
//  UIColor+Extension.h
//  LMJTabBarController
//
//  Created by lmj on 15/12/2.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  返回随机色
 */
+ (instancetype)randColor;

/**
 *  16进制颜色转化为UIColor
 *
 *  @param hexColor #ffffff
 *
 *  @return UIColor
 */
+ (UIColor *)translateHexStringToColor:(NSString *)hexColor;

@end
