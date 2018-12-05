//
//  NSString+Password.h
//  LMJJDNC
//
//  Created by lmj on 16/1/7.
//  Copyright (c) 2016年 lmj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)


/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;





/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;

@end
