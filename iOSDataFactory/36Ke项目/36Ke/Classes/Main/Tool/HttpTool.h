//
//  HttpTool.h
//  WeiBo
//
//  Created by lmj on 15-10-25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（将请求成功后想做的事情写在block中）
 *  @param failure 请求失败后的回调 （将请求失败后向做的事情写在block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（将请求成功后想做的事情写在block中）
 *  @param failure 请求失败后的回调 （将请求失败后向做的事情写在block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
@end
