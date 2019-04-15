//
//  ZLyLogger.h
//  ZLyLogger
//
//  Created by leleyinhangjia on 2019/4/2.
//  Copyright © 2019 zhengleyin. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZLyLoggerLevelNone = 0,
    ZLyLoggerLevelInfo = 1,
    ZLyLoggerLevelDebug = 1 << 1,
    ZLyLoggerLevelError = 1 << 2,
    ZLyLoggerLevelAll = ZLyLoggerLevelInfo | ZLyLoggerLevelDebug | ZLyLoggerLevelError,
} ZLyLoggerLevel;

extern NSString *const ZLyLoggerDomainCURL;
extern NSString *const ZLyLoggerDomainNetwork;
extern NSString *const ZLyLoggerDomainIM;
extern NSString *const ZLyLoggerDomainStorage;
extern NSString *const ZLyLoggerDomainDefault;

@interface ZLyLogger : NSObject
+ (void)setAllLogsEnabled:(BOOL)enabled;
+ (void)setLoggerLevelMask:(NSUInteger)levelMask;
+ (void)addLoggerDomain:(NSString *)domain;
+ (void)removeLoggerDomain:(NSString *)domain;
+ (void)logFunc:(const char *)func line:(const int)line domain:(nullable NSString *)domain level:(ZLyLoggerLevel)level message:(NSString *)fmt, ... NS_FORMAT_FUNCTION(5, 6);
+ (BOOL)levelEnabled:(ZLyLoggerLevel)level;
+ (BOOL)containDomain:(NSString *)domain;
@end

NS_ASSUME_NONNULL_END

#define _ZLyLoggerInfo(_domain, ...) [ZLyLogger logFunc:__func__ line:__LINE__ domain:_domain level:ZLyLoggerLevelInfo message:__VA_ARGS__]
#define _ZLyLoggerDebug(_domain, ...) [ZLyLogger logFunc:__func__ line:__LINE__ domain:_domain level:ZLyLoggerLevelDebug message:__VA_ARGS__]
#define _ZLyLoggerError(_domain, ...) [ZLyLogger logFunc:__func__ line:__LINE__ domain:_domain level:ZLyLoggerLevelError message:__VA_ARGS__]

#define ZLyLoggerInfo(domain, ...) _ZLyLoggerInfo(domain, __VA_ARGS__)
#define ZLyLoggerDebug(domain, ...) _ZLyLoggerDebug(domain, __VA_ARGS__)
#define ZLyLoggerError(domain, ...) _ZLyLoggerError(domain, __VA_ARGS__)

#define ZLyLoggerI(...)  ZLyLoggerInfo(ZLyLoggerDomainDefault, __VA_ARGS__)
#define ZLyLoggerD(...) ZLyLoggerDebug(ZLyLoggerDomainDefault, __VA_ARGS__)
#define ZLyLoggerE(...) ZLyLoggerError(ZLyLoggerDomainDefault, __VA_ARGS__)
