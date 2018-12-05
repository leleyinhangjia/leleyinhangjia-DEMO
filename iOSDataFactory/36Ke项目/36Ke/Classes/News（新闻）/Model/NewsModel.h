//
//  NewsModel.h
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsData,ChildData,User;
@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NewsData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface NewsData : NSObject

@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger page;

@end

@interface ChildData : NSObject

@property (nonatomic, copy) NSString *feedId;

@property (nonatomic, strong) User *user;

@property (nonatomic, assign) long long publishTime;

@property (nonatomic, copy) NSString *featureImg;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *columnId;

@property (nonatomic, copy) NSString *columnName;

@property (nonatomic, assign) NSInteger commentCount;

@end

@interface User : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger ssoId;

@end

