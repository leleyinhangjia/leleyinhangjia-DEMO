//
//  MyCollectionViewCell.m
//  MoveCollectionView
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.centerLabel.textColor = [UIColor purpleColor];
        self.centerLabel.font = [UIFont systemFontOfSize:20];
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        //[self addSubview:self.centerLabel];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = self.centerLabel.frame;
        [self addSubview:self.imageView];
        
    }
    return self;
}







@end
