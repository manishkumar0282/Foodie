//
//  UIImage+Extras.h
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 4/23/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extras)

- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor;
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
@end
