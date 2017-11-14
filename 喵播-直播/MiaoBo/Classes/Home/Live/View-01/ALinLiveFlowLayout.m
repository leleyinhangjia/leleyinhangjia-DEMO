//
//  ALinLiveFlowLayout.m
//  MiaowShow
//
//  Created by zhengleyin 16/6/23.
//  Copyright © 2016年 zhengleyin. All rights reserved.
//

#import "ALinLiveFlowLayout.h"

@implementation ALinLiveFlowLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}
@end
