//
//  AppDelegate.h
//  MoveCollectionView
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)UIImageView *img;

@property(nonatomic,assign)CGPoint pushCenter;
@property(nonatomic,assign)CGPoint popCenter;

@end

