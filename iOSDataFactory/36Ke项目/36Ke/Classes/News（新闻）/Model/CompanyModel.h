//
//  CompanyModel.h
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompanyData;
@interface CompanyModel : NSObject



@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger code;



@end
@interface CompanyData : NSObject

@property (nonatomic, copy) NSString *brief;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *comType;

@property (nonatomic, copy) NSString *financePhase;

@property (nonatomic, copy) NSString *industry;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *name;

@end

