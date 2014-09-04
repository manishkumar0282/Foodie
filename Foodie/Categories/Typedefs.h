//
//  Typedefs.h
//
//  Created by Manish Kumar - Imported on 11/26/12.
//
//


@class NTJSON;
typedef void (^JsonBlock) (NTJSON *json);

typedef void (^ImageBlock)(UIImage *image);
typedef void (^ErrorBlock)(NSError *error);
typedef void (^RequestBlock)(NSURLRequest *request);
typedef void (^DictionaryBlock)(NSDictionary *dictionary);
typedef void (^ArrayBlock)(NSArray *array);
typedef void (^DataBlock)(NSData *data);
typedef void (^ArrayIntBlock)(NSArray *array, NSInteger count);
typedef void (^VoidBlock)();
typedef void (^ViewControllerBlock)(UIViewController *);
typedef void (^StringBlock)(NSString *string);
typedef void (^UIntegerBlock)(NSUInteger uintValue);
typedef void (^IntegerBlock)(NSInteger intValue);
typedef void (^UnsignedLongLongBlock)(unsigned long long ullValue);
typedef void (^FloatBlock)(float floatValue);
typedef void (^NotificationBlock)(NSNotification * notification);
typedef void (^OperationBlock)(NSOperation *op);
typedef void (^UrlBlock)(NSURL *url);
typedef void (^BoolBlock)(BOOL boolValue);
typedef void (^PlacemarkBlock)(CLPlacemark *placemark);
typedef void (^IdBlock)(id);
typedef void (^IdIdBlock)(id, id);
typedef BOOL (^WhenBlock)(id);

void dispatch_operation_main(VoidBlock block);
void dispatch_sync_main(VoidBlock block);

void dispatch_async_main(VoidBlock block);
void dispatch_async_default(VoidBlock block);
void dispatch_async_high(VoidBlock block);
void dispatch_async_low(VoidBlock block);

void dispatch_after_main(NSInteger milliSecs, VoidBlock block);
void dispatch_after_default(NSInteger milliSecs, VoidBlock block);
void dispatch_after_low(NSInteger milliSecs, VoidBlock block);

void debugOnly(VoidBlock block);
bool debugENV(char *env);
bool ENV(char *env);

#ifndef NAVI
#define NAVI ENV("NAVI")
#endif

NSString *stringFromCGRect(CGRect rect);

#define CALLSTACK ({NSArray *callStack = [NSThread callStackSymbols];callStack;})
#define CALLEDBY ({NSArray *callStack = [NSThread callStackSymbols]; \
        NSString *caller; \
        if(callStack.count >= 2){ \
            caller = callStack[1]; \
            NSRange range = [caller rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"-+"]]; \
            if(!(range.location == NSNotFound)){ \
                caller = [caller substringFromIndex:range.location]; \
                range = [caller rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"+"]]; \
                if(!(range.location == NSNotFound)) \
                    caller = [caller substringToIndex:range.location]; \
            }\
        }caller; \
    })
