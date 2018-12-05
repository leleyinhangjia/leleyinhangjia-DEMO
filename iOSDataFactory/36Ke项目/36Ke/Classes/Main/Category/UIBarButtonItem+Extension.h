//
//  UIBarButtonItem+Extension.h
//  LMJTabBarController
//
//  Created by lmj on 15/12/1.
//  Copyright © 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  根据图片快速创建一个UIBarButtonItem设置正常和高亮图片,返回一个UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 *  根据图片快速创建一个UIBarButtonItem,返回小号UIbarButtonItem
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 *  根据图片快速创建一个UIBarButtonItem,返回大号的UIbarButtonItem
 */
+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action;

/**
 *  根据图片快速创建一个UIBarButtonItem且自定义大小,返回一个UIbarButtonItem
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;
/**
 *  根据文字快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;


@end
