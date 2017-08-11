//
//  ZLyThirdLoginView.h
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/7.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeSina,
    LoginTypeQQ,
    LoginTypeWechat
};

@interface ZLyThirdLoginView : UIView
/** 点击按钮 */
@property (nonatomic, copy) void (^clickLogin)(LoginType type);
@end
