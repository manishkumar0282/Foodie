//
//  CPLog.h
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 3/18/14
//
//

#import "DDLog.h"

// First undefine the default stuff we don't want to use.
// https://github.com/robbiehanson/CocoaLumberjack/wiki/CustomLogLevels

#undef LOG_FLAG_ERROR
#undef LOG_FLAG_WARN
#undef LOG_FLAG_INFO
#undef LOG_FLAG_DEBUG
#undef LOG_FLAG_VERBOSE

#undef LOG_LEVEL_ERROR
#undef LOG_LEVEL_WARN
#undef LOG_LEVEL_INFO
#undef LOG_LEVEL_DEBUG
#undef LOG_LEVEL_VERBOSE

#undef LOG_ERROR
#undef LOG_WARN
#undef LOG_INFO
#undef LOG_DEBUG
#undef LOG_VERBOSE

#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogDebug
#undef DDLogVerbose

#undef DDLogCError
#undef DDLogCWarn
#undef DDLogCInfo
#undef DDLogCDebug
#undef DDLogCVerbose

// Now define everything how we want it

#define LOG_FLAG_FATAL   (1 << 0)  // 0.00000001
#define LOG_FLAG_ERROR   (1 << 1)  // 0.00000010
#define LOG_FLAG_WARN    (1 << 2)  // 0.00000100
#define LOG_FLAG_USER    (1 << 3)  // 0.00001000
#define LOG_FLAG_INFO    (1 << 4)  // 0.00010000
#define LOG_FLAG_HTTP    (1 << 5)  // 0.00100000
#define LOG_FLAG_DEBUG   (1 << 6)  // 0.01000000
#define LOG_FLAG_VERBOSE (1 << 7)  // 0.10000000


#define LOG_LEVEL_FATAL   (LOG_FLAG_FATAL)                       // 0...000001
#define LOG_LEVEL_ERROR   (LOG_FLAG_ERROR  | LOG_LEVEL_FATAL )   // 0...000011
#define LOG_LEVEL_WARN    (LOG_FLAG_WARN   | LOG_LEVEL_ERROR )   // 0...000111
#define LOG_LEVEL_USER    (LOG_FLAG_USER   | LOG_LEVEL_WARN  )   // 0...001111
#define LOG_LEVEL_INFO    (LOG_FLAG_INFO   | LOG_LEVEL_USER  )   // 0...011111
#define LOG_LEVEL_HTTP    (LOG_FLAG_HTTP   | LOG_LEVEL_INFO  )   // 0...111111
#define LOG_LEVEL_DEBUG   (LOG_FLAG_DEBUG  | LOG_LEVEL_INFO  )   // 0..1011111
#define LOG_LEVEL_VERBOSE (LOG_FLAG_VERBOSE| LOG_LEVEL_DEBUG | LOG_FLAG_HTTP)   // 0.11111111

#define LOG_FATAL   (ddLogLevel & LOG_FLAG_FATAL )
#define LOG_ERROR   (ddLogLevel & LOG_FLAG_ERROR )
#define LOG_WARN    (ddLogLevel & LOG_FLAG_WARN  )
#define LOG_USER    (ddLogLevel & LOG_FLAG_USER  )
#define LOG_INFO    (ddLogLevel & LOG_FLAG_INFO  )
#define LOG_HTTP    (ddLogLevel & LOG_FLAG_HTTP )
#define LOG_DEBUG   (ddLogLevel & LOG_FLAG_DEBUG )
#define LOG_VERBOSE (ddLogLevel & LOG_FLAG_VERBOSE )

#undef LOG_OBJC_MAYBE
#define LOG_OBJC_MAYBE(async, lvl, flg, ctx, frmt, ...) \
    LOG_MAYBE(async, lvl, flg, ctx, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#define DDLogFatal(frmt, ...)     SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_FATAL,  0, frmt, ##__VA_ARGS__)
#define DDLogError(frmt, ...)     SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_ERROR,  0, frmt, ##__VA_ARGS__)
#define DDLogWarn(frmt, ...)      SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_WARN,   0, frmt, ##__VA_ARGS__)
#define DDLogUser(frmt, ...)      SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_USER, 0, frmt, ##__VA_ARGS__)
#define DDLogInfo(frmt, ...)      SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_INFO,   0, frmt, ##__VA_ARGS__)
//#define CPLog(frmt, ...)      SYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_INFO,   0, frmt, ##__VA_ARGS__)
#define DDLogHTTP(frmt, ...)      ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_HTTP,  0, frmt, ##__VA_ARGS__)
#define DDLogDebug(frmt, ...)     ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DEBUG,  0, frmt, ##__VA_ARGS__)
#define DDLogVerbose(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_VERBOSE,  0, frmt, ##__VA_ARGS__)

#define DDLogCFatal(frmt, ...)     SYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_FATAL,  0, frmt, ##__VA_ARGS__)
#define DDLogCError(frmt, ...)     SYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_ERROR,  0, frmt, ##__VA_ARGS__)
#define DDLogCWarn(frmt, ...)     ASYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_WARN,   0, frmt, ##__VA_ARGS__)
#define DDLogCUser(frmt, ...)      SYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_USER, 0, frmt, ##__VA_ARGS__)
#define DDLogCInfo(frmt, ...)     ASYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_INFO,   0, frmt, ##__VA_ARGS__)
#define DDLogCHTTP(frmt, ...)      SYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_HTTP,  0, frmt, ##__VA_ARGS__)
#define DDLogCDebug(frmt, ...)    ASYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_DEBUG,  0, frmt, ##__VA_ARGS__)
#define DDLogCVerbose(frmt, ...)  ASYNC_LOG_C_MAYBE(ddLogLevel, LOG_FLAG_VERBOSE,  0, frmt, ##__VA_ARGS__)

#define NSLogError(__fmt, ...) LOG_C_MAYBE(LOG_ASYNC_ERROR, LOG_LEVEL_INFO, LOG_FLAG_ERROR, 0, __fmt, ##__VA_ARGS__)
#define NSLogWarn(__fmt, ...)  LOG_C_MAYBE(LOG_ASYNC_WARN, LOG_LEVEL_INFO, LOG_FLAG_WARN, 0, __fmt, ##__VA_ARGS__)
#define NSLogInfo(__fmt, ...)  LOG_C_MAYBE(LOG_ASYNC_INFO, LOG_LEVEL_INFO, LOG_FLAG_INFO, 0, __fmt, ##__VA_ARGS__)
#define NSLogDebug(__fmt, ...) LOG_C_MAYBE(LOG_ASYNC_INFO, LOG_LEVEL_DEBUG, LOG_FLAG_DEBUG, 0, __fmt, ##__VA_ARGS__)
#define NSLogUser(__fmt, ...)  LOG_C_MAYBE(LOG_ASYNC_ERROR, LOG_LEVEL_USER, LOG_FLAG_USER, 0, __fmt, ##__VA_ARGS__)
#define NSLogHTTP(__fmt, ...)  LOG_C_MAYBE(LOG_ASYNC_INFO, LOG_LEVEL_HTTP, LOG_FLAG_HTTP, 0, __fmt, ##__VA_ARGS__)

#define NSLog(__fmt, ...) LOG_C_MAYBE(LOG_ASYNC_INFO,    LOG_LEVEL_INFO, LOG_FLAG_INFO,    0, __fmt, ##__VA_ARGS__)

@interface CPLogFormatter : NSObject <DDLogFormatter>
@end


