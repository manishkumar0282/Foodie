//
//  UIButton+Extras
//
//  Created by Navi Singh on 3/31/14.
//

@class NTJSON;

@interface UIButton (extras)

- (void)setImages:(id)images;

/**
 *  Position button text BELOW the icon and not to the right.
 *
 *  Make sure that the frame size is big enough to accomodate the text at the bottom.
 */
- (void)centerTextVerticallyWithPadding:(float)padding;
- (void)centerTextVertically;
-(void)setTextFieldStyleBorder;
@end
