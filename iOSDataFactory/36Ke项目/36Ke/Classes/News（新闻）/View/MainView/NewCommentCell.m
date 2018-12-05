//
//  NewCommentCell.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewCommentCell.h"

@implementation NewCommentCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"newCommnet";
    NewCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NewCommentCell class]) owner:nil options:nil] lastObject];
    }
    
    
    return cell;
}

@end
