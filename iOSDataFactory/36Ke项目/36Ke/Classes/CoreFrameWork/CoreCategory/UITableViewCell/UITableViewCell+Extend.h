//
//  UITableViewCell+Extend.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extend)

/**
 *  创建cell
 *
 *  @param tableView 所属tableView
 *
 *  @return cell实例
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
