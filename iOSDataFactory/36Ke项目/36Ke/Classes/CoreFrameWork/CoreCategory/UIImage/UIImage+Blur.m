//
//  UIImage+Blur.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UIImage+Blur.h"
#import "UIImage+Cut.h"
#import "UIImage+ImageEffects.h"


@implementation UIImage (Blur)

- (UIImage *)blurWithFuzzy:(CGFloat)fuzzy density:(CGFloat)density
{
    // 执行模糊
    UIImage *image = [self applyBlurWithRadius:fuzzy tintColor:nil saturationDeltaFactor:density maskImage:nil];
    
    // 返回
    return image;
}

@end
