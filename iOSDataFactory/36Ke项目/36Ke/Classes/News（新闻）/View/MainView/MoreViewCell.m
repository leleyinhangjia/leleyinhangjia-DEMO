//
//  MoreViewCell.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "MoreViewCell.h"
#import <UIImageView+WebCache.h>

@interface MoreViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end

@implementation MoreViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(Latestarticle *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:_model.featureImg]];
    
    self.titleLabel.text = _model.title;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"moreCell";
    MoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MoreViewCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;

}

@end
