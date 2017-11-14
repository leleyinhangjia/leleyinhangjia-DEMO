//
//  NSSafeObject.h
//  MiaowShow
//
//  Created by zhengleyin 16/6/16.
//  Copyright © 2016年 zhengleyin. All rights reserved.
//

#import <Foundation/Foundation.h>
/// justForText
@interface NSSafeObject : NSObject

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithObject:(id)object withSelector:(SEL)selector;
- (void)excute;

@end
