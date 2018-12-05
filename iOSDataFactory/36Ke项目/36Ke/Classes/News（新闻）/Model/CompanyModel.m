//
//  CompanyModel.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "CompanyModel.h"

@implementation CompanyModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CompanyData class]};
}
@end
@implementation CompanyData

@end