//
//  CommentListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"
#import "CommentModel.h"
@protocol CommentListJsonHandlerDelegate;

@interface CommentListJsonHandler : NSObject

- (void)handlerCommentObject:(NSString *)url childData:(ChildData *)childData;
- (void)handlerCommentObject:(NSString *)url type:(int)type;


@property (nonatomic, weak) id<CommentListJsonHandlerDelegate> delegate;

@end


@protocol CommentListJsonHandlerDelegate <NSObject>
@optional
- (void)CommentListJsonHandler:(CommentListJsonHandler *)handler withResult:(NSMutableArray *)result;
- (void)CommentListJsonHandler2:(CommentListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type;


@end
