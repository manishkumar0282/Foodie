//
//  CPRestFailure.h
//  ChargePoint
//
//  Created by Sajid Khan on 2/13/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//


@interface CPRestFailure : NSObject
@property (nonatomic) NSURLRequest* request;
@property (nonatomic) NSHTTPURLResponse *response;
@property (nonatomic) NSError *error;
@property (nonatomic) id JSON;

-(id) initWithRequest:(NSURLRequest*) request response:(NSHTTPURLResponse*) response
              nserror:(NSError *) error json:(id) JSON;

@end
