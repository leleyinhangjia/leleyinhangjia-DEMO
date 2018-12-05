//
//  CALayer+Anim.h
//  LMJJDNC
//
//  Created by lmj on 16/1/6.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum {
    // X
    AnimReverDirectionX = 0,
    
    // Y
    AnimReverDirectionY,
    
    // Z
    AnimReverDirectionZ,
}AnimReverDirection;

@interface CALayer (Anim)


- (CAAnimation *)anim_shake:(NSArray *)rotations duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount;

- (CAAnimation *)anim_revers:(AnimReverDirection)direction duration:(NSTimeInterval)duration isReverse:(BOOL)isReverse repeatCount:(NSUInteger)repeatCount timingFuncName:(NSString *)timingFuncName;

@end
