//
//  NewsListJsonHandler.m
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "NewsListJsonHandler.h"
#import "NewsModel.h"
#import "HttpTool.h"
#import <MJExtension.h>
#import "KeTVModel.h"
#import "Common.h"
#import "NSDate+Extension.h"
@implementation NewsListJsonHandler


- (void)handlerNewsObject:(NSString *)url type:(int)type column:(NSString *)column {
    
    
    // https://rong.36kr.com/api/mobi/news?columnId=67
    [HttpTool get:url params:nil success:^(id responseObj) {
        
//        NSString *writeString = [NSString stringWithFormat:@"%@",responseObj];
        /** 缓存newsArray,整个分类的数据都存入其中，我可以通过传入的column来判断文件名称是哪种数据
        *  如果是全部，那么我命令文件可以是all,其他分类，可以通过传入的column命名，
                    缓存文件只存当时第一次传入的数据，读取数据也是一样的
                */
        
        
        
        NSDictionary *dic = responseObj[@"data"];
        
    
        
        
        
        NSArray *array =  dic[@"data"];
        NSData *tempData = [NSDate toJSONData:dic[@"data"]];
        NSString *jsonString = [[NSString alloc] initWithData:tempData
                                                     encoding:NSUTF8StringEncoding];
//        NSLog(@"array---%@",array);
//        NSLog(@"dic[---%@",dic[@"data"]);
        
        
//        NSString *writeString = [NSString stringWithFormat:@"%@",array];
        
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",column]];
        [Common writeString:jsonString toPath:path];
//        NSLog(@"[writeString JSONValue] ---%@",[);
        
//        NSLog(@"str---%@",str);
        NSMutableArray *resultArray;
        if ([column hasPrefix:@"tv"]) {
            resultArray = [KeTVData2 mj_objectArrayWithKeyValuesArray:array];
        } else {
            resultArray = [ChildData mj_objectArrayWithKeyValuesArray:array];
        }
        if (self.delegate) {
            [self.delegate NewsListJsonHandler:self withResult:resultArray type:type];
        }
        
//        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        if (self.delegate) {
            [self.delegate NewsListJsonHandlerError:self error:1];
        }
    }];
}

- (void)handlerKeTVObject:(NSString *)url type:(int)type column:(NSString *)column {
    // https://rong.36kr.com/api/mobi/news?columnId=67
    [HttpTool get:url params:nil success:^(id responseObj) {
        
        //        NSString *writeString = [NSString stringWithFormat:@"%@",responseObj];
        /** 缓存newsArray,整个分类的数据都存入其中，我可以通过传入的column来判断文件名称是哪种数据
         *  如果是全部，那么我命令文件可以是all,其他分类，可以通过传入的column命名，
         缓存文件只存当时第一次传入的数据，读取数据也是一样的
         */
        
        
        
        NSDictionary *dic = responseObj[@"data"];
        NSArray *array =  dic[@"data"];
        NSData *tempData = [NSDate toJSONData:dic[@"data"]];
        NSString *jsonString = [[NSString alloc] initWithData:tempData
                                                     encoding:NSUTF8StringEncoding];
        
        NSString *path=[k_DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/cach_%@.txt",column]];
        [Common writeString:jsonString toPath:path];
        NSMutableArray *resultArray = [KeTVData2 mj_objectArrayWithKeyValuesArray:array];

        if (self.delegate) {
            [self.delegate NewsListJsonHandler:self withResult:resultArray type:type];
        }
        
        //        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        if (self.delegate) {
            [self.delegate NewsListJsonHandlerError:self error:1];
        }
    }];
}


@end
