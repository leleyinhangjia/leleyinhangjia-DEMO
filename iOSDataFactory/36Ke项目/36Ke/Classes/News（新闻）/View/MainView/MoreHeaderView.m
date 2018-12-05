//
//  MoreHeaderView.m
//  36Ke
//
//  Created by lmj  on 16/3/20.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "MoreHeaderView.h"

@interface MoreHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *articleLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;

@end

@implementation MoreHeaderView

- (void)setModel:(AuthorData *)model {
    _model = model;
    self.articleLabel.text = [NSString stringWithFormat:@"%ld篇",_model.totalCount];
    NSInteger total = _model.totalView / 10000;
    self.browseLabel.text = [NSString stringWithFormat:@"%ld万",total];
}

+ (instancetype)headerView {
    MoreHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    return headerView;
}

@end
