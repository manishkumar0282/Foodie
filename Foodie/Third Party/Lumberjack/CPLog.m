//
//  CPLog.h
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 3/18/14
//
//

#import "CPLog.h"

@interface CPLogFormatter ()
{
	NSDateFormatter *dateFormatter;
}
@end

@implementation CPLogFormatter

- (id)init
{
	return [self initWithDateFormatter:nil];
}

- (id)initWithDateFormatter:(NSDateFormatter *)aDateFormatter
{
	if ((self = [super init]))
	{
		if (aDateFormatter)
		{
			dateFormatter = aDateFormatter;
		}
		else
		{
			dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4]; // 10.4+ style
			[dateFormatter setDateFormat:@"hh:mm:ss.SSS"];
		}
	}
	return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
	NSString *dateAndTime = [dateFormatter stringFromDate:(logMessage->timestamp)];
    NSString *flag;
    if (logMessage->logFlag & LOG_FLAG_FATAL) {
        flag = @"F";
    }
    else if(logMessage->logFlag & LOG_FLAG_ERROR) {
        flag = @"E";
    }
    else if(logMessage->logFlag & LOG_FLAG_WARN) {
        flag = @"W";
    }
    else if(logMessage->logFlag & LOG_FLAG_USER) {
        flag = @"U";
    }
    else if(logMessage->logFlag & LOG_FLAG_HTTP) {
        flag = @"H";
    }
    else if(logMessage->logFlag & LOG_FLAG_INFO) {
        flag = @"I";
    }
    else if(logMessage->logFlag & LOG_FLAG_DEBUG) {
        flag = @"D";
    }
    else if(logMessage->logFlag & LOG_FLAG_VERBOSE) {
        flag = @"V";
    }
    
	NSString *msg = [NSString stringWithFormat:@"%@ %@ %-4x %-4d %s %@", flag, dateAndTime, logMessage->machThreadID, logMessage->lineNumber, logMessage->function, logMessage->logMsg];
    return msg;
}

@end
