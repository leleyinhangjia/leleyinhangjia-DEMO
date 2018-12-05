//
//  MoreViewCell.h
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorModel.h"
@interface MoreViewCell : UITableViewCell

@property (nonatomic, strong) Latestarticle *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
