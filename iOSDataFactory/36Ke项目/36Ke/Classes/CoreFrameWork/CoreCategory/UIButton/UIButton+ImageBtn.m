//
//  UIButton+ImageBtn.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UIButton+ImageBtn.h"
#import "UIImage+TintColor.h"


@implementation UIButton (ImageBtn)

+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightedColor:(UIColor *)highlightedColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *imageForNarmal = [UIImage imageNamed:imageName];
    UIImage *imageForhighlighed = [imageForNarmal tintColor:highlightedColor level:1.0f];
    
    // 设置不同状态下的图片
    [btn setImage:imageForNarmal forState:UIControlStateNormal];
    [btn setImage:imageForhighlighed forState:UIControlStateHighlighted];
    
    btn.frame = (CGRect){CGPointZero,imageForNarmal.size};
    
    return btn;
}

@end
