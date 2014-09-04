//
//  HomeVC+Map.m
//  Foodie
//
//  Created by Manish Kumar on 04/09/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HomeVC+Map.h"

@implementation HomeVC (Map)
- (IBAction)didTapMap:(id)sender {
    self.topSearchBar.text = @"";
    [self.topSearchBar resignFirstResponder];
}
@end
