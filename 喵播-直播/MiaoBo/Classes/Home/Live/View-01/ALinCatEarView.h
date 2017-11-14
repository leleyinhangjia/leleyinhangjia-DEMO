//
//  ALinCatEarView.h
//  MiaowShow
//
//  Created by zhengleyin 16/6/17.
//  Copyright © 2016年 zhengleyin. All rights reserved.
//  同一个工会的主播

#import <UIKit/UIKit.h>

@class ZLyLive;
@interface ALinCatEarView : UIView
/** 主播/主播 */
@property(nonatomic, strong) ZLyLive *live;
+ (instancetype)catEarView;
@end
