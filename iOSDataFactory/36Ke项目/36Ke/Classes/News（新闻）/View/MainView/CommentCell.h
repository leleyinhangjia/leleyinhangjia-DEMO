//
//  CommentCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CommentCell : UITableViewCell

@property (nonatomic, strong) CommentData2 *model;
@property (nonatomic, assign) CGFloat heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
