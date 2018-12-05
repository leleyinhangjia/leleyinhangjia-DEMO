//
//  CompanyListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "CompanyListJsonHandler.h"
#import "HttpTool.h"
#import <MJExtension.h>
//#import "ContentModel.h"
#import "NewsModel.h"
@implementation CompanyListJsonHandler

- (void)handlerCompanyObject:(NSString *)url childData:(ChildData *)childData {
    
    
    
    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",url,childData.feedId];
    
    [HttpTool get:allUrl params:nil success:^(id responseObj) {
        
        
        
        NSDictionary *dic = responseObj[@"data"];
        
//        NSArray *array = dic[@"data"];
//        NSLog(@"dic[@---%@",dic[@"data"]);
        NSMutableArray *resultArray = [CompanyData mj_objectArrayWithKeyValuesArray:dic];
        
        //        [dataContent setValuesForKeysWithDictionary:dic];
        
        //        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate CompanyListJsonHandler:self withResult:resultArray];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];
    
}

@end
