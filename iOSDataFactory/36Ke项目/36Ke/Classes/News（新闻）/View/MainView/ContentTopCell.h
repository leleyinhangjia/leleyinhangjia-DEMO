//
//  ContentTopCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"

@protocol ContentTopCellDelegate;
@interface ContentTopCell : UITableViewCell

@property (nonatomic, strong) ContentData *model;



@property (nonatomic, strong) id<ContentTopCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ContentData *)model;

// 下拉状态
- (void)nextEdit;

@end
@protocol ContentTopCellDelegate <NSObject>

@optional
- (void)nextContentInformation:(ContentData *)model;

- (void)userContentInformation:(ContentData *)model;

@end


