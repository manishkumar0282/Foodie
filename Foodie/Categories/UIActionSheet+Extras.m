//
//  UIActionSheet+Extras.m
//  ChargePoint
//
//  Created by Manish Kumar on 13/08/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import "UIActionSheet+Extras.h"

@implementation UIActionSheet (Extras)

-(void)dismissWhenAppGoesToBackground:(NSNotification*)notificaiton{
    [self dismiss:YES];
    [self removeFromSuperview];
}

-(void)addObserverForAppStateChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dismissWhenAppGoesToBackground:)
                                                     name:kDismissWhenAppGoesToBackground
                                                   object:nil];
}
- (id)init{
    if (self = [super init]) {
        [self addObserverForAppStateChangeNotification];
    }
    return self;
}
@end
