//
//  CommentModel.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@class CommentData,CommentData2,CommentUser;
@interface CommentModel : NSObject


@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) CommentData *data;

@property (nonatomic, assign) NSInteger code;


@end
@interface CommentData : NSObject

@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger page;

@end

@interface CommentData2 : NSObject

@property (nonatomic, strong) UserModel *user;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger cid;

@property (nonatomic, assign) long long updateTime;

@property (nonatomic, assign) NSInteger postId;

@property (nonatomic, assign) long long createTime;

@property (nonatomic, copy) NSString *state;

@end


