//
//  SearchViewCell.m
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "SearchViewCell.h"
#import <UIImageView+WebCache.h>
@interface SearchViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SearchViewCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
}

- (void)layoutSubviews {
    
}


/** 把model分出来设置值，在计算的高度的可以很好的调整UI */
- (void)setModelOrg:(OrgModel *)model  {
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.titleLabel.text= model.name;
}

- (void)setModelCompany:(CompanyModel2 *)modelCompany  {
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:modelCompany.imgUrl]];
    self.titleLabel.text= modelCompany.name;
}

- (void)setModelUser:(UserModel2 *)modelUser {
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:modelUser.imgUrl]];
    self.titleLabel.text= modelUser.name;
}

/** 把model传入，在计算的高度的不便于调整 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
//    static NSString *ID = @"searchCell";
    SearchViewCell *cell = [[SearchViewCell alloc] init];
    
    
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SearchViewCell class]) owner:nil options:nil] lastObject];
    
    
    return cell;
}


@end
