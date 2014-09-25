//
//  BaseManager.m
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "BaseManager.h"

@implementation BaseManager

-(void)setDelegate:(id)senderDelegate
{
    if (managerDelegate != nil) {
        managerDelegate = nil;
    }
    
    managerDelegate =   senderDelegate;
}

-(void)cancelCurrentAction
{
    
}
@end
