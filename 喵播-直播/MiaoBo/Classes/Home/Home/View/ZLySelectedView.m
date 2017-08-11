//
//  ZLySelectedView.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLySelectedView.h"

@interface ZLySelectedView ()

@property (nonatomic, weak)UIView *underLine;
@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, weak)UIButton *hotBtn;
@end
@implementation ZLySelectedView
//下划线
- (UIView *)underLine {
    if (!_underLine) {
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.height - 4, Home_Seleted_Item_W + DefaultMargin, 2)];
        underLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIButton *hotBtn = [self createBtn:@"最热" tag:HomeTypeHot];
    UIButton *newBtn = [self createBtn:@"最新" tag:HomeTypeNew];
    UIButton *careBtn = [self createBtn:@"关注" tag:HomeTypeCare];
    [self addSubview:hotBtn];
    [self addSubview:newBtn];
    [self addSubview:careBtn];
    _hotBtn = hotBtn;
    
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(DefaultMargin * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-DefaultMargin * 2));
        make.centerY.equalTo(self);
        make.width.equalTo(@Home_Seleted_Item_W);
    }];
    //强制性更新一次
    [self layoutIfNeeded];
    //默认选最热
    [self click:hotBtn];
    //监听点击"去看最热主播"
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSeeWorld) name:kNotifyToseeBigWorld object:nil];
    
}

- (void)toSeeWorld
{
    [self click:_hotBtn];
}
//封装button
- (UIButton *)createBtn:(NSString *)title tag:(HomeType)tag
{
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    btn.tag = tag;
    
    [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        [self click:btn];
    }];
    return btn;
}

- (void)setSelectedType:(HomeType)selectedType {
    _selectedType = selectedType;
    self.selectedBtn.selected = YES;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == selectedType) {
            self.selectedBtn = (UIButton *)view;
            ((UIButton *)view).selected = YES;
        }
    }
}

// 点击事件
- (void)click:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.underLine.x = btn.x - DefaultMargin * 0.5;
    }];
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag);
    }
}



@end
