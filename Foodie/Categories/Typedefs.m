//
//  Typedefs.m
//
//  Created by Manish Kumar - Imported on 11/26/12.
//
//

#import "Typedefs.h"


void dispatch_operation_main(VoidBlock block)
{
    if (block)
        dispatch_async(dispatch_get_main_queue(), block);
//        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:block]];
}

void dispatch_sync_main(VoidBlock block)
{
    if (block)
        dispatch_sync(dispatch_get_main_queue(), block);
}
void dispatch_async_main(VoidBlock block)
{
    if (block)
        dispatch_async(dispatch_get_main_queue(), block);
}

void dispatch_async_default(VoidBlock block)
{
    if (block)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void dispatch_async_high(VoidBlock block)
{
    if (block)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), block);
}

void dispatch_async_low(VoidBlock block)
{
    if (block)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block);
}

void dispatch_after_main(NSInteger milliSecs, VoidBlock block)
{
    if (block)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(milliSecs * (NSInteger) NSEC_PER_MSEC)), dispatch_get_main_queue(), block);
}

void dispatch_after_default(NSInteger milliSecs, VoidBlock block)
{
    if (block)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(milliSecs * (NSInteger) NSEC_PER_MSEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
void dispatch_after_low(NSInteger milliSecs, VoidBlock block)
{
    if (block)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(milliSecs * (NSInteger) NSEC_PER_MSEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block);
}

void debugOnly(VoidBlock block)
{
#ifdef DEBUG
    if (block)
        block();
#endif
}

bool debugENV(char *env)
{
#ifdef DEBUG
    char *value = getenv(env);
	if (value && ((strcmp(value, "YES") != 0) || (strcmp(value, "1") != 0)))
        return true;
#endif
    return false;
}

bool ENV(char *env)
{
    char *value = getenv(env);
	if (value && ((strcmp(value, "YES") != 0) || (strcmp(value, "1") != 0)))
        return true;
    return false;
}


//        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
//        dispatch_after(delay, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
//        });

NSString *stringFromCGRect(CGRect rect)
{
    NSString *desc = [NSString stringWithFormat:@"x:%4.0f y:%4.0f w:%4.0f h:%4.0f"
                      , rect.origin.x
                      , rect.origin.y
                      , rect.size.width
                      , rect.size.height
                      ];
    return desc;
}

/* http://blog.securemacprogramming.com/?p=vcunofsxfnsjtz&wpmp_switcher=desktop
typedef BOOL(^conditionBlock)(NSError **error);
typedef void(^successHandler)(id result);
typedef void(^failureHandler)(NSError *error);

- (void)ifThis:(conditionBlock)condition
    then:(successHandler)success
    otherwise:(failureHandler)failure
{
    __block NSError *error;
    __block id result;
    if ((result = condition(&error)))
        success(result);
    else
        failure(error);
}
*/