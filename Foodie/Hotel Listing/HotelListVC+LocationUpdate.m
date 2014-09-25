//
//  HotelListVC+LocationUpdate.m
//  Foodie
//
//  Created by Manish Kumar on 9/9/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HotelListVC+LocationUpdate.h"

@implementation HotelListVC (LocationUpdate)
-(void)locationUpdateDidLoad{
    if (!locationManager) {
        locationManager    =   [LocationManager sharedInstance];
        [locationManager setDelegate:self];
    }

    if ([locationManager isLocationServicesAllowed]) {
        [super showActivityIndicator:[UIColor whiteColor]
                         isTextBlack:YES
                        activityText:NSLocalizedString(@"We are locating you...", nil)
                    showCancelButton:NO
                    activityDelegate:nil];

        [locationManager startUpdatingLocation];
    }
    else{
        [UIAlertView showWithMessage:NSLocalizedString(@"Location services are disabled. Please enable location services by going to Settings -> Location Services.", nil)];
    }
}

-(void)locationUpdateDidAppear:(BOOL)animated{
}

-(void)locationUpdateDidDisappear:(BOOL)animated{

}

#pragma mark - CLLocationManagerDelegate
-(void)didUpdateToLocation:(CLLocation*)location{
    NSString    *strLocation    =   [NSString stringWithFormat:@"%f, %f",location.coordinate.latitude, location.coordinate.longitude];
    dispatch_async(dispatch_queue_create("searchForAddress", NULL), ^{
        //search
        [locationManager getAddressFromLocation:location completion:^(CLPlacemark *placemark){
            if (placemark) {
//                //save address for future references
//                UIAlertView *errorAlert = [[UIAlertView alloc]
//                                           initWithTitle:@"address" message:locationManager.fir delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [errorAlert show];
            }
        }];
    });
    [super hideActivityIndicator];
}

-(void)onParsingUserPlacemark{
    //save address for future references
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"address" message:locationManager.locality delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];

}
-(void)onGetAddressFromLocation:(CLPlacemark*)placemark{
    
}
@end
