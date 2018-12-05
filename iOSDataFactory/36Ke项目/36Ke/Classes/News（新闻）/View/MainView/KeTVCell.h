//
//  KeTVCell.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeTVModel.h"
@interface KeTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;

@property (weak, nonatomic) IBOutlet UIImageView *featureImg;
@property (weak, nonatomic) IBOutlet UILabel *duration;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, strong) KeTVData2 *model222;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(KeTVData2 *)model;



@end
