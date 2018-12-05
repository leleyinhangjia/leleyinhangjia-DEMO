//
//  UIView+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)

- (void)addSingleBorder:(UIViewBorderDirect)direct color:(UIColor *)color width:(CGFloat)width
{
    UIView *line = [[UIView alloc] init];
    
    // 设置颜色
    line.backgroundColor = color;
    
    // 添加
    [self addSubview:line];
    
    // 禁用ar
    line.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(line);
//    NSDictionary *metrics = @{@"w",@(width),@"y":@(self.hei)}
}

+ (instancetype)viewFromXIB
{
    NSString *name = NSStringFromClass(self);
    
    UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
    
    if (xibView == nil) {
        NSLog(@"CoreXibView: 从xib创建视图失败，当前类事：%@",name);
    }
    
    return xibView;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return  self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setRadius:(CGFloat)radius
{
    if(radius<=0) radius = self.frame.size.width * .5f;
    
    //圆角半径
    self.layer.cornerRadius=radius;
    
    //强制
    self.layer.masksToBounds=YES;
}

- (CGFloat)radius
{
    return 0;
}

- (void)addSubviewsWithArray:(NSArray *)subViews
{
    for (UIView *view in subViews) {
        [self addSubview:view];
    }
}

- (void)setBorder:(UIColor *)color width:(CGFloat)width
{
    CALayer *layer = self.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
}

- (void)debug:(UIColor *)color width:(CGFloat)width
{
    [self setBorder:color width:width];
}

+ (void)removeViews:(NSArray *)views
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
    });
}

@end
