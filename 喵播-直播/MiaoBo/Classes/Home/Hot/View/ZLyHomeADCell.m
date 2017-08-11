//
//  ZLyHomeADCell.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyHomeADCell.h"
#import "ZLyTopAD.h"
@implementation ZLyHomeADCell

- (void)setTopADs:(NSArray *)topADs
{
    _topADs = topADs;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (ZLyTopAD *topAD in topADs) {
        [imageUrls addObject:topAD.imageUrl];
    }
    XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:imageUrls describeArray:nil];
    view.time = 2.0;
    view.delegate = self;
    view.frame = self.contentView.bounds;
    [self.contentView addSubview:view];
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    if (self.imageClickBlock) {
        self.imageClickBlock(self.topADs[index]);
    }
}
@end
