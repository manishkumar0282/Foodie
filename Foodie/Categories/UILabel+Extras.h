//
//  UILabel+Extras.h
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 4/15/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extras)

/**
 *   You might want to add a top and bottom inset to it.
 *   You need to make sure that you have the lineBreakMode set right.
 *   (this method has side effects in that it changes the
 *    numberOfLines and lineBreakMode properties.
 */
- (CGFloat)heightToFit;

/**
 *  adjust height leaving origin and width unchanged.
 */
- (CGFloat)adjustBottomToFit;
- (CGFloat)adjustBottomToFit:(NSLineBreakMode)mode;

/**
 *  adjust height and origin leaving and width unchanged.
 *  i.e. the bottom remains where it was.
 */
- (CGFloat)adjustTopToFit;
- (CGFloat)adjustTopToFit:(NSLineBreakMode)mode;


@end
