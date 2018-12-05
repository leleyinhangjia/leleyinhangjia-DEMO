//
//  NewsListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewsModel.h"

@protocol NewsListJsonHandlerDelegate;

@interface NewsListJsonHandler : NSObject


- (void)handlerNewsObject:(NSString *)url type:(int)type column:(NSString *)column;

- (void)handlerKeTVObject:(NSString *)url type:(int)type column:(NSString *)column;


@property (nonatomic, weak) id<NewsListJsonHandlerDelegate> delegate;

@end

@protocol NewsListJsonHandlerDelegate <NSObject>

- (void)NewsListJsonHandler:(NewsListJsonHandler *)handler withResult:(NSMutableArray *)result type:(int)type;
- (void)NewsListJsonHandlerError:(NewsListJsonHandler *)handler error:(int)error;

@end