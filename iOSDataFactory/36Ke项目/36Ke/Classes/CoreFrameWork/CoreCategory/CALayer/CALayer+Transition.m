//
//  CALayer+Transition.m
//  LMJJDNC
//
//  Created by lmj on 16/1/6.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "CALayer+Transition.h"

@implementation CALayer (Transition)

/**
 *  转场动画
 *
 *  @param animType 转场动画类型
 *  @param subType  转动动画方向
 *  @param curve    转动动画曲线
 *  @param duration 转动动画时长
 *
 *  @return 转场动画实例
 */
- (CATransition *)transitionWithAnimType:(TransitionAnimType)animType subType:(TransitionSubType)subType curve:(TransitionCurve)curve duration:(CGFloat)duration
{
    NSString *key = @"transition";
    
    if ([self animationForKey:key] != nil) {
        [self removeAnimationForKey:key];
    }
    
    CATransition *transition = [CATransition animation];
    
    // 动画时长
    transition.duration = duration;
    
    // 动画类型
    transition.type = [self animaTypeWithTransitionType:animType];
    
    // 缓动函数
    transition.timingFunction = [CAMediaTimingFunction functionWithName:[self curve:curve]];
    
    // 完成动画删除
    transition.removedOnCompletion = YES;
    
    [self addAnimation:transition forKey:key];
    
    return transition;
}

- (NSString *)curve:(TransitionCurve)curve{
    
    // 曲线数组
    NSArray *funcNames = @[kCAMediaTimingFunctionDefault,kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionLinear];
    
    return [self objFromArray:funcNames index:curve isRamdom:(TransitionCurveRamdom == curve)];
}

- (NSString *)animaSubtype:(TransitionSubType)subType{
    
    // 设置转场动画的方向
    NSArray *subtypes = @[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight];
    
    return [self objFromArray:subtypes index:subType isRamdom:(TransitionSubtypesFromRamdom == subType)];
}

- (NSString *)animaTypeWithTransitionType:(TransitionAnimType)type {
    
    // 设置转场动画的类型
    NSArray *animArray=@[@"rippleEffect",@"suckEffect",@"pageCurl",@"oglFlip",@"cube",@"reveal",@"pageUnCurl"];
    
    return [self objFromArray:animArray index:type isRamdom:(TransitionAnimTypeRamdom == type)];
}

- (id)objFromArray:(NSArray *)array index:(NSUInteger)index isRamdom:(BOOL)isRamdom {

    NSUInteger count = array.count;
    
    NSUInteger i = isRamdom ? arc4random_uniform((u_int32_t)count) : index;
    
    return array[i];

}



@end
