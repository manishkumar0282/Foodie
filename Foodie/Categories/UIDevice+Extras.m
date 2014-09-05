//
//  UIDevice+Extras.m
//  ChargePoint
//
//  Created by Manish Kumar on 14/08/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import "UIDevice+Extras.h"

@implementation UIDevice (Extras)
+(NSMutableDictionary*)getMobileStatisticsToSubmit{
    
    NSMutableDictionary *mobileAnalyticsData    =   [NSMutableDictionary new];
    mobileAnalyticsData[@"device_os_version"]   =   [[UIDevice currentDevice] systemVersion];   //4.0
    mobileAnalyticsData[@"device_os_type"]      =   [[UIDevice currentDevice] systemName];         //ios
    mobileAnalyticsData[@"device_type"]         =   [[UIDevice currentDevice] model];           //iPhone / iPad / iPode touch
    //[[UIDevice currentDevice] platformString];  //ex: @"iPhone 4G" from erica' category on UIDevice-Hardware
    mobileAnalyticsData[@"device_UUID"]         =   [[[UIDevice currentDevice] identifierForVendor] UUIDString];    //vendor
    mobileAnalyticsData[@"device_model"]        =   [[UIDevice currentDevice] model];           //iPhone / iPad / iPode touch
    mobileAnalyticsData[@"device_manufacturer"]        =   @"Apple";
    
    //app specific data
    mobileAnalyticsData[@"current_mobile_app_version"] =   [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];    //app version
    return mobileAnalyticsData;
}

+(BOOL)isRunningOnDevice{
#if (TARGET_IPHONE_SIMULATOR)
    return NO;
#endif
    return YES;
}
@end
