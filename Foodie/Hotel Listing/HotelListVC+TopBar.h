//
//  HotelListVC+TopBar.h
//  Foodie
//
//  Created by Manish Kumar on 9/8/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HotelListVC.h"

@interface HotelListVC (TopBar)
-(void)topBarViewDidLoad;
-(void)topBarViewDidAppear:(BOOL)animated;
-(void)topBarViewDidDisappear:(BOOL)animated;
@end
