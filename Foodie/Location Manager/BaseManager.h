//
//  BaseManager.h
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "CommonHeader.h"
//#import "JsonTags.h"
//#import "WebServiceStrings.h"
//#import "HTTPRequest.h"


@interface BaseManager : NSObject
{
    id  managerDelegate;
}

-(void)setDelegate:(id)senderDelegate;
-(void)cancelCurrentAction;
@end
