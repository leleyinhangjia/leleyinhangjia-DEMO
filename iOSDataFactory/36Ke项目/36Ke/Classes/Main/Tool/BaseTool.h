//
//  BaseTool.h
//  WeiBo
//
//  Created by lmj on 15-10-25.
//  Copyright (c) 2015年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@end
