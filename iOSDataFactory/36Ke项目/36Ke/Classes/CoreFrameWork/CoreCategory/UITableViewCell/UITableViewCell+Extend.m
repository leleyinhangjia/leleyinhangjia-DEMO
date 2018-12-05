//
//  UITableViewCell+Extend.m
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import "UITableViewCell+Extend.h"
#import "UIView+Extend.h"

@implementation UITableViewCell (Extend)


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *rid = @"cellID";
    
    // 从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    
    // 缓存池中无数据
    if (cell == nil) {
        cell = [self viewFromXIB];
    }
    
    return cell;
}

@end
