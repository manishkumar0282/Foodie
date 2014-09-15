//
//  ActivityIndicator.h
//  ChargePoint
//
//  Created by Manish Kumar on 03/09/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//
@protocol ActivityIndicatorProtocol <NSObject>
-(void)cancelCurrentActivity;
@end

#import "CommonHeader.h"

@interface ActivityIndicator : UIView
{
    CGFloat tableHeight;
    id activityDelegate;
}
@property   (nonatomic, strong) UIButton                    *btnCancel;
@property   (nonatomic, strong) UIActivityIndicatorView     *activityIndicatorView;
@property   (nonatomic, strong) NSString                    *activityMessage;
@property   (nonatomic, strong) UILabel                    *lblMessage;
@property   (nonatomic, strong) NSNumber                    *isActionActivityToBeShown;
@property   (nonatomic, assign) BOOL                        isTextBlack;
-(void)finishedActivity;
-(void)startActivity;
-(void)setCpViewDelegate:(id)viewDel;
-(void)arrange;
-(id)cpViewDelegate;

@end
