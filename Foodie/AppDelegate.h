//
//  AppDelegate.h
//  Foodie
//
//  Created by Manish Kumar on 04/09/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//
@class NTAssetJSON;
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NTAssetJSON *assets;
@end
#define theAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
//#define theHomeVC (((AppDelegate *)[[UIApplication sharedApplication] delegate]).homeVC)