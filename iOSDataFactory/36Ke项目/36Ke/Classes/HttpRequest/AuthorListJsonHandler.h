//
//  AuthorListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/10.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
#import "NewsModel.h"
@protocol AuthorListJsonHandlerDelegate;

@interface AuthorListJsonHandler : NSObject

- (void)handlerAuthorObject:(NSString *)url childData:(ChildData *)childData;

@property (nonatomic, weak) id<AuthorListJsonHandlerDelegate> delegate;

@end


@protocol AuthorListJsonHandlerDelegate <NSObject>

- (void)AuthorListJsonHandler:(AuthorListJsonHandler *)handler withResult:(NSMutableArray *)result;


@end
