//
//  ZLyHomeADCell.h
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"
@class ZLyTopAD;
@interface ZLyHomeADCell : UITableViewCell <XRCarouselViewDelegate>
/** 顶部AD数组 */
@property (nonatomic, strong) NSArray *topADs;
/** 点击图片的block */
@property (nonatomic, copy) void (^imageClickBlock)(ZLyTopAD *topAD);
@end
