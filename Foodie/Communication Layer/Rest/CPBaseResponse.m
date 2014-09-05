//
//  CPBaseResponse.m
//  ChargePoint
//
//  Created by Sajid Khan on 2/12/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#import "CPBaseResponse.h"
#import "CommonHeader.h"

@implementation CPBaseResponse

+(CPBaseResponse*) responseFromData:(NSDictionary *) dataDict key:(NSString *) key
{
    NSDictionary * object = [dataDict objectForKey:key];
    if (object) {
        CPBaseResponse* resp = [[CPBaseResponse alloc] init];
        resp.key = key;
        resp.success = [object[@"status"] intValue];
        resp.error = object[@"error"];
        resp.summaries = object[@"summaries"];
        return resp;
    }
    return nil;
}

@end
