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
    }

    if ([locationManager isApplicationAuthorizedToUseLocationServices]) {
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

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
//    [locationManager stopUpdatingLocation];
    [super hideActivityIndicator];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation  *firstLocation  =   [locations lastObject];
    NSLogInfo(@"didUpdateToLocation: %@", firstLocation);
    
    [locationManager stopUpdatingLocation];

    NSString    *strLocation    =   [NSString stringWithFormat:@"%f, %f",firstLocation.coordinate.latitude, firstLocation.coordinate.longitude];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Location" message:strLocation delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [super hideActivityIndicator];
}

@end
