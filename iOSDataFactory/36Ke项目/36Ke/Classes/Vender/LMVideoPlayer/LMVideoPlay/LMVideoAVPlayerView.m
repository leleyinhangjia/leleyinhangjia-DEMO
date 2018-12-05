//
//  LMVideoAVPlayerView.m
//  LMVideoPlay
//
//  Created by lmj  on 16/3/18.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMVideoAVPlayerView.h"

@implementation LMVideoAVPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
