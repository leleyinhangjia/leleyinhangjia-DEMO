//
//  CityModelData.h
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@class Province,City,District;
@interface CityModelData : NSObject
/**
 *  省份模型数组
 */
@property (nonatomic, strong) NSArray<Province *> *province;

@end
@interface Province : NSObject
/**
 *  省份名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  城市模型数组
 */
@property (nonatomic, strong) NSArray<City *> *city;

@end

@interface City : NSObject
/**
 *  城市名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  县级模型数组
 */
@property (nonatomic, strong) NSArray<District *> *district;

@end

@interface District : NSObject
/**
 *  县级名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  邮编
 */
@property (nonatomic, copy) NSString *zipcode;

@end


