//
//  LeftFilterPanel.m
//  Foodie
//
//  Created by Manish Kumar on 9/15/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "LeftFilterPanel.h"

@implementation LeftFilterPanel
-(void)slideInFromLeft:(BoolBlock)completion
{
//    self.view.left = -self.view.width;
//    [UIView animateWithDuration:0.25
//                     animations:^{
//                         self.view.left = 0;
//                     }
//                     completion:completion];
}

+(UIStoryboard *)storyboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    return storyboard;
}

+(instancetype)instantiateFromStoryboard
{
    LeftFilterPanel *className = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftFilterPanel"];
    return className;
}
@end
