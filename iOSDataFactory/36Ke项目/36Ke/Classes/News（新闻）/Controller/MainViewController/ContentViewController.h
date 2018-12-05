//
//  ContentViewController.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "ContentModel.h"
@protocol ContentViewControllerDelegate;
@interface ContentViewController : UIViewController

@property (nonatomic, weak) id <ContentViewControllerDelegate> delegate;
@property (nonatomic, strong) ChildData *chilData;
//@property (nonatomic,)
- (void)startLoading;
- (void)endLoading;
- (void)reset;

@end
@protocol ContentViewControllerDelegate <NSObject>

@optional
- (void)contentViewControllerBack:(ContentViewController *)contentVC;
- (void)contentViewControllerComment:(ContentViewController *)contentVC;
- (void)contentviewcontrollerHome:(ContentUser *)user;

@end