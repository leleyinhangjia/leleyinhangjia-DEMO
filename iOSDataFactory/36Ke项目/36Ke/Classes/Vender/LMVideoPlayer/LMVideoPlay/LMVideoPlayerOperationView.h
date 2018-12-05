//
//  LMVideoPlayerOperationView.h
//  LMVideoPlay
//
//  Created by lmj  on 16/3/18.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LMVideoAVPlayerView.h"
#import <MediaPlayer/MediaPlayerDefines.h>
#import "LMVideoPlayerView.h"
@interface LMVideoPlayerOperationView : UIView

@property (nonatomic, retain) AVPlayer *player;


@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) LMVideoPlayerView *videoControl;
/**
 *  当前播放的item
 */
@property (nonatomic, retain) AVPlayerItem *currentItem;

@property (nonatomic, assign) BOOL isFullscreenMode;

@property (nonatomic, assign) BOOL isSmallScreen;

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);

@property (nonatomic, assign) CGRect viewframe;


@property (nonatomic, retain) UITableViewCell *currentCell;



- (instancetype)initWithFrame:(CGRect)frame videoURLString:(NSString *)videoURLString;
- (void)configAvplayer:(NSString *)videoURLString;
- (void)play;
- (void)dismiss;
- (void)toSmallScreen;
- (void)fullScreenButtonClick;
- (void)toCell:(UITableViewCell *)cell;
@end
