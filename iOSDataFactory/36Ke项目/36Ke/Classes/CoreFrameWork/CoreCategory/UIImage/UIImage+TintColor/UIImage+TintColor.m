//
//  UIImage+TintColor.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UIImage+TintColor.h"
#import "UIImage+RTTint.h"
@implementation UIImage (TintColor)

- (UIImage *)tintColor:(UIColor *)color level:(CGFloat)level
{
    UIImage *image = [self rt_tintedImageWithColor:color level:level];
    
    return image;
}

@end
