//
//  CityModelData.m
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import "CityModelData.h"

@implementation CityModelData


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"province" : [Province class]};
}
@end
@implementation Province

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"city" : [City class]};
}

@end


@implementation City

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"district" : [District class]};
}

@end


@implementation District

@end
