//
//  SearchModel.m
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

@end




@implementation SearchData

+ (NSDictionary *)objectClassInArray{
    return @{@"org" : [OrgModel class], @"company" : [CompanyModel2 class], @"user" : [UserModel2 class]};
}

@end


@implementation OrgModel

@end


@implementation CompanyModel2

@end


@implementation UserModel2

@end


