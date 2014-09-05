//
//  CPBaseModel.h
//  ChargePoint
//
//  Created by Sajid Khan on 2/11/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//


@interface CPBaseModel : NSObject
+(instancetype) objectFromJSONObject:(NSDictionary *) dict;
@end
