//
//  BaseTableViewCell.h
//  ChargePoint
//
//  Created by Manish Kumar on 12/04/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "CommonHeader.h"
@interface BaseTableViewCell : UITableViewCell
{
    CGFloat startXCoordinate;
    CGFloat startYCoordinate;
    CGFloat controlWidth;
    CGFloat controlHeight;
    CGRect  controlRect;
    CGFloat  permissibleWidth;
    CGFloat totalWidth;
    CGFloat totalHeight;
    CGSize  controlSize;
    UIFont  *font;
}

@property (nonatomic, strong) id tableCellDelegate;
@property (nonatomic, assign)   NSInteger   rowNumber;
+(NSString *)identifier;
//-(CGFloat)heightForModel;
-(CGFloat) heightForModel:(id) model;

#pragma mark - Register for keyboard show hide events
//-(void)registerForKeyboardNotification;
-(void)updateWithModel:(id)model;
@end
