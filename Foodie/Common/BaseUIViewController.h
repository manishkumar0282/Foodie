//
//  BaseUIViewController.h
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "CommonHeader.h"
//#import "CommonContentManager.h"
//#import "CustomNavigationBarView.h"
//#import "ExceptionHandlingView.h"
//#import "AddMyPlacesView.h"
//#import "AddDriverTipView.h"
#import "ActivityIndicator.h"
//#import "AddDriverTipVCViewController.h"
@class LegacyScrollableAdvanceFilterView;
@class LegacyMenuView;
//#import "GAITrackedViewController.h"
@interface BaseUIViewController : UIViewController <ActivityIndicatorProtocol>//GAITrackedViewController
{
    CGFloat viewWidth;
    CGFloat viewHeight;
//    CommonContentManager    *commonContentManager;
//    CustomNavigationBarView *customNavigationBarView;
//    UIImageView *iViewGradient;
    UIAlertView *av;
}
//@property (assign)            BOOL                                isViewAlreadyAdjustedForKeyboardPresence;
//@property (nonatomic, strong) UILabel                             *labHalfTone;
//@property (nonatomic, strong) NSNumber                            *isUserLocationMandatoryToProceed;
//@property (nonatomic, strong) AddMyPlacesView                     *addEditPlaces;
//@property (nonatomic, strong) LegacyMenuView                            *menuView;
//@property (nonatomic, strong) NSNumber                            *parentViewControllerTag;
@property (nonatomic, strong) ActivityIndicator                   *activityIndicator;
//@property (nonatomic, strong) ScrollableAdvanceFilterView         *scrollableAdvanceFilterView;
//@property (nonatomic, strong) UIViewController                    *menuViewController;
//@property (nonatomic, strong) UIActionSheet                       *reportActionSheet;
//@property (nonatomic, strong) AddDriverTipView                    *addDriverTipView;
//@property (nonatomic, strong) AddDriverTipVCViewController        *addDriverTipVc;
//@property (nonatomic, strong) UILabel                             *labStatus;
@property (nonatomic, weak)   id senderViewController;
//@property (assign)            BOOL                                isOtherOrientationSupported;


//-(void)showAddEditView;
//-(void)prepareUI;
//-(void)setViewHeightWidth;
//
//
//-(float)getViewModeCenterX;
//-(float)getViewModeCenterXOffset;
//
//-(float)getViewModeCenterY;
//-(float)getViewModeCenterYOffset;

#pragma mark - Activity indicator
-(void)showActivityIndicator:(UIColor*)activityColor
                 isTextBlack:(BOOL)isTextBlack
                activityText:(NSString *)activityText
            showCancelButton:(BOOL)showCancelButton
            activityDelegate:(id)activityDelegate;

-(void)showActivityIndicatorWithParameter:(NSDictionary *)paramDict
                         activityDelegate:(id)activityDelegate;

-(void)hideActivityIndicator;

#pragma mark - Advance Filter
//-(void)initializeScrollableFilterListView;
//-(void)initializeScrollableFilterListView:(BOOL)addNub;
//
////-(void)initializeAdvanceFilterListView;
//#pragma mark - exception View
//-(void)showLocationServiceExceptionHandlingView:(BOOL)isAuthorized
//                                   updateFailed:(BOOL)updateFailed;
//-(void)showExceptionViewControllerForClass:(NSString *)className
//                              functionName:(NSString *)functionName
//                                 exception:(NSException*)exception;
//-(void)showExceptionViewControllerForSubView:(NSMutableDictionary*)exceptionDictionary;
//
//#pragma mark - Menu View
//-(void)addMenuAnchorView;
//-(void)replaceImageForMenuAnchorWithImageName:(int)menuTag;
//-(void)setMenuAnchorImage:(id)sender;
//
//#pragma mark - Called by subview once it finishes loading
////-(void)finishedLoadingSubview:(UIView*)subview;
//
//#pragma mark - Get Direction
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation
//              destinationTitle:(NSString *)destinationTitle;
//
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation;
//
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation
//            destinationAddress:(NSDictionary *)destinationAddress;
//
//#pragma mark - callback for close add/edit places
////-(void)closeAddEditView;
////-(void)performAdditionalActivityOnClosingAddPlace;
//
//
//#pragma mark - new advance filter
////-(void)showAdvanceFilterListView:(id)sender;
//
//-(void)hideDropdown:(id)sender;
//
//-(void)showMenuView:(id)sender;
//
//-(void)hideScrollableFilterListView:(id)sender;
//
//-(void)addNavigationGradient;
//
//#pragma mark - edit my places
//-(void)getAddressFromLocation:(id)sender;
//-(void)showScrollableFilterListView:(id)sender;
//-(void)showAddEditViewWithAddress:(NSString *)spotAddress;
//-(void)showAddEditViewWithAddress:(NSString *)spotAddress
//                     spotLocation:(CLLocation*)spotLocation;
//#pragma mark - setBackgroundImageForEntireView
//-(void)setBackgroundImageForEntireView:(NSString *)bgImgName;
//
//-(void)showDetailsForStationAnnotation:(id)selectedAnnotation;
//
//-(void)initializeScreenControls;
//
//#pragma mark - Animated Push Pop of viewControllers
//-(void)pushViewController:(id)viewController;
//-(void)popViewController:(id)viewController;
//
//#pragma mark - Report Station Action Sheet
////-(void)showReportStationOptions;
////-(void)showOptionsWithStationInfo:(StationData*)stationInfo buttonIndex:(NSInteger)buttonIndex buttonTitle:(NSString *)buttonTitle;
//
//
//#pragma mark - Share
////-(void)displayShareOptions:(StationData*)stationInfo;
//
//#pragma mark - button action methods
//-(void)gotoPreviousScreen:(id)sender;
//
//-(void)locationUpdateFailed:(NSError*)error;
//
//#pragma mark - gotoViewControllerWithClassName: sender:
//-(void)gotoViewControllerWithClassName:(NSString *)destinationController;
//-(void)checkAndPopOrPushToViewController:(NSString *)destinationViewController;
//-(void)gotoViewControllerWithClassName:(NSString *)destinationController sender:(id)sender;
//
//#pragma mark - Register for keyboard show hide events
//-(void)registerForKeyboardNotification;
//- (NSTimeInterval) keyboardAnimationDurationForNotification:(NSNotification*)notification;
//
//#pragma mark - In App Prompt
//-(void)checkForinAppPrompt:(NSArray*)promptCategory;
//-(void)showConnectionFailureMessage:(NSError*)error;
//-(void)showActivityIndicator;
@end
