//
//  SearchModel2.h
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataSearch,Org1,Company2,User345;
@interface SearchModel2 : NSObject


@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) DataSearch *data;

@property (nonatomic, assign) NSInteger code;



@end
@interface DataSearch : NSObject

@property (nonatomic, strong) NSArray *user;

@property (nonatomic, assign) BOOL moreuser;

@property (nonatomic, assign) BOOL morecompany;

@property (nonatomic, assign) BOOL moreorg;

@property (nonatomic, strong) NSArray *company;

@property (nonatomic, strong) NSArray *org;

@end

@interface Org1 : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface Company2 : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface User345 : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL investor;

@property (nonatomic, assign) BOOL premiumInvestor;

@end

