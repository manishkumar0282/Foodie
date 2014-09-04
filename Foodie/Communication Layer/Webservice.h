//
//  Webservice.h
//  ChargePoint
//
//  Created by Manish Kumar on 12/24/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//


@interface Webservice : NSObject

-(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest
                                       delegate:(id)opDelegate;

-(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest
                            delegate:(id)opDelegate
                             success:(success)success
                             failure:(failure) failure;

-(void)terminateOperation:(NSOperation *)operation;

+(NSOperation *)fetchJSONWithRequest:(NSURLRequest *)urlRequest
                             success:(success) successBlock
                             failure:(failure) failureBlock;

@end
