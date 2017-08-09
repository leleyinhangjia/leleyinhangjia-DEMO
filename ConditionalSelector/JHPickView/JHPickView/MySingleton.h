//
//  MySingleton.h
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModelData.h"       //  城市模型数据

@interface MySingleton : NSObject

+(instancetype)shareMySingleton;

/**
 *  城市模型数据
 */
@property (nonatomic, strong) CityModelData *cityModel;
/**
 *  Json转为OC对象
 */
-(id)getObjectFromJsonString:(NSString *)jsonString;
/**
 *  保存字段对应的值到本地
 *
 *  @param fieldName 字段
 *  @param value     值
 */
+(void)saveLoacalWithField:(NSString *)fieldName value:(id)value;
/**
 *  得到保存到本地对应字段的值
 *
 *  @param fieldName 字段
 *
 *  @return 值
 */
+(id)getsaveLoacalField:(NSString *)fieldName;

@end
