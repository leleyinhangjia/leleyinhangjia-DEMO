//
//  HeaderListJsonHandler.h
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderModel.h"

@protocol HeaderListJsonHandlerDelegate;

@interface HeaderListJsonHandler : NSObject

- (void)handlerHeaderObject;

@property (nonatomic, weak) id<HeaderListJsonHandlerDelegate> delegate;

@end


@protocol HeaderListJsonHandlerDelegate <NSObject>

- (void)HeaderListJsonHandler:(HeaderListJsonHandler *)handler withResult:(NSMutableArray *)result;


@end