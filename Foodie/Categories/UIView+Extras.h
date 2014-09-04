//
//  UIView+Extras.h
//  ChargePoint
//
//  Created by Navi Singh on 4/15/14.
//  Copyright (c) 2014 Chargepoint Inc.  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extras)


/**
*  both left and x change origin.x
*/
@property (nonatomic) CGFloat x, left;

/**
 *  both top and y change origin.y
 */
@property (nonatomic) CGFloat y, top;

/**
 *  None of these properties change the size of the view.  They change just the position.
 */
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

/**
 *  change the frame.size.width or frame.size.height.
 */
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

/**
 *  change the dimensions to make the top/left/right/bottom fit.
  */
-(void)adjustRightTo:(CGFloat)right;
-(void)adjustLeftTo:(CGFloat)left;
-(void)adjustTopTo:(CGFloat)top;
-(void)adjustBottomTo:(CGFloat)bottom;
@end
