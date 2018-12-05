//
//  KeTVModel.h
//  36Ke
//
//  Created by lmj  on 16/3/9.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <Foundation/Foundation.h>

@class KeTVData1,KeTVData2,KeTv;
@interface KeTVModel : NSObject



@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) KeTVData1 *data;

@property (nonatomic, assign) NSInteger code;



@end
@interface KeTVData1 : NSObject

@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger page;

@end

@interface KeTVData2 : NSObject

@property (nonatomic, strong) KeTv *tv;

@property (nonatomic, copy) NSString *columnName;

@property (nonatomic, copy) NSString *columnId;

@property (nonatomic, copy) NSString *type;

@end

@interface KeTv : NSObject

@property (nonatomic, copy) NSString *videoSource480;

@property (nonatomic, assign) long long publishTime;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *featureImg;

@property (nonatomic, copy) NSString *videoSource720;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *youkuUrl;

@property (nonatomic, assign) NSInteger durationLong;

@property (nonatomic, copy) NSString *videoSource;

@property (nonatomic, copy) NSString *videoSource360;

@end

