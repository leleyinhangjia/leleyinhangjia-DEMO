//
//  HeaderModel.h
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class HeaderData,Pics;
@interface HeaderModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) HeaderData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface HeaderData : NSObject

@property (nonatomic, strong) NSArray *pics;

@end

@interface Pics : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *action;

@end

