//
//  MyCollectionViewCell.h
//  MoveCollectionView
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>
@property(nonatomic,retain)UILabel *centerLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end
