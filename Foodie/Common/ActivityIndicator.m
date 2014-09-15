//
//  ActivityIndicator.m
//  ChargePoint
//
//  Created by Manish Kumar on 03/09/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "ActivityIndicator.h"

#define kCONST_ROW_HEIGHT   30

@implementation ActivityIndicator
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.alpha  =  0;
        self.backgroundColor    =   [UIColor clearColor];//colorWithPatternImage:[UIImage imageNamed:IMG_APPLICATION_BACKGROUND]];
        
        if (!self.lblMessage)
        {
            self.lblMessage =   [Utils createTextLabel:CGRectZero
                                                  text:@""
                                       backGroundColor:[UIColor clearColor]
                                             textColor:[UIColor whiteColor]
                                            isTextBold:NO
                                              fontSize:CONST_FONT_SIZE_FIFTEEN_POINTS];
            [self.lblMessage setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:self.lblMessage];
        }
        
        if (!self.activityIndicatorView) {
            self.activityIndicatorView  =   [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            self.activityIndicatorView.transform = CGAffineTransformMakeScale(2, 2);
            [self.activityIndicatorView setFrame:CGRectZero];
            [self addSubview:self.activityIndicatorView];
        }
        
        if (!self.btnCancel)
        {
            self.btnCancel  =   [Utils createButtonWithImageName:STR_BUTTON_TITLE_CANCEL
                                                  titleFontColor:[UIColor blackColor]
                                                   titleFontSize:CONST_FONT_SIZE_FOURTEEN_POINTS
                                                       imageName:[UIImage imageNamed:IMG_BUTTON_BACKGROUND]
                                                            rect:CGRectZero
                                                        delegate:self
                                                    actionMethod:@selector(cancelCurrentActivity:)];
//            [self.btnCancel setBackgroundImage:[UIImage imageNamed:IMG_ACTIVATE_CARD_ADD] forState:UIControlStateNormal];
            [self addSubview:self.btnCancel];
        }
    }
    return self;
}

-(void)setCpViewDelegate:(id)viewDel
{
    activityDelegate    =   viewDel;
}
-(id)cpViewDelegate
{
    return activityDelegate;
}
-(void)arrange
{
    CGSize  controlSize         =   CGSizeZero;
    CGFloat viewWidth           =   self.frame.size.width;
    CGFloat viewHeight          =   self.frame.size.height;
    CGFloat controlWidth        =   CGFLOAT_MIN;
    CGFloat controlHeight       =   CGFLOAT_MIN      ;
    CGFloat startXCoordinate    =   CGFLOAT_MIN;
    CGFloat startYCoordinate    =   CGFLOAT_MIN;
    CGRect  controlRect         =   CGRectZero;
    
    if (self.activityMessage.length > 0)
    {
        controlSize =   [Utils calculateLabelSize:self.activityMessage
                                       labelWidth:viewWidth
                                         fontSize:CONST_FONT_SIZE_FIFTEEN_POINTS];
        controlWidth    =   controlSize.width;
        controlHeight   =   controlSize.height;
        startXCoordinate    =   (viewWidth - controlWidth) / 2;
        startYCoordinate    =   (viewHeight - controlHeight) / 2;
        controlRect =   CGRectMake(startXCoordinate, startYCoordinate, controlWidth, controlHeight);
        [self.lblMessage setText:self.activityMessage];
        if (self.isTextBlack) {
            [self.lblMessage setTextColor:[UIColor blackColor]];
        }

        [self.lblMessage setFrame:controlRect];
        
        startYCoordinate    -=  3*CONST_DEFAULT_PADDING;
        startXCoordinate    =   (viewWidth - CONST_DEFAULT_PADDING) /2;
        controlWidth        =   CONST_DEFAULT_PADDING;
        controlHeight       =   CONST_DEFAULT_PADDING;
        controlRect =   CGRectMake(startXCoordinate, startYCoordinate, controlWidth, controlHeight);
        [self.activityIndicatorView setFrame:controlRect];
    }
    else
    {
        self.activityIndicatorView.center   =   self.center;
    }    
    
    if (self.isActionActivityToBeShown.boolValue)
    {
        if (self.btnCancel)
        {
            self.backgroundColor = [UIColor lightTextColor];
            self.lblMessage.textColor = [UIColor blackColor];
            self.activityIndicatorView.color = [UIColor whiteColor];
//            self.alpha  =   0.5;
            controlSize         =   [Utils calcualteButtonSizeWithText:STR_BUTTON_TITLE_CANCEL
                                                              fontSize:CONST_FONT_SIZE_FOURTEEN_POINTS];
//            [Utils calculateLabelSize:STR_BUTTON_TITLE_CANCEL
//                           labelWidth:viewWidth
//                             fontSize:CONST_FONT_SIZE_FOURTEEN_POINTS];
            controlWidth        =   controlSize.width + CONST_DEFAULT_PADDING;
            controlHeight       =   controlSize.height + CONST_DEFAULT_PADDING;
            startXCoordinate    =   (viewWidth - controlWidth) / 2;
            startYCoordinate    =   self.lblMessage.frame.origin.y + self.lblMessage.frame.size.height + CONST_DEFAULT_PADDING;
            
            controlRect         =   CGRectMake(startXCoordinate, startYCoordinate, controlWidth, controlHeight);
            [self.btnCancel setFrame:controlRect];
        }
    }
}

#pragma mark - action methods
-(void)cancelCurrentActivity:(id)sender
{
    if (activityDelegate && [activityDelegate conformsToProtocol:@protocol(ActivityIndicatorProtocol)])
    {
        [activityDelegate performSelector:@selector(cancelCurrentActivity)];
    }
}

-(void)startActivity
{
    [self.activityIndicatorView startAnimating];
}

-(void)finishedActivity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        [self.activityIndicatorView removeFromSuperview];
    });
}

@end