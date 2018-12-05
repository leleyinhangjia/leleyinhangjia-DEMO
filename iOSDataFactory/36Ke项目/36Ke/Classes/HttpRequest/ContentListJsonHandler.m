//
//  ContentListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "ContentListJsonHandler.h"
#import "HttpTool.h"
#import <MJExtension.h>
#import "ContentModel.h"
#import "NewsModel.h"
@implementation ContentListJsonHandler

- (void)handlerContentObject:(NSString *)url childData:(ChildData *)childData {
    
    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",url,childData.feedId];
    
    [HttpTool get:allUrl params:nil success:^(id responseObj) {
        
        NSDictionary *dic = responseObj[@"data"];
//        NSDictionary *userDic = dic[@"user"];
        
//        NSArray *keysArray = [dic allKeys];
//        NSArray *userKeys = [userDic allKeys];
        
        
        ContentData *dataModel = [ContentData mj_objectWithKeyValues:dic];
//        ContentUser *userData = [[ContentUser alloc] init];
//        NSMutableArray *userArray = [NSMutableArray array];
//        for (NSString *key in userKeys) {
//            NSLog(@"key--%@,,,dic[key]---%@",key,userDic[key]);
//            [userArray addObject:userDic[key]];
//        }
//        ContentUser *userData = [[ContentUser alloc] init];
//        [userData setValuesForKeysWithDictionary:userDic];
        
        
        
//        [userData initWithDict:userDic];
        
        
//        data = [ContentData mj_objectWithKeyValues:dic];
//        NSMutableArray *resultArray = [NSMutableArray array];
//        for (NSString *key in keysArray) {
//            NSString *value = dic[key];
//            if ([value isEqualToString:@"user"]) {
//                
//            }
//            [resultArray addObject:value];
//        }
        
//        ContentData *dataContent = [[ContentData alloc] init];
//        [dataContent setValuesForKeysWithDictionary:dic];
        
//        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate ContentListJsonHandler:self withResult:dataModel];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];
    
}



@end
