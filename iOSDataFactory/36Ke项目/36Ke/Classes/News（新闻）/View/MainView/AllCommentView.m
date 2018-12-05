//
//  AllCommentView.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "AllCommentView.h"

@implementation AllCommentView
- (void)awakeFromNib {
    
}

+ (instancetype)commentWithView2 {
    AllCommentView *commentView2 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    return commentView2;
}


@end
