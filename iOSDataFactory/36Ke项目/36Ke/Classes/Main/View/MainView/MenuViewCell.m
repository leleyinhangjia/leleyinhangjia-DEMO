//
//  MenuViewCell.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "MenuViewCell.h"
#import "Common.h"
@implementation MenuViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView viewColor:(NSString *)viewColor nameLabel:(NSString *)nameLabel {
    static NSString *ID = @"menuCell";
    MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MenuViewCell class]) owner:nil options:nil] lastObject];
    }
    cell.nameLabel.text = nameLabel;
    
    cell.leftView.backgroundColor = [Common translateHexStringToColor:viewColor];
//    [cell.leftView setBackgroundColor:[Common translateHexStringToColor:viewColor]];
//    [cell.leftView]

    
    return cell;

}


@end
