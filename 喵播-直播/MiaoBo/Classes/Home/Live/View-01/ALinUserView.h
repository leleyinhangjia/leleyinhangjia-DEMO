//
//  ZlyUserView.h
//  MiaowShow
//
//  Created by zhengleyin 16/6/28.
//  Copyright © 2016年 zhengleyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZlyUser;
@interface ALinUserView : UIView
+ (instancetype)userView;
/** 点击关闭 */
@property (nonatomic, copy) void (^closeBlock)();
/** 用户信息 */
@property (nonatomic, strong) ZlyUser *user;
@end
