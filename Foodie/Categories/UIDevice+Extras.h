//
//  UIDevice+Extras.h
//  ChargePoint
//
//  Created by Manish Kumar on 14/08/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extras)
+(NSMutableDictionary*)getMobileStatisticsToSubmit;
+(BOOL)isRunningOnDevice;
@end
