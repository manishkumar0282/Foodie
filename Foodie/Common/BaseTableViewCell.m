//
//  BaseTableViewCell.m
//  ChargePoint
//
//  Created by Manish Kumar on 12/04/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(CGFloat) heightForModel:(id) model
{
    return 0;
    //child to over ride
}

-(void)updateWithModel:(id)model
{
    //child to over ride
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        self.backgroundColor    =   [UIColor clearColor];
        
        if (IS_OS_7_OR_LATER) {
        }
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.contentView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentView.autoresizesSubviews=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString *)identifier{
    return NSStringFromClass([self class]);
}

-(CGFloat)heightForModel
{
    return 0;
    //child to over ride
}

-(void)layoutSubviews
{
    [self setBackgroundColor:[UIColor clearColor]];
}

//#pragma mark - Register for keyboard show hide events
//-(void)registerForKeyboardNotification
//{
//    id view = [self superview];
//    
//    while (view && [view isKindOfClass:[UITableView class]] == NO) {
//        view = [view superview];
//    }
//    
//    UITableView *tableView = (UITableView *)view;
//    
//    [[NSNotificationCenter defaultCenter] addObserver: tableView.delegate
//                                             selector: @selector(keyboardWillShow:)
//                                                 name: UIKeyboardWillShowNotification object:nil];
//    
//    //    [[NSNotificationCenter defaultCenter] addObserver: self
//    //                                             selector: @selector(keyboardDidShow:)
//    //                                                 name: UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver: tableView.delegate
//                                             selector: @selector(keyboardWillDisappear:)
//                                                 name: UIKeyboardWillHideNotification object:nil];
//    
//}
@end
