//
//  ZlyCareViewController.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZlyCareViewController.h"

@interface ZlyCareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toSeeBtn;

@end

@implementation ZlyCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor whiteColor];
    
    self.toSeeBtn.layer.borderWidth = 1;
    self.toSeeBtn.layer.borderColor = KeyColor.CGColor;
    self.toSeeBtn.layer.cornerRadius = self.toSeeBtn.height * 0.5;
    [self.toSeeBtn.layer masksToBounds];
    
    [self.toSeeBtn setTitleColor:KeyColor forState:UIControlStateNormal];
}


@end
