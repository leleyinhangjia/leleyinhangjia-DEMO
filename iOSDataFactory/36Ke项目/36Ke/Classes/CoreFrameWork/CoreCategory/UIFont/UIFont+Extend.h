//
//  UIFont+Extend.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extend)

/**
 *  打印并显示所有字体
 */
+(void)showAllFonts;

/**
 *  宋体(字体缺失)
 */
+(UIFont *)songTypefaceFontOfSize:(CGFloat)size;

/**
 *  微软雅黑：正常字体
 */
+(UIFont *)microsoftYaHeiFontOfSize:(CGFloat)size;


/**
 *  微软雅黑：加粗字体(字体缺失)
 */
+(UIFont *)boldMicrosoftYaHeiFontOfSize:(CGFloat)size;

/**
 *  DroidSansFallback
 */
+(UIFont *)customFontNamedDroidSansFallbackWithFontOfSize:(CGFloat)size;

@end
