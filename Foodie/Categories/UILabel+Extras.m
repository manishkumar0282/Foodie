//
//  UILabel+Extras.m
//  ChargePoint
//
//  Created by Navi Singh on 4/15/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#import "UILabel+Extras.h"

@implementation UILabel (Extras)

/**
 *   You might want to add a top and bottom inset to it.
 *   You need to make sure that you have the lineBreakMode set right.
 *   (this method has side effects in that it changes the
 *    numberOfLines and lineBreakMode properties.
 */
- (CGFloat)heightToFit
{
    //we do this to make sure we compute the right height.
    self.numberOfLines = 0;
    
    //You need to make sure that you have the lineBreakMode set right.
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize requiredSize = [self sizeThatFits:maxSize];
    return requiredSize.height;
}

/**
 *  You need to make sure that you have the lineBreakMode set right
 */
- (CGFloat)adjustBottomToFit
{
    return [self adjustBottomToFit:self.lineBreakMode];
}

- (CGFloat)adjustBottomToFit:(NSLineBreakMode)mode
{
    self.numberOfLines = 0;
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize textSize = [self.text sizeWithFont:self.font
                            constrainedToSize:maxSize
                                lineBreakMode:mode];
    
    CGRect labelRect = self.frame;
    labelRect.size.height = textSize.height;
    [self setFrame:labelRect];
    return labelRect.size.height;
}

- (CGFloat)adjustTopToFit
{
    return [self adjustTopToFit:self.lineBreakMode];
}

- (CGFloat)adjustTopToFit:(NSLineBreakMode)mode
{
    self.numberOfLines = 0;
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize textSize = [self.text sizeWithFont:self.font
                            constrainedToSize:maxSize
                                lineBreakMode:mode];
    
    CGRect labelRect = self.frame;
    labelRect.origin.y = self.frame.size.height - textSize.height;
    labelRect.size.height = textSize.height;
    [self setFrame:labelRect];
    return labelRect.size.height;
}

@end
