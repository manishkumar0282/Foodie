//
//  CALayer+Extras.m
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 8/5/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import "CALayer+Extras.h"

@implementation CALayer (Extras)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
