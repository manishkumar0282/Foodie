//
//  CPRestFailure.m
//  ChargePoint
//
//  Created by Sajid Khan on 2/13/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#import "CPRestFailure.h"

@implementation CPRestFailure

-(id) initWithRequest:(NSURLRequest*) request response:(NSHTTPURLResponse*) response
              nserror:(NSError *) error json:(id) JSON
{
    self = [super init];
    if (self) {
        self.request = request;
        self.response = response;
        self.error = error;
        self.JSON = JSON;
    }
    return self;
}


@end
