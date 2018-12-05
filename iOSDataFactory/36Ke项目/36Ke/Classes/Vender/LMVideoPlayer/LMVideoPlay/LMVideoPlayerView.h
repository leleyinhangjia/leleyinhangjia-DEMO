//
//  LMVideoPlayerView.h
//  LMVideoPlay
//
//  Created by lmj  on 16/3/16.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  缩放的通知
 */
#define LMShrinkScreenPlayNotification @"LMShrinkScreenPlayNotification"
#define LMFullScreenPlayNotification @"LMFullScreenPlayNotification"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kTabBarHeight 49
@interface LMVideoPlayerView : UIView


@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;


/**
 *  BOOL值判断当前的状态
 */
@property(nonatomic,assign)BOOL isFullscreen;


/**
 *  播放暂停按钮
 */
@property(nonatomic,retain)UIButton *playOrPauseBtn;

@property (nonatomic, strong) UIButton *fullScreenButton;

@property (nonatomic, strong) UIButton *shrinkScreenButton;

@property (nonatomic, retain) UISlider *progressSlider;

@property(nonatomic, retain) UISlider *volumeSlider;


@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;


- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;
- (void)onTap:(UITapGestureRecognizer *)gesture;
//+ (LMVideoPlayerView *)sharedVideoPlayerView;
//
//- (id)initWithFrame:(CGRect)frame videoURLString:(NSString *)videoURLString;


@end



