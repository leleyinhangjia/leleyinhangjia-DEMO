//
//  UIImage+TintColor.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintColor)

/**
 *  图片着色
 */
-(UIImage *)tintColor:(UIColor *)color level:(CGFloat)level;

@end
