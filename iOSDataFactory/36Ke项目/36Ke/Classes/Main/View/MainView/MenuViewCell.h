//
//  MenuViewCell.h
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView viewColor:(NSString *)viewColor nameLabel:(NSString *)nameLabel;
@end
