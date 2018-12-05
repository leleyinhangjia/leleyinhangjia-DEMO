//
//  SearchListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "SearchListJsonHandler.h"
#import "HttpTool.h"
#import <MJExtension.h>
#import "SearchModel.h"
//#import "ContentModel.h"
@implementation SearchListJsonHandler

- (void)handlerSearchObject:(NSString *)url params:(NSMutableDictionary *)params {
    
//    NSString *allUrl = [NSString stringWithFormat:@"%@",childData.feedId];
    NSLog(@"");
    [HttpTool post:url params:params success:^(id responseObj) {
        
//        NSMutableArray *searchResult = responseObj[@"data"];
        
        NSDictionary *dic = responseObj[@"data"];
//        NSArray *companyArray = dic[@"company"];
//        NSArray *userArray = dic[@"user"];
//        NSArray *orgArray = dic[@"org"];
        
//        [DataSearch mj_objectWithKeyValues:<#(id)#>]
        SearchData *model = [SearchData mj_objectWithKeyValues:dic];
//        NSLog(@"[DataSearch mj_objectWithKeyValues]---%@",[DataSearch mj_objectWithKeyValues:dic]);
//        NSLog(@"resultArray--%@",model);
        
//        NSMutableArray *resultArray = [SearchData mj_objectWithKeyValues:dic];
//        NSLog(@"resultArray--%@",resultArray);
//        NSMutableArray *resultSearch = [DataSearch mj_objectWithKeyValues:searchResult];
//        NSLog(@"resultSearch---%@",resultSearch);
        
//        NSLog(@"responseObj[@"data"]---%@",);
        
//        NSMutableArray *retusultCompany = [Company2 mj_objectArrayWithKeyValuesArray:companyArray];
//        NSMutableArray *retusultUser = [User345 mj_objectArrayWithKeyValuesArray:userArray];
//        NSMutableArray *retusultOrg = [Org1 mj_objectArrayWithKeyValuesArray:orgArray];
        
//        NSLog(@"retusultCompany---%@",retusultCompany);
//        NSLog(@"retusultUser---%@",retusultUser);
//        NSLog(@"retusultUser---%@",retusultOrg);
//        NSMutableArray *array = responseObj[@"data"];
//        NSMutableArray *resultArray = [NSMutableArray array];
//        for (NSDictionary *data1 in array) {
//            NSLog(@"data1---%@",data1);
        
//        }
        
//        NSLog(@"array---%@",array[@"company"]);
//        NSLog(@"moreorg----%@",dic[@"moreorg"]);
//         NSLog(@"morecompany----%@",dic[@"morecompany"]);
//        
//        NSLog(@"company----%@",dic[@"company"]);
//        NSLog(@"moreuser----%@",dic[@"moreuser"]);
//        NSLog(@"org----%@",dic[@"org"]);
//        NSLog(@"");
//                NSArray *array = dic[@"data"];
//        NSLog(@"array[@---%@",array);
//        NSMutableArray *resultArray = [DataSearch mj_objectArrayWithKeyValuesArray:array];
//        NSMutableArray *resultArray = [SearchData mj_objectArrayWithKeyValuesArray:dic];
        
        //        [dataContent setValuesForKeysWithDictionary:dic];
        
        //        NSMutableArray *resultArray = [Pics mj_objectArrayWithKeyValuesArray:array];
        
        if (self.delegate) {
            [self.delegate SearchListJsonHandler:self withResult:model];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        
    }];
    
}
@end

