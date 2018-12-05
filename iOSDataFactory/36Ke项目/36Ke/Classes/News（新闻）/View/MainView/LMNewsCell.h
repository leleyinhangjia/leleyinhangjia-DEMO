//
//  LMNewsCell.h
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface LMNewsCell : UITableViewCell



@property (nonatomic, strong) ChildData *childModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ChildData *)model;

@end
