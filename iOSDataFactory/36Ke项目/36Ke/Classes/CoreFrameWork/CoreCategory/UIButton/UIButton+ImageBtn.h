//
//  UIButton+ImageBtn.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageBtn)

/**
 *  快速生成一个含有图片的按钮:默认按钮在大小和图片一样大
 *
 *  @param imageName        图片名
 *  @param highlightedColor 按钮高亮的时候的颜色
 *
 *  @return 按钮
 */
+(UIButton *)buttonWithImageName:(NSString *)imageName highlightedColor:(UIColor *)highlightedColor;

@end
