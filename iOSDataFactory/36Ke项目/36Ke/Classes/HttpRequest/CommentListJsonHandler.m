//
//  CommentListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "CommentListJsonHandler.h"
#import "HttpTool.h"
#import <MJExtension.h>
//#import "ContentModel.h"
#import "NewsModel.h"
@implementation CommentListJsonHandler

- (void)handlerCommentObject:(NSString *)url childData:(ChildData *)childData {
    
    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",url,childData.feedId];
    
    [HttpTool get:allUrl params:nil success:^(id responseObj) {
        
       

        NSDictionary *dic = responseObj[@"data"];
        
        NSArray *array = dic[@"data"];
//         NSLog(@"dic[@---%@",dic[@"data"]);
        NSMutableArray *resultArray = [CommentData2 mj_objectArrayWithKeyValuesArray:array];
        
//        [dataContent setValuesForKeysWithDictionary:dic];
        
        //        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate CommentListJsonHandler:self withResult:resultArray];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)handlerCommentObject:(NSString *)url  type:(int)type {
    
//    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",url,childData.feedId];
    
    [HttpTool get:url params:nil success:^(id responseObj) {
        
        
        
        NSDictionary *dic = responseObj[@"data"];
        
        NSArray *array = dic[@"data"];
//        NSLog(@"dic[@---%@",dic[@"data"]);
        NSMutableArray *resultArray = [CommentData2 mj_objectArrayWithKeyValuesArray:array];
        
        //        [dataContent setValuesForKeysWithDictionary:dic];
        
        //        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate CommentListJsonHandler2:self withResult:resultArray type:type];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];
    
}


@end
