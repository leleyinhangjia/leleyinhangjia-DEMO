//
//  ZLyLogger.m
//  ZLyLogger
//
//  Created by leleyinhangjia on 2019/4/2.
//  Copyright © 2019 zhengleyin. All rights reserved.
//

#import "ZLyLogger.h"



NSString *const ZLyLoggerDomainCURL = @"LOG_CURL";
NSString *const ZLyLoggerDomainNetwork = @"LOG_NETWORK";
NSString *const ZLyLoggerDomainStorage = @"LOG_STORAGE";
NSString *const ZLyLoggerDomainIM = @"LOG_IM";
NSString *const ZLyLoggerDomainDefault = @"LOG_DEFAULT";

static NSMutableSet *loggerDomain = nil;
static NSUInteger loggerLevelMask = ZLyLoggerLevelNone;
static NSArray *loggerDomains = nil;

@implementation ZLyLogger

+ (void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        loggerDomains = @[
                          ZLyLoggerDomainCURL,
                          ZLyLoggerDomainNetwork,
                          ZLyLoggerDomainIM,
                          ZLyLoggerDomainStorage,
                          ZLyLoggerDomainDefault
                          ];
    });
#ifdef DEBUG
    [self setAllLogsEnabled:YES];
#else
    [self setAllLogsEnabled:NO];
#endif
}

+ (void)setAllLogsEnabled:(BOOL)enabled {
    if (enabled) {
        for (NSString *loggerDomain in loggerDomains) {
            [ZLyLogger addLoggerDomain:loggerDomain];
        }
        [ZLyLogger setLoggerLevelMask:ZLyLoggerLevelAll];
    } else {
        for (NSString *loggerDomain in loggerDomains) {
            [ZLyLogger removeLoggerDomain:loggerDomain];
        }
        [ZLyLogger setLoggerLevelMask:ZLyLoggerLevelNone];
    }
    
    [self setCertificateInspectionEnabled:enabled];
}

+ (void)setCertificateInspectionEnabled:(BOOL)enabled {
    if (enabled) {
        setenv("CURL_INSPECT_CERT", "YES", 1);
    } else {
        unsetenv("CURL_INSPECT_CERT");
    }
}

+ (void)setLoggerLevelMask:(NSUInteger)levelMask {
    loggerLevelMask = levelMask;
}

+ (void)addLoggerDomain:(NSString *)domain {
    if (!loggerDomain) {
        loggerDomain = [[NSMutableSet alloc] init];
    }
    [loggerDomain addObject:domain];
}

+ (void)removeLoggerDomain:(NSString *)domain {
    [loggerDomain removeObject:domain];
}

+ (BOOL)levelEnabled:(ZLyLoggerLevel)level {
    return loggerLevelMask & level;
}

+ (BOOL)containDomain:(NSString *)domain {
    return [loggerDomain containsObject:domain];
}

+ (void)logFunc:(const char *)func line:(int)line domain:(NSString *)domain level:(ZLyLoggerLevel)level message:(NSString *)fmt, ... {
    if (!domain || [loggerDomain containsObject:domain]) {
        if (level & loggerLevelMask) {
            NSString *levelString = nil;
            switch (level) {
                case ZLyLoggerLevelInfo:
                    levelString = @"💙INFO";
                    break;
                case ZLyLoggerLevelDebug:
                    levelString = @"💚DEBUG";
                    break;
                case ZLyLoggerLevelError:
                    levelString = @"❤️ERROR";
                    break;
                default:
                    levelString = @"🧡UNKNOW";
                    break;
            }
            va_list args;
            va_start(args, fmt);
            NSString *message = [[NSString alloc] initWithFormat:fmt arguments:args];
            va_end(args);
            NSLog(@"[%@] %s [Line %d] %@", levelString, func, line, message);
        }
    }
}

@end
