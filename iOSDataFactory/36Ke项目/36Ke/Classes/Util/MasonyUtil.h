//
//  MasonyUtil.h
//  LMJJDNC
//
//  Created by lmj on 16/1/6.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MasonyUtil : NSObject

// 居中显示
+ (void)centerView:(UIView *)view size:(CGSize)size;

// 含有边距
+ (void)view:(UIView *)view EdgeInset:(UIEdgeInsets)edgeInsets;

// view的数目大于两个
+ (void)equalSpacingView:(NSArray *)views viewWidth:(CGFloat)width viewHeight:(CGFloat)height superViewWidth:(CGFloat)superViewWidth;

@end
