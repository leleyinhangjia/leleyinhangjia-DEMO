//
//  ZLyHomeFlowLayout.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/14.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyHomeFlowLayout.h"

@implementation ZLyHomeFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat wh = (ZLyScreenWidth - 3) / 3.0;
    self.itemSize = CGSizeMake(wh , wh);
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
}
@end
