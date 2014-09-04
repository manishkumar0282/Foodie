//
//  UINavigationController.m
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "UINavigationController+Extra.h"

@implementation UINavigationController (Extra)

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [[self.viewControllers lastObject] didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
