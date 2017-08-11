//
//  ZLyAnchorViewCell.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/14.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyAnchorViewCell.h"
#import "ZlyUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZLyAnchorViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;//封面
@property (weak, nonatomic) IBOutlet UIImageView *star;//等级
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;//直播地址
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;


@end

@implementation ZLyAnchorViewCell
- (void)setUser:(ZlyUser *)user
{
    _user = user;
    // 设置封面头像
    [_coverView sd_setImageWithURL:[NSURL URLWithString:user.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    // 是否是新主播
    self.star.hidden = !user.newStar;
    // 地址
    [self.locationBtn setTitle:user.position forState:UIControlStateNormal];
    // 主播名
    self.nickNameLabel.text = user.nickname;
}

@end
