//
//  ContentModel.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@class ContentData,ContentUser;
@interface ContentModel : NSObject


@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ContentData *data;

@property (nonatomic, assign) NSInteger code;



@end
@interface ContentData : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL myFavorites;

@property (nonatomic, assign) NSInteger columnId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *featureImg;

@property (nonatomic, assign) NSInteger postId;

@property (nonatomic, assign) long long publishTime;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *columnName;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, strong) UserModel *user;

@property (nonatomic, assign) long long updateTime;



@end

@interface ContentUser : NSObject

@property (nonatomic, copy) NSString *a1;

@property (nonatomic, copy) NSString *n1;

@property (nonatomic, assign) NSInteger s1;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end




