//
//  SearchViewCell.h
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface SearchViewCell : UITableViewCell

@property (nonatomic, strong) OrgModel *modelOrg;

@property (nonatomic, strong) UserModel2 *modelUser;

@property (nonatomic, strong) CompanyModel2 *modelCompany;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
