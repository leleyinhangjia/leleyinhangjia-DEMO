//
//  CommentCell.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "CommentCell.h"
#import <UIImageView+WebCache.h>
#import "CommentModel.h"
#import "NSDate+Extension.h"
@interface CommentCell ()



@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *createTime;

@end

@implementation CommentCell
- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    
}

- (void)layoutSubviews {
    
}


/** 把model分出来设置值，在计算的高度的可以很好的调整UI */
- (void)setModel:(CommentData2 *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.user.avatar]];
    self.name.text = model.user.name;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.createTime];
    self.createTime.text = [NSDate stringFromDate:confromTimesp];
    self.content.text = model.content;
    int WordCount= self.content.frame.size.width/15;
    CGFloat heightCount= self.content.text.length / WordCount;
    [self.content setFrame:CGRectMake(self.content.frame.origin.x, 0, self.content.frame.size.width,heightCount * 15 )];
    [self layoutIfNeeded];
    _heightLabel = CGRectGetMaxY(self.content.frame)   + 10;
    NSLog(@"cell--_heightLabel--!%lf",_heightLabel);
}

/** 把model传入，在计算的高度的不便于调整 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"commentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommentCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}




@end
