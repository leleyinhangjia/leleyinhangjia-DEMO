//
//  UIImage+Blur.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

/**
 *  产生一个模糊的图片:
 *
 *  fuzzy:                                  0~68.5f（范围）
 *
 *  density:                                0~5.0f （范围）
 */
- (UIImage *)blurWithFuzzy:(CGFloat)fuzzy density:(CGFloat)density;



@end
