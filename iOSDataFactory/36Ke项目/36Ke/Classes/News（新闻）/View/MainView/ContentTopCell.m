//
//  ContentTopCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "ContentTopCell.h"
#import <UIImageView+WebCache.h>
@interface ContentTopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UIButton *nextClick;

@end


@implementation ContentTopCell


- (void)awakeFromNib {
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    [self.nextClick setBackgroundImage:[UIImage imageNamed:@"news_icon_up"] forState:UIControlStateSelected];
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleTap];


}
- (IBAction)nextClick:(UIButton *)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(nextContentInformation:)]) {
        [self.delegate nextContentInformation:_model];
    }
}

- (void)nextEdit
{
    self.nextClick.selected = !self.nextClick.selected;
}
#pragma mark
#pragma mark - 单击手势方法
- (void)handleSingleTap{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(nextContentInformation:)]) {
        [self.delegate nextContentInformation:_model];
    }
    
}

- (void)setModel:(ContentData *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    //    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    self.name.text = model.user.name;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(ContentData *)model {
    
    static NSString *ID = @"topCell";
    ContentTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContentTopCell class]) owner:nil options:nil] lastObject];
    }
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    //    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model..data.featureImg]];
    cell.name.text = model.user.name;
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.publishTime];
    
    
//    cell.timeLabel.text = [NSDate stringFromDate:confromTimesp];
//    cell.nameLabel.text = model.user.name;
//    cell.typeLabel.text = model.columnName;
    
    return cell;

}

@end
