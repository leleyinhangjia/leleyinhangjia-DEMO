//
//  MySingleton.m
//  ProvinceAndCityAndTown
//
//  Created by Jivan on 16/12/27.
//  Copyright © 2016年 Jivan. All rights reserved.
//

#import "MySingleton.h"
static MySingleton *mySing=nil;

@implementation MySingleton
+(instancetype)shareMySingleton{
    if (mySing==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{    // 用GCD只操作一次,确保线程的安全
            mySing=[[MySingleton alloc]init];
        });
    }
    return mySing;
}
// alloc 分配内存空间的时候
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (mySing==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            mySing=[super allocWithZone:zone];
        });
    }
    return mySing;
}
// 复制 拷贝的时候
+ (id)copyWithZone:(struct _NSZone *)zone{
    return mySing;
}
-(id)getObjectFromJsonString:(NSString *)jsonString{
    NSError *error=nil;
    if (jsonString) {
        id result=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (error==nil) {
            return result;
        }
        else{
            return nil;
        }
    }
    return nil;
}

+(void)saveLoacalWithField:(NSString *)fieldName value:(id)value{
    NSUserDefaults *defaus=[NSUserDefaults standardUserDefaults];
    [defaus setObject:value forKey:fieldName];
    [defaus synchronize];
}
+(id)getsaveLoacalField:(NSString *)fieldName{
    NSUserDefaults *defaus=[NSUserDefaults standardUserDefaults];
    return [defaus objectForKey:fieldName];
}
@end
