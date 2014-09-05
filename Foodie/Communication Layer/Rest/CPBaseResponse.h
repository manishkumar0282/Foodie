//
//  CPBaseResponse.h
//  ChargePoint
//
//  Created by Sajid Khan on 2/12/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//


@interface CPBaseResponse : NSObject

@property (nonatomic) NSInteger success;
@property (nonatomic) NSString * error;
@property (nonatomic) id summaries;
@property (nonatomic) NSString * key;

+(CPBaseResponse*) responseFromData:(NSDictionary *) dataDict key:(NSString *) key;

@end
