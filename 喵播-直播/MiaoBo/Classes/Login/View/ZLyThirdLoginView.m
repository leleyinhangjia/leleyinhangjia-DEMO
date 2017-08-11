//
//  ZLyThirdLoginView.m
//  MiaoBo
//
//  Created by mpgy on 2017/3/7.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import "ZLyThirdLoginView.h"

@implementation ZLyThirdLoginView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    //新浪登录
    UIImageView * sina = [self creatImageView:@"wbLoginicon_60x60" tag:LoginTypeSina];
    //QQ
    UIImageView * QQ = [self creatImageView:@"qqloginicon_60x60" tag:LoginTypeQQ];
    //微信
    UIImageView * WeChat = [self creatImageView:@"wxloginicon_60x60" tag:LoginTypeWechat];
    [self addSubview:sina];
    [self addSubview:QQ];
    [self addSubview:WeChat];
    
    [sina mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@60);
    }];
    [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.right.equalTo(sina.mas_left).offset(-20);
        make.size.equalTo(sina);
    }];
    [WeChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.left.equalTo(sina.mas_right).offset(20);
        make.size.equalTo(sina);
    }];
    
}

- (UIImageView *)creatImageView:(NSString *)imageName tag:(NSUInteger)tag {
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}
- (void)click:(UITapGestureRecognizer *)tapRec
{
    if (self.clickLogin) {
        self.clickLogin(tapRec.view.tag);
    }
}
@end
