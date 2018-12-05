//
//  AuthorModel.h
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthorData,Latestarticle,AuthorUser;
@interface AuthorModel : NSObject


@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) AuthorData *data;

@property (nonatomic, assign) NSInteger code;



@end
@interface AuthorData : NSObject

@property (nonatomic, copy) NSString *roleType;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *brief;

@property (nonatomic, assign) NSInteger totalView;

@property (nonatomic, strong) NSArray *latestArticle;

@property (nonatomic, copy) NSString *name;

@end

@interface Latestarticle : NSObject

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

@property (nonatomic, strong) AuthorUser *user;

@property (nonatomic, assign) long long updateTime;

@end

@interface AuthorUser : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger ssoId;

@end

