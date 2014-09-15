//
//  HotelListVC+LocationUpdate.h
//  Foodie
//
//  Created by Manish Kumar on 9/9/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HotelListVC.h"
#import <CoreLocation/CoreLocation.h>
@interface HotelListVC (LocationUpdate) <CLLocationManagerDelegate>
-(void)locationUpdateDidLoad;
-(void)locationUpdateDidAppear:(BOOL)animated;
-(void)locationUpdateDidDisappear:(BOOL)animated;
@end
