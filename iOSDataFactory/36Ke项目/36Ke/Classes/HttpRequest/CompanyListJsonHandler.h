//
//  CompanyListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "CompanyModel.h"
@protocol CompanyListJsonHandlerDelegate;

@interface CompanyListJsonHandler : NSObject

- (void)handlerCompanyObject:(NSString *)url childData:(ChildData *)childData;

@property (nonatomic, weak) id<CompanyListJsonHandlerDelegate> delegate;

@end


@protocol CompanyListJsonHandlerDelegate <NSObject>

- (void)CompanyListJsonHandler:(CompanyListJsonHandler *)handler withResult:(NSMutableArray *)result;


@end