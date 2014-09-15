//
//  HotelListVC.h
//  Foodie
//
//  Created by Manish Kumar on 9/8/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "BaseUIViewController.h"

@interface HotelListVC : BaseUIViewController
{
    LocationManager   *locationManager;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *locationUpdateActivity;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@end
