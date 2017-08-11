//
//  ZLyLiveCollectionViewController.h
//  MiaoBo
//
//  Created by mpgy on 2017/3/10.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLyLive;
@interface ZLyLiveCollectionViewController : UICollectionViewController
/** 直播 */
@property (nonatomic, strong) NSArray *lives;
/** 当前的index */
@property (nonatomic, assign) NSUInteger currentIndex;
@end
