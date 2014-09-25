//
//  LocationManager.m
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "LocationManager.h"
@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, copy)VoidBlock completion;
@end

@implementation LocationManager

static LocationManager  *locationManagerInstance;

-(LocationManager*)init
{
    if (self = [super init])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if( [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] )
        {
            [locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

+(LocationManager *)sharedInstance
{
//    static LocationManager  *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [LocationManager new];
//    });
//    return instance;
	@synchronized(self)
	{
		if (locationManagerInstance == nil)
		{
			locationManagerInstance = [[LocationManager alloc]init];
		}
	}
	
	return locationManagerInstance;
}

-(void)startMonitoringLocationAggressively{
//    self.keepOnMonitoring   =   YES;
    [self monitorLocationAggressively];
}
-(void)stopMonitoringLocationAggressively{
//    self.keepOnMonitoring   =   NO;
    [locationManager stopMonitoringSignificantLocationChanges];
}

-(void)monitorLocationAggressively{
    if ([self isLocationServicesAllowed]) {
        [locationManager startMonitoringSignificantLocationChanges];
//        if (self.checkAckTimer)
//        {
//            [self.checkAckTimer invalidate];
//            self.checkAckTimer  =   nil;
//        }
//        
//        if (self.keepOnMonitoring) {
//            self.checkAckTimer  =   [NSTimer scheduledTimerWithTimeInterval:CONST_TIME_INTERVAL_TO_PING_FOR_ACK
//                                                                     target:self
//                                                                   selector:@selector(startUpdatingLocation)
//                                                                   userInfo:nil
//                                                                    repeats:NO];
//        }
    }
}

-(void)clearSharedInstance
{
    locationManagerInstance = nil;
}

+(void)authorize:(VoidBlock)completion
{
    self.sharedInstance.completion = completion;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    [theAppDelegate.homeVC locationManagerDidChangeAuthorizationStatus:status];
    if (status >= kCLAuthorizationStatusAuthorized) {
        if (self.completion) {
            self.completion();
        }
    }
}

-(BOOL)isAppAllowedToUseLocation
{
    if( [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)] )
    {
        [locationManager requestWhenInUseAuthorization];
    }
    BOOL    isEnabled       =   NO;
    BOOL    isAppAuthorized    =   NO;

    if ([CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized)
    {
        isAppAuthorized   =   YES;
    }
    if ([CLLocationManager locationServicesEnabled])
    {
        isEnabled = YES;
    }

    BOOL isAllowed =   (isAppAuthorized && isEnabled);
    return isAllowed;
}

-(BOOL)isLocationServicesAllowed
{
    BOOL    isEnabled       =   NO;
    BOOL    isAppAuthorized    =   NO;
    
    if ([CLLocationManager authorizationStatus] >= kCLAuthorizationStatusAuthorized)
    {
        isAppAuthorized   =   YES;
        self.isApplicationAuthorizedToUseLocationServices   =   YES;
    }
    if ([CLLocationManager locationServicesEnabled])
    {
        isEnabled = YES;
        self.isLocationServicesEnabled  =   YES;
    }
    
    if (!isEnabled || !isAppAuthorized)
    {
        //alert for not authorized
        if (managerDelegate != nil && [managerDelegate respondsToSelector:@selector(applicationNotAllowedToUseLocationServices)])
        {
            [managerDelegate performSelector:@selector(applicationNotAllowedToUseLocationServices)];
        }
    }
    
    BOOL isAllowed =   (isAppAuthorized && isEnabled);
    return isAllowed;
}
//-------------------------------------------------------------------------
// Method:			startUpdatingLocation
//
// Description:		Starts updating location
//
// Parameter:
//-------------------------------------------------------------------------
-(void)startUpdatingLocation
{
    isLocationDelegateAlreadyNotified   =   NO;
    NSLogInfo(@"startUpdatingLocation called for %@",[managerDelegate description]);
	[locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (!isLocationDelegateAlreadyNotified)
    {
        CLLocation  *firstLocation  =   [locations lastObject];
    
        self.lastKnownLocation  =   firstLocation;    //assign the location

        self.location = firstLocation.coordinate;

        [Utils saveLocationInUserDefaultsAsLastKnownCurrentLocation:self.location];
    
    
        isLocationDelegateAlreadyNotified   =   !isLocationDelegateAlreadyNotified;
        
        if (managerDelegate != nil && [managerDelegate conformsToProtocol:@protocol(LocationManagerProtocol)])
        {
            NSLog(@"Location manager delegate is - %@",[managerDelegate description]);
            
            if (!(firstLocation.coordinate.latitude == 0 && firstLocation.coordinate.longitude == 0)){
                [managerDelegate performSelector:@selector(didUpdateToLocation:)
                                      withObject:firstLocation
                 afterDelay:1];
            }
        }
        NSLogInfo(@"location found");
        //reverse geocode to generate the clplacemark
        [self convertLocationToAddressForLocation:firstLocation];
    }
    
//    [self stopUpdatingLocation];
        [self performSelectorOnMainThread:@selector(stopUpdatingLocation) withObject:nil waitUntilDone:YES];
}
#pragma mark -
#pragma mark Location Manager Delegates
//-------------------------------------------------------------------------
// Method:			didUpdateToLocation
//
// Description:		Set current location object ,just zoom to that location and set Zoom level using Span.
//
// Parameter:		CLLocationManager :manager
//					CLLocation		  :newLocation
//					CLLocation		  :oldLocation
//-------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    self.location = newLocation.coordinate;

    self.lastKnownLocation  =   newLocation;    //assign the location
    
    [Utils saveLocationInUserDefaultsAsLastKnownCurrentLocation:self.location];
    
    if (!isLocationDelegateAlreadyNotified)
    {
        isLocationDelegateAlreadyNotified   =   !isLocationDelegateAlreadyNotified;
        
        if (!(newLocation.coordinate.latitude == 0 && newLocation.coordinate.longitude == 0))
        {
            [locationManager stopUpdatingLocation];
            
            if ([managerDelegate respondsToSelector:@selector(didUpdateToLocation:)])
            {
                NSLog(@"Location manager delegate is - %@",[managerDelegate description]);
                [managerDelegate performSelector:@selector(didUpdateToLocation:) withObject:newLocation];
            }
            
            //reverse geocode to generate the clplacemark
            [self convertLocationToAddressForLocation:newLocation];
            
//            if (managerDelegate != nil && [managerDelegate respondsToSelector:@selector(didUpdateToLocation:)])
//            {
//                NSLog(@"Location manager delegate is - %@",[managerDelegate description]);
//                [managerDelegate performSelector:@selector(didUpdateToLocation:) withObject:newLocation];
//            }
        }
    }
    
//    [self stopUpdatingLocation];
        [self performSelectorOnMainThread:@selector(stopUpdatingLocation) withObject:nil waitUntilDone:YES];
    NSLogInfo(@"Current Location----- latitude: %f, longitude: %f", self.location.latitude, self.location.longitude);
}

//-------------------------------------------------------------------------
// Method:			didFailWithError
//
// Description:		Called when location update fails
//
// Parameter:		CLLocationManager :manager
//					NSError			  :error
//-------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLogError(@"[LocationManager didFailWithError]........Failed to update location");
    NSLog(@"LocalizedDescription - %@",error.localizedDescription);
	if (managerDelegate != nil && [managerDelegate respondsToSelector:@selector(locationUpdateFailed:)])
	{
        NSLog(@"Location manager delegate is - %@",[managerDelegate description]);
		[managerDelegate performSelector:@selector(locationUpdateFailed:) withObject:error];
	}
	[self stopUpdatingLocation];
}

//-------------------------------------------------------------------------
// Method:			stopUpdatingLocation
//
// Description:		Stops updating location
//
// Parameter:
//-------------------------------------------------------------------------
-(void)stopUpdatingLocation
{
	[locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark Class Methods
//-------------------------------------------------------------------------
// Method:			getCurrentLocation
//
// Description:		To get current location
//
// Parameter:
//-------------------------------------------------------------------------
-(CLLocationCoordinate2D)getCurrentLocation
{
    double savedLatitude   =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LATITUDE] doubleValue];
    double savedLongitude   =   [[[NSUserDefaults standardUserDefaults] objectForKey:CONST_KEY_SAVED_LONGITUDE] doubleValue];
    
    CLLocationCoordinate2D lastKnownCurrentLocation =   CLLocationCoordinate2DMake(savedLatitude, savedLongitude);
    return lastKnownCurrentLocation;
//	return location;
}

//-------------------------------------------------------------------------
// Method:			getCurrentLocation
//
// Description:		To get current location
//
// Parameter:
//-------------------------------------------------------------------------
-(void)setCurrentLocation:(CLLocationCoordinate2D)currentLoc
{
	self.location = currentLoc;
}

-(void)getLocationFromAddress:(NSString *)address
{
    [self getLocationFromAddress:address completion:nil];
}

-(void)getLocationFromAddress:(NSString *)address completion:(PlacemarkBlock)block
{
    NSLogInfo(@"Locate location for address %@", address);
    
    self.geocoder = [[CLGeocoder alloc] init];
    [self.geocoder geocodeAddressString:address
                      completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (placemarks.count) {
             self.placemark = (CLPlacemark*)[placemarks objectAtIndex:0];
             if (block) {
                 block(self.placemark);
             }
             [[NSNotificationCenter defaultCenter] postNotificationName:kGotLocation object:self userInfo:@{@"placemark" : self.placemark}];
         }
         else if(block){
             block(nil);
         }
         
         if ([managerDelegate respondsToSelector:@selector(onGetLocationFromAddress:)])
         {
             [managerDelegate performSelector:@selector(onGetLocationFromAddress:)
                                   withObject:self.placemark];
         }
     }];
}

#pragma mark - Address from location
-(void)getAddressFromLocation:(CLLocation*)savedLocation
{
    [self getAddressFromLocation:savedLocation completion:nil];
}
-(void)getAddressFromLocation:(CLLocation*)savedLocation completion:(PlacemarkBlock)block
{
    NSLogInfo(@"%s for lat=%f, lon = %f", __FUNCTION__,savedLocation.coordinate.latitude, savedLocation.coordinate.longitude);
    self.geocoder   =   [[CLGeocoder alloc] init];
    [self.geocoder reverseGeocodeLocation:savedLocation
                        completionHandler:^(NSArray *placemarks, NSError *error)
     {
        NSLogInfo(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
        
        if (error){
            NSLogError(@"Error while getting address from saved location %@",[error localizedDescription]);
            if ([managerDelegate respondsToSelector:@selector(onError:)])
            {
                [managerDelegate performSelector:@selector(onError:)
                                      withObject:error];
            }
        }
        if(placemarks && placemarks.count > 0)
        {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            
            if (block) {
                self.placemark = topResult;
                block(self.placemark);
                [[NSNotificationCenter defaultCenter] postNotificationName:kGotLocation object:self userInfo:@{@"placemark" : self.placemark}];
            }
            //save reverse geocoded placemark
            self.reverseGeocodedPlacemark   =   topResult;
            [self formatUserAddressBasedOnPlacemark:topResult];
            if (managerDelegate != nil)
            {
                if ([managerDelegate conformsToProtocol:@protocol(LocationManagerProtocol)])
                {
                    [managerDelegate performSelector:@selector(onGetAddressFromLocation:)
                                          withObject:topResult];
                }
            }
        }
    }];
}

-(void)convertLocationToAddressForLocation:(CLLocation*)fetchedLocation
{
    NSLogInfo(@"%s for lat=%f, lon = %f", __FUNCTION__,fetchedLocation.coordinate.latitude, fetchedLocation.coordinate.longitude);
    self.geocoder   =   [[CLGeocoder alloc] init];
    [self.geocoder reverseGeocodeLocation:fetchedLocation
                        completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLogInfo(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
         
         if (error){
             NSLogInfo(@"Error while getting address from saved location %@",[error localizedDescription]);
         }
         if(placemarks && placemarks.count > 0)
         {
             //do something
             CLPlacemark *topResult = [placemarks objectAtIndex:0];
             
             //save reverse geocoded placemark
             self.reverseGeocodedPlacemark   =   topResult;
             [self formatUserAddressBasedOnPlacemark:topResult];
         }
     }];
}

-(void)formatUserAddressBasedOnPlacemark:(CLPlacemark*)updatedPlacemark
{
    self.locality   =   [updatedPlacemark locality];
    self.addressDictionary  =   [updatedPlacemark addressDictionary];
    self.ISOcountryCode =   [updatedPlacemark ISOcountryCode];
    self.country    =   [updatedPlacemark country];
    self.name  =    [updatedPlacemark name];
    self.postalCode    =    [updatedPlacemark postalCode];
    self.administrativeArea    =    [updatedPlacemark administrativeArea];
    self.subAdministrativeArea    =    [updatedPlacemark subAdministrativeArea];
    self.locality    =    [updatedPlacemark locality];
    self.subLocality    =    [updatedPlacemark subLocality];
    self.thoroughfare    =    [updatedPlacemark thoroughfare];
    self.subThoroughfare    =    [updatedPlacemark subThoroughfare];
    self.region    =    [updatedPlacemark region];
    
    
#pragma mark - onParsingUserPlacemark
    if (managerDelegate != nil)
    {
        if ([managerDelegate conformsToProtocol:@protocol(LocationManagerProtocol)])
        {
            [managerDelegate performSelector:@selector(onParsingUserPlacemark)
                                  withObject:nil];
        }
    }
}
@end
