//
//  UIImage+Extension.h
//  LMJTabBarController
//
//  Created by lmj on 15/12/1.
//  Copyright © 2015年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名自动加载适配的iOS6/7的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

+ (UIImage *)imageWithCaputureView:(UIView *)view;
@end
