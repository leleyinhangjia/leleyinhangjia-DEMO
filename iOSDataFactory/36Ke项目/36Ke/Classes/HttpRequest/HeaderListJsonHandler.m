//
//  HeaderListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "HeaderListJsonHandler.h"
#import "LMNetworkTools.h"
#import <AFNetworking.h>
#import "HeaderModel.h"
#import "HttpTool.h"
#import <MJExtension.h>
#import "Common.h"
#import "NSDate+Extension.h"
@implementation HeaderListJsonHandler

- (void)handlerHeaderObject {
    
    [HttpTool get:@"https://rong.36kr.com/api/mobi/roundpics/v4?" params:nil success:^(id responseObj) {
        
        NSDictionary *dic = responseObj[@"data"];
        
        NSArray *array = dic[@"pics"];
        
        
        NSData *tempData = [NSDate toJSONData:dic[@"pics"]];
        NSString *jsonString = [[NSString alloc] initWithData:tempData
                                                     encoding:NSUTF8StringEncoding];
        //        NSLog(@"array---%@",array);
        //        NSLog(@"dic[---%@",dic[@"data"]);
        
        
        //        NSString *writeString = [NSString stringWithFormat:@"%@",array];
        
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_header.txt"]];
        [Common writeString:jsonString toPath:path];
        
        
        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate HeaderListJsonHandler:self withResult:resultArray];
        }
        
//        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        NSLog(@"error:");
    }];

    
    
}
@end
