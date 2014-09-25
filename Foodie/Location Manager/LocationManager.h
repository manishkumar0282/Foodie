//
//  LocationManager.h
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

@protocol LocationManagerProtocol <NSObject>

@optional
-(void)onGetLocationFromAddress:(CLPlacemark*)placemark;
-(void)onGetAddressFromLocation:(CLPlacemark*)placemark;
-(void)didUpdateToLocation:(CLLocation*)location;
-(void)onParsingUserPlacemark;

@required
-(void)locationServicesNotEnabled;
-(void)applicationNotAllowedToUseLocationServices;
@end

#import "BaseManager.h"
@interface LocationManager : BaseManager 
{
    CLLocationManager               *locationManager;
    BOOL                            isLocationDelegateAlreadyNotified;
}

@property (nonatomic) CLLocationCoordinate2D location;
@property(nonatomic, strong)CLGeocoder *geocoder;
@property(nonatomic, strong)CLPlacemark *placemark;
@property(nonatomic)    BOOL isLocationServicesEnabled;
@property(nonatomic)    BOOL isApplicationAuthorizedToUseLocationServices;

@property   (nonatomic, strong) CLPlacemark *reverseGeocodedPlacemark;

@property   (nonatomic, strong) CLLocation  *reverseGeocodedPlacemarkLocation;
//location  property
//Accessing the Placemark Attributes
@property   (nonatomic, strong) NSString  *name;
//name  property
@property   (nonatomic, strong) NSDictionary *addressDictionary;
//addressDictionary  property
@property   (nonatomic, strong) NSString  *ISOcountryCode;
//ISOcountryCode  property
@property   (nonatomic, strong) NSString  *country;
//country  property
@property   (nonatomic, strong) NSString  *postalCode;
//postalCode  property
@property   (nonatomic, strong) NSString  *administrativeArea;
//administrativeArea  property
@property   (nonatomic, strong) NSString  *subAdministrativeArea;
//subAdministrativeArea  property
@property   (nonatomic, strong) NSString  *locality;
//locality  property
@property   (nonatomic, strong) NSString  *subLocality;
//subLocality  property
@property   (nonatomic, strong) NSString  *thoroughfare;
//thoroughfare  property
@property   (nonatomic, strong) NSString  *subThoroughfare;
//subThoroughfare  property
@property   (nonatomic, strong) CLRegion  *region;
//region  property

@property   (nonatomic, strong) CLLocation  *lastKnownLocation;

//+(void)authorize:(VoidBlock)completion;

-(BOOL)isLocationServicesAllowed;
-(void)getLocationFromAddress:(NSString *)address;
-(void)getLocationFromAddress:(NSString *)address completion:(PlacemarkBlock)block;
-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;
-(CLLocationCoordinate2D)getCurrentLocation;
-(void)clearSharedInstance;

+(LocationManager *)sharedInstance;

#pragma mark - Address from location
-(void)getAddressFromLocation:(CLLocation*)savedLocation;
-(void)getAddressFromLocation:(CLLocation*)savedLocation completion:(PlacemarkBlock)block;

-(BOOL)isAppAllowedToUseLocation;
-(void)startMonitoringLocationAggressively;
-(void)stopMonitoringLocationAggressively;
@end
