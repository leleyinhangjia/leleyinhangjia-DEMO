//
//  ContentListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"
#import "NewsModel.h"
@protocol ContentListJsonHandlerDelegate;

@interface ContentListJsonHandler : NSObject

- (void)handlerContentObject:(NSString *)url childData:(ChildData *)childData;

@property (nonatomic, weak) id<ContentListJsonHandlerDelegate> delegate;

@end


@protocol ContentListJsonHandlerDelegate <NSObject>

- (void)ContentListJsonHandler:(ContentListJsonHandler *)handler withResult:(ContentData *)result;


@end
