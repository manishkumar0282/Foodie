//
//  Webservice.m
//  ChargePoint
//
//  Created by Manish Kumar on 12/24/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "Webservice.h"
#import "CommonHeader.h"

#import "AFSecurityPolicy.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"

//#import "WebServiceStrings.h"
#import "CPRestFailure.h"
#import "TTTURLRequestFormatter.h"

typedef void (^AFResponseSuccess)(AFHTTPRequestOperation *, NSDictionary *);
typedef void (^AFResponseFailure)(AFHTTPRequestOperation *, NSError *);

@interface Webservice ()
@property   (nonatomic, strong) id operationDelegate;
@end

@implementation Webservice

-(void)terminateOperation:(NSOperation *)operation
{
//    [self cancel];
    [operation cancel];
    _operationDelegate = nil;
//    NSLogInfo(@"Connection Cancelled in %@",[self description]);
}

-(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest delegate:(id)delegate
{
    if (delegate == nil) {
        NSLogError(@"delegate is nil.");
    }
    
    return [self fetchJSONWithRequest:urlRequest delegate:delegate success:nil failure:nil];
}

-(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest
                            delegate:(id)opDelegate
                             success:(success)success
                             failure:(failure)failure
{
    self.operationDelegate = opDelegate;
 
    return [self.class fetchJSON:urlRequest
        success:^(AFHTTPRequestOperation *op, NSDictionary *JSON) {
            if (![op isCancelled])
            {
                __unused NSString   *str    =   (NSString *)JSON;

//                NSLogHTTP(@"JSON Response - %@",str);

                if ([opDelegate respondsToSelector:@selector(onItems:request:)]){
                    if ([JSON isKindOfClass:NSDictionary.class]){
                        [opDelegate performSelector:@selector(onItems:request:) withObject:JSON withObject:op.request];
                    }
                    else
                        [opDelegate performSelector:@selector(onItems:request:) withObject:nil withObject:op.request];
                    
                }
                else if ([opDelegate respondsToSelector:@selector(onItems:)])
                {
                    if ([JSON isKindOfClass:NSDictionary.class])
                        [opDelegate performSelector:@selector(onItems:) withObject:JSON];
                    else
                        [opDelegate performSelector:@selector(onItems:) withObject:nil];
                    
                }
                if (success) {
                    success (JSON);
                }
            }
        }
        failure:^(AFHTTPRequestOperation *op, NSError *error) {
            if (![op isCancelled])
            {
                if ([opDelegate respondsToSelector:@selector(onError:)])
                {
                    [opDelegate performSelector:@selector(onError:) withObject:error];
                }
                
                if (failure) {
                    failure([[CPRestFailure alloc] initWithRequest:urlRequest response:nil nserror:error json:nil]);
                }
                
                NSLog(@"error - %@", op.responseString);
            }
        }];
}

+(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest
                             success:(success) successBlock
                             failure:(failure) failureBlock
{
    return [self fetchJSON:urlRequest
        success:^(AFHTTPRequestOperation *op, NSDictionary *json) {
            if (![op isCancelled])
            {
                if (successBlock)
                    successBlock(json);
            }
        }
        failure:^(AFHTTPRequestOperation *op, NSError *error) {
            if (![op isCancelled])
            {
                if (failureBlock) {
                    failureBlock([[CPRestFailure alloc] initWithRequest:urlRequest response:nil nserror:error json:nil]);
                }
            }
        }];
}

+(NSOperation *)fetchJSON:(NSURLRequest *)urlRequest
                  success:(AFResponseSuccess) successBlock
                  failure:(AFResponseFailure) failureBlock
{
//    NSLogHTTP(@"URL is - %@",[[urlRequest URL] absoluteString]);
    AFHTTPRequestOperation *operation  = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializerWithReadingOptions:
                                            NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments];
    [serializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    operation.responseSerializer = serializer;
    
    //should this be in production code?
    //Change for production
#if !PROD_URL
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];    //test
    operation.securityPolicy = policy;
#endif
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, NSDictionary *JSON) {
        NSLogHTTP(@"%@", [JSON json]);
        NSString *strError  =   ((NSDictionary*)op.responseObject)[@"error"];
        
        NSRange cookieMismatchRange    =   [strError rangeOfString:@"unmatched cookie value found" options:NSCaseInsensitiveSearch];
        NSRange nullCookieValueFound    =   [strError rangeOfString:@"null cookie value found" options:NSCaseInsensitiveSearch];
        if (cookieMismatchRange.location == NSNotFound ||
            nullCookieValueFound.location == NSNotFound)
        {
            [Webservice fetchJSON:urlRequest
                          success:successBlock
                          failure:failureBlock];
        }
        else{
            if (successBlock)
                successBlock(op, JSON);
        }
        
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        if(error.code != NSURLErrorCancelled){//
            NSString *decodedCurlStr = [urlRequest curlDecoded];
            NSLogError(@"\n%@\n%@\n%@", decodedCurlStr, op.responseString, error);
        }
        if (failureBlock)
            failureBlock(op, error);
    }];
    
    [operation start];
    
    return operation;
}
@end
