//
//  ALinLiveViewCell.h
//  MiaowShow
//
//  Created by zhengleyin 16/6/23.
//  Copyright © 2016年 zhengleyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLyLive, ZlyUser;
@interface ALinLiveViewCell : UICollectionViewCell
/** 直播 */
@property (nonatomic, strong) ZLyLive *live;
/** 相关的直播或者主播 */
@property (nonatomic, strong) ZLyLive *relateLive;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;
/** 点击关联主播 */
@property (nonatomic, copy) void (^clickRelatedLive)();
@end
