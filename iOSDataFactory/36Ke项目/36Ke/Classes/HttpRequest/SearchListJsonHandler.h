//
//  SearchListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/21.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "SearchModel.h"
@protocol SearchListJsonHandlerDelegate;

@interface SearchListJsonHandler : NSObject

- (void)handlerSearchObject:(NSString *)url params:(NSMutableDictionary *)params;

@property (nonatomic, weak) id<SearchListJsonHandlerDelegate> delegate;

@end


@protocol SearchListJsonHandlerDelegate <NSObject>

- (void)SearchListJsonHandler:(SearchListJsonHandler *)handler withResult:(SearchData *)result;


@end
