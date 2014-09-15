//
//  AddHotelVC.m
//  Foodie
//
//  Created by Manish Kumar on 9/9/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "AddHotelVC.h"

@implementation AddHotelVC
+(UIStoryboard *)storyboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    return storyboard;
}

+(instancetype)instantiateFromStoryboard
{
    AddHotelVC *className = [self.storyboard instantiateViewControllerWithIdentifier:@"AddHotelVC"];
    return className;
}
- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)didTapSave:(id)sender {
    [UIAlertView showWithMessage:@"To be implemented"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
