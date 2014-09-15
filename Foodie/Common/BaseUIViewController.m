//
//  BaseUIViewController.m
//  ChargePoint
//
//  Created by Manish Kumar on 22/04/13.
//  Copyright (c) 2013 Chargepoint Inc.  All rights reserved.
//

#import "BaseUIViewController.h"
//#import "ExceptionHandlingVC.h"
//#import "LocationManager.h"
//#import "LegacyMyPlacesUIViewController.h"
//#import "RecentlyVisitedUIViewController.h"
//#import "ConnectionsUIViewController.h"
//#import "SettingsUIViewController.h"
//#import "CustomActivityProvider.h"

//#import "ActivityGetDirectionViaAppleMaps.h"
//#import "ActivityGetDirectionViaGoogleMaps.h"
//#import "ActivityGetDirectionViaWaze.h"

//#import "ScrollableAdvanceFilterView.h"
//#import "AppDelegate.h"
//#import "LegacyHomeUIViewController.h"
//#import "NavigateViewController.h"
//#import "LegacyStationDetailUIViewController.h"
//#import "LegacyStartSessionUIViewController.h"
//#import "LegacyMenuUIViewController.h"
//#import "LegacyMenuAnchorView.h"
//#import "ShareViewController.h"
//#import "AppDelegate.h"
//#import "AddFavoriteVC.h"
//#import "LegacyMenuView.h"

//#import "UserSpecificTaskManager.h"
//#import "InAppPromptController.h"
//#import "SelectEvPromptViewController.h"
//#import "NoCCOnFilePromptViewController.h"
//#import "IncompleteProfilePromptViewController.h"
//#import "OrderCardNoCCPromptViewController.h"
//#import "AddConnectionPromptViewController.h"
//#import "AddTipsNoCCOnFilePromptViewController.h"
//#import "AddTipsNoEvatarPromptViewController.h"

//#define kCONST_NO_POWER                             0
//#define kCONST_DAMAGED                              1
//#define kCONST_MISSING                              2
//#define kCONST_INCORRECT_INFO                       3
//#define kCONST_OTHER                                4


@interface BaseUIViewController ()<UIActionSheetDelegate>
//@property   (nonatomic) UIActionSheet   *navigateToActionSheet;
@end

@implementation BaseUIViewController
//-(void)showAddEditView{}
//-(void)showAddEditViewWithAddress:(NSString *)spotAddress{}
//-(void)showAddEditViewWithAddress:(NSString *)spotAddress
//                     spotLocation:(CLLocation*)spotLocation{}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //TEST FLIGHT
//    [TestFlight passCheckpoint:[NSString stringWithFormat:@"%@ is displaying",[self class]]];
    self.view.backgroundColor    = [UIColor colorWithPatternImage:[UIImage imageNamed:IMG_APPLICATION_BACKGROUND]];
    
    [super viewDidLoad];
//    [self setViewHeightWidth];

    //initialize common contents
//    commonContentManager    =   [CommonContentManager sharedInstance];
//    commonContentManager.viewHeight =   [NSNumber numberWithFloat:self.view.bounds.size.height];
//    commonContentManager.viewWidth =   [NSNumber numberWithFloat:self.view.bounds.size.width];

    // Do any additional setup after loading the view.
    if (IS_OS_7_OR_LATER)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(advanceSearchUpdated)
//                                                 name: kFilterUpdated object: nil];

    
    //    [Utils saveObjToDefaults:[NSNumber numberWithBool:NO] name:@"ynPortraitOnly"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidLayoutSubviews{
    // fix for new status bar in ios7, also added View controller-based status bar appearance = NO in ChargePoint-Info.plist
//    if ([Utils isIOS7]) {
        // for traditional white on black, unremark below with xcode 4.5, and change addStatusBackground color to black
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        //[self addStatusBackground];
//    }
    //amre MBL 1308
//    if ([Utils isIOS7] && [Utils isStatusVisible]) {
//        [self addStatusBackground];
//    }
}

//-(void)addStatusBackground{
//    UIColor *col = [UIColor whiteColor];
//
//    //amre MBL 1308 unremark in xCode 5.0
//    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    //col = [UIColor blackColor];
//    
//    CGRect rect = CGRectMake(0, 0, [Utils getWW], 20);
//    self.labStatus = [[UILabel alloc] initWithFrame:rect];
//    self.labStatus.backgroundColor = col;
//    [self.view addSubview:self.labStatus];
//    [self.view sendSubviewToBack:self.labStatus];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (!self.isOtherOrientationSupported)
//    {
//        [[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:")
//                                       withObject:(__bridge id)((void*)UIInterfaceOrientationPortrait)];
//    }
    
    //gogle analytics tracker implementeation - screen measurement
//    self.screenName = [NSString stringWithFormat:@"%@",[self class]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self setViewHeightWidth];

//    [self prepareUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideActivityIndicator)
                                                 name:kErrorInServiceResponse
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (UIView *subview in self.view.subviews) {
        if ([subview canPerformAction:@selector(endEditing:) withSender:nil]) {
            [subview endEditing:YES];
        }
        if ([subview canResignFirstResponder]) {
            [subview resignFirstResponder];
        }
    }

//    [self deregisterForKeyboardNotifications];
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)addNavigationGradient
//{
//    return; //amre nov 8 2013: cant swipe in lower and upper map regions
//    CGFloat gradientStartX  =   CGFLOAT_MIN;
//    CGFloat gradientStartY  =   CONST_CUSTOM_NAVIGATION_BAR_HEIGHT;
//    CGFloat gradientControlWidth  =   self.view.frame.size.width;
//    CGFloat gradientControlHeight  =   CONST_DEFAULT_PADDING/4;
//    if (!iViewGradient)
//    {
//        iViewGradient   =   [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_FADE_GRADIENT]];
//        [self.view addSubview:iViewGradient];
//    }
//    [iViewGradient setFrame:CGRectMake(gradientStartX, gradientStartY, gradientControlWidth, gradientControlHeight)];
//}

-(void)initializeScreenControls
{

}

#pragma mark - Common methods
//-(void)prepareUI
//{
//    NSLogInfo(@"");
//    
//    //add edit favorite places
////    if (self.addEditPlaces)
////    {
////        [self showAddEditView];
////    }
//    
//    if (self.activityIndicator)
//    {
//        [self.activityIndicator setFrame:self.view.frame];
//        [self.activityIndicator arrange];
//    }
//    
//    //hide back default back button
//    [self.navigationController.navigationItem setHidesBackButton:YES];
//}

//-(void)setViewHeightWidth{
//    viewWidth   = self.view.bounds.size.width;
//    viewHeight  = self.view.bounds.size.height;
//    
//    NSLogInfo(@"view height = %f width = %f",viewHeight,viewWidth);
//    commonContentManager.viewWidth = [NSNumber numberWithFloat:viewWidth];
//    commonContentManager.viewHeight = [NSNumber numberWithFloat:viewHeight];
//}

#pragma mark - Reachability

//-(void)startNotificationForReachabilityStatusForUrl:(NSString *)strUrl
//{
//    // Allocate a reachability object
//    Reachability* reach = [Reachability reachabilityWithHostname:strUrl];
//
//    // Set the blocks
//    reach.reachableBlock = ^(Reachability *reach)
//    {
//        NSLog(@"REACHABLE!");
//        [UIAlertView showWithMessage:[NSString stringWithFormat:@"%@ is reachable",strUrl]];
//    };
//
//    reach.unreachableBlock = ^(Reachability *reach)
//    {
//        NSLog(@"UNREACHABLE!");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [UIAlertView showWithMessage:[NSString stringWithFormat:@"%@ is unreachable",strUrl]];
//        });
//    };
//
//    // Start the notifier, which will cause the reachability object to retain itself!
//    [reach startNotifier];
//}

#pragma mark - Rotation methods


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
//    NSLogInfo[self description]);
//    UIDeviceOrientation currentOrientation =   [UIDevice currentDevice].orientation;
//
//    if (currentOrientation == UIDeviceOrientationPortrait ||
//        currentOrientation == UIDeviceOrientationLandscapeRight ||
//        currentOrientation == UIDeviceOrientationLandscapeLeft)
//    {
//        if (viewWidth == self.view.bounds.size.width) {
//            return YES;
//        }
//
//        [self setViewHeightWidth];
//
//        [self prepareUI];
//        return YES;
//    }
//    NSLogError(@"%d %@",[UIDevice currentDevice].orientation,[[UIDevice currentDevice] description]);
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait)
    {
        if (viewWidth == self.view.bounds.size.width) {
            return YES;
        }
        
//        [self setViewHeightWidth];
//        
//        [self prepareUI];

        return YES;
    }
    return NO;

//    BOOL ynViewModes = [[Utils loadObjFromDefaultsByName:@"ynPortraitOnly"] boolValue];
//    if (ynViewModes) {
//        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
//            return NO;
//        } else {
//            return NO;
//        }
//    }

//    if (viewWidth == self.view.bounds.size.width) {
//        return YES;
//    }
//
//    [self setViewHeightWidth];
//
//    [self prepareUI];
//    return YES;
}

#pragma mark - View Offset base methods

//-(float)getViewModeCenterX{
//    return viewWidth - [self getViewModeCenterXOffset];
//}
//-(float)getViewModeCenterXOffset{
//    return 68/2;
//}
//
//-(float)getViewModeCenterY{
//    return viewHeight - [self getViewModeCenterYOffset];
//}
//-(float)getViewModeCenterYOffset{
//    return ([Utils getYScroll] + 68)/2;
//}

#pragma mark - Location Services base methods
-(void)locationUpdateFailed:(NSError*)error
{
    NSLogError(@"%@", [error description]);
    [self showLocationServiceExceptionHandlingView:YES
                                      updateFailed:NO];
}

#pragma mark - location services protocol methods
-(void)locationServicesNotEnabled
{
    [self showLocationServiceExceptionHandlingView:NO
                                      updateFailed:NO];}

-(void)applicationNotAllowedToUseLocationServices
{
    [self showLocationServiceExceptionHandlingView:NO
                                      updateFailed:NO];
}

#pragma mark - exception View
-(void)showLocationServiceExceptionHandlingView:(BOOL)isAuthorized
                                   updateFailed:(BOOL)updateFailed
{
    NSString    *strMessage =   nil;

    if (isAuthorized)
    {
        strMessage =   STR_LOCATION_UPDATE_FAILED;
    }
    else //if (updateFailed)
    {
        strMessage =   STR_ALERT_LOCATION_SERVICES_NOT_ENABLED;
    }
    
    if (av) {
        [av  dismissWithClickedButtonIndex:0 animated:YES];//dismiss:YES
        av = nil;
    }

    av  =  [[UIAlertView alloc] initWithTitle:STR_ALERT_TITLE_CHARGEPOINT_ALERT
                                                            message:strMessage
                                                           delegate:nil
                                                  cancelButtonTitle:STR_BUTTON_TITLE_OK
                                                  otherButtonTitles:nil];
    [av show];
}

-(void)showExceptionViewControllerForClass:(NSString *)className
                              functionName:(NSString *)functionName
                                 exception:(NSException*)exception
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        ExceptionHandlingVC  *exceptionViewController    =   [[ExceptionHandlingVC alloc] init];
//        [exceptionViewController showExceptionForClass:className
//                                          functionName:functionName
//                                             exception:exception];
//        [self pushViewController:exceptionViewController];
//    });
}


-(void)showExceptionViewControllerForSubView:(NSMutableDictionary*)exceptionDictionary
{
    @try {
        [self showExceptionViewControllerForClass:[exceptionDictionary objectForKey:CONST_KEY_EXCEPTIONHANDLING_CLASSNAME]
                                     functionName:[exceptionDictionary objectForKey:CONST_KEY_EXCEPTIONHANDLING_FUNCTIONNAME]
                                        exception:[exceptionDictionary objectForKey:CONST_KEY_EXCEPTIONHANDLING_EXCEPTION]];
    }
    @catch (NSException *exception) {
        //suppress exceptions if any at the time of handling
    }
}

#pragma mark - Activity indicator

//-------------------------------------------------------------------------
// Method:			disableUserInteraction
//
// Description:
//
// Parameter:
//-------------------------------------------------------------------------
-(void)disableUserInteraction
{
	float alphaValue = CONST_ACTIVITY_INDICATOR_VIEW_ALPHA;
	
	for (UIView * view in [self.view subviews])
	{
		if (view.hidden == NO)
		{
            if (![view isKindOfClass:[ActivityIndicator class]])
            {
                view.alpha = alphaValue;
//Navi - disabling this.
//                view.userInteractionEnabled = NO;
            }
		}
	}
    
	self.navigationController.navigationBar.userInteractionEnabled = NO;
	NSLogInfo(@"[BaseViewController disableUserInteraction]:-------------------------");
	//[uiLock unlock];
}

//-------------------------------------------------------------------------
// Method:			enableUserInteraction
//
// Description:
//
// Parameter:
//-------------------------------------------------------------------------
-(void)enableUserInteraction
{
	float alphaValue = 1.0;
	for (UIView * view in [self.view subviews])
	{
		view.alpha = alphaValue;
		view.userInteractionEnabled = YES;
	}
    
	self.navigationController.navigationBar.userInteractionEnabled = YES;
	NSLogInfo(@"[BaseViewController enableUserInteraction]:-------------------------");
    
    //[self.menuView arrange];
}

//-(void)showActivityIndicatorWithParameter:(NSDictionary *)paramDict
//                         activityDelegate:(id)activityDelegate
//{
//    [self showActivityIndicator:[paramDict objectForKey:CONST_PARAMETER_ACTIVITY_COLOR]
//                    isTextBlack:[[paramDict objectForKey:CONST_PARAMETER_ACTIVITY_ISTEXTBLACK] boolValue]
//                   activityText:[Utils validateString:[paramDict objectForKey:CONST_PARAMETER_ACTIVITY_TEXT]]
//               showCancelButton:[[paramDict objectForKey:CONST_PARAMETER_ACTIVITY_SHOW_CANCEL] boolValue]
//               activityDelegate:activityDelegate];
//}

-(void)showActivityIndicator:(UIColor*)activityColor
                 isTextBlack:(BOOL)isTextBlack
                activityText:(NSString *)activityText
            showCancelButton:(BOOL)showCancelButton
            activityDelegate:(id)activityDelegate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.activityIndicator)
        {
//            if ([activityDelegate isKindOfClass:[UIView class]])
//            {
//                UIView  *view   =   (UIView*)activityDelegate;
//                [self.activityIndicator setCenter:view.center];
//            }
//            else
//            {
                [self.activityIndicator setCenter:self.view.center];
//            }
            return;
        }
//        [Utils logTheFrameForControl:self.view];
        self.activityIndicator    =   [[ActivityIndicator alloc] initWithFrame:self.view.frame];
        [self.activityIndicator setCpViewDelegate:activityDelegate];
        self.activityIndicator.activityMessage  =   activityText;//[Utils validateString:activityText];
        self.activityIndicator.isActionActivityToBeShown    =   [NSNumber numberWithBool:showCancelButton];
        self.activityIndicator.isTextBlack  =   isTextBlack;
        [self.activityIndicator arrange];
        [self.view addSubview:self.activityIndicator];
        [self.view bringSubviewToFront:self.activityIndicator];
        [self.activityIndicator startActivity];
        [self disableUserInteraction];
    });
}

-(void)hideActivityIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.activityIndicator)
        {            
            [self.activityIndicator finishedActivity];
            [self.activityIndicator removeFromSuperview];
            self.activityIndicator = nil;
            [self enableUserInteraction];
        }
    });
}

#pragma mark - activity indicator protocol method
-(void)cancelCurrentActivity
{
    [self.activityIndicator removeFromSuperview];
    self.activityIndicator  =   nil;
    
    if ([self.activityIndicator cpViewDelegate] && [[self.activityIndicator cpViewDelegate] conformsToProtocol:@protocol(ActivityIndicatorProtocol)])
    {
        [[self.activityIndicator cpViewDelegate] performSelector:@selector(cancelCurrentActivity)];
    }
}

#pragma mark - Menu View
-(void)addMenuAnchorView
{
//    //is drop down menu view visible
//    if (self.menuView)
//    {
//        [self.menuView removeFromSuperview];
//        self.menuView = nil;
//    }
//    
//    CGFloat menuWidth = [Utils getImageWidth:IMG_VIEW_MODE_MAIN];
//    CGRect  btnRect =   CGRectMake(viewWidth - menuWidth - 5, [Utils getYScroll], menuWidth, [Utils getImageHeight:IMG_VIEW_MODE_MAIN]);
//
//    MenuAnchorView *menuAnchorView = [MenuAnchorView sharedInstance];
//    [Utils addShadow:menuAnchorView];
//
//    [menuAnchorView setCpViewDelegate:self];
//    [menuAnchorView setFrame:btnRect];
//    [menuAnchorView arrange];
//    
//    if (menuAnchorView)
//    {
//        [menuAnchorView removeFromSuperview];
//    }
//    [self.view addSubview:menuAnchorView];
}

//-(void)showMenuView:(id)sender
//{
//    [CommonContentManager sharedInstance].menuAnchorButtonTagBeforeMovingToMenuView  =   [NSNumber numberWithInteger:[LegacyMenuAnchorView sharedInstance].btnMenuAnchor.tag];
//    [self replaceImageForMenuAnchorWithImageName:CONST_TAG_MENU_EXIT];
//    LegacyMenuUIViewController    *menuUiViewController   =   [[LegacyMenuUIViewController alloc] init];
//    [self pushViewController:menuUiViewController];
//
//}
//
//-(void)replaceImageForMenuAnchorWithImageName:(int)menuTag;
//{
//    LegacyMenuAnchorView  *menuAnchorView =   [LegacyMenuAnchorView sharedInstance];
//    [menuAnchorView replaceImageForMenuAnchorWithImageName:menuTag];
//}
//
//-(void)setMenuAnchorImage:(id)sender
//{
//    UIButton    *btnSender  =   (UIButton*)sender;
//    [self replaceImageForMenuAnchorWithImageName:btnSender.tag];
//}
//
//-(void)resignScreenFirstReponders
//{
//    for (UIView *subView in [self.view subviews])
//    {
//        //if text field
//        if ([subView isKindOfClass:[UITextField class]])
//        {
//            [subView resignFirstResponder];
//        }
//
//        //if textview
//        if ([subView isKindOfClass:[UITextView class]])
//        {
//            [subView resignFirstResponder];
//        }
//
////        //custom search
////        if ([subView isKindOfClass:[CustomSearchView class]])
////        {
////            CustomSearchView    *custom =   (CustomSearchView*)subView;
////            [custom resignSearchFieldResponder];
////        }
//    }
//}
//
//-(void)hideDropdown:(id)sender
//{
////    @try {
////        self.menuView.isMenuDropDownVisible =   [NSNumber numberWithBool:NO];
////        
////        UIButton    *selectedBtn    =   (UIButton*)sender;
////        NSLogInfo(@"selected menu index = %ld",(long)selectedBtn.tag);
////        
////        [TestFlight passCheckpoint:[NSString stringWithFormat:@"%@ selected",selectedBtn.titleLabel.text]];
////        
////        switch (selectedBtn.tag)
////        {
////            case CONST_TAG_MENU_MYPLACES:
////            {
////                
////                LegacyMyPlacesUIViewController    *myPlacesUIViewController   =   [[LegacyMyPlacesUIViewController alloc] init];
////                [self pushViewController:myPlacesUIViewController];
////
////            }
////                break;
////                
////            case CONST_TAG_MENU_RECENTLY_VISITED:
////            {
////                
////                RecentlyVisitedUIViewController    *recentlyVisitedUIViewController   =   [[RecentlyVisitedUIViewController alloc] init];
////
////                [self pushViewController:recentlyVisitedUIViewController];
////
////            }
////                break;
////            case CONST_TAG_MENU_CONNECTIONS:
////            {
////                ConnectionsUIViewController    *connectionsUIViewController   =   [[ConnectionsUIViewController alloc] init];
////                [self pushViewController:connectionsUIViewController];
////
////            }
////                break;
////            case CONST_TAG_MENU_ALL_STATIONS:
////            {
////                SettingsUIViewController    *settingsUIViewController   =   [[SettingsUIViewController alloc] init];
////                [self pushViewController:settingsUIViewController];
////            }
////                break;
////            case CONST_TAG_MENU_EXIT:
////            {
////                NSString *callingDialFrom = [Utils loadObjFromDefaultsByName:STR_CALLING_DIAL_FROM];
////                if (callingDialFrom.length == 0) {
////                    callingDialFrom = STR_VIEW_MODE_TOPIC_MAP;
////                }
////                if ([callingDialFrom isEqualToString:STR_VIEW_MODE_TOPIC_MAP]) {
////                    //amre MBL 1264
////                    for (UIViewController *controller in [[self navigationController] viewControllers])
////                    {
//////                        NSLogInfo[[controller class] description]);
////                        if ([controller isKindOfClass:[LegacyHomeUIViewController class]])
////                        {
////                            [self popViewController:controller];
////                            break;
////                        }
////                    }
////                    break;
////                }
////                if ([callingDialFrom isEqualToString:STR_VIEW_MODE_TOPIC_RECENTS]) {
////                    RecentlyVisitedUIViewController *recentVc = [[RecentlyVisitedUIViewController alloc] init];
////                    [self pushViewController:recentVc];
////                    break;
////                }
////                if ([callingDialFrom isEqualToString:STR_VIEW_MODE_TOPIC_CONNECTIONS]) {
////                    ConnectionsUIViewController *connectionsVc = [[ConnectionsUIViewController alloc] init];
////                    [self pushViewController:connectionsVc];
////                    break;
////                }
////                if ([callingDialFrom isEqualToString:STR_VIEW_MODE_TOPIC_SETTINGS]) {
////                    SettingsUIViewController *settingsVc = [[SettingsUIViewController alloc] init];
////                    [self pushViewController:settingsVc];
////                    break;
////                }
////                if ([callingDialFrom isEqualToString:STR_VIEW_MODE_TOPIC_MYSPOTS]) {
////                    LegacyMyPlacesUIViewController *myspotsVc = [[LegacyMyPlacesUIViewController alloc] init];
////                    [self pushViewController:myspotsVc];
////                    break;
////                }
////            }
////            default:
////                break;
////        }
////    }
////    @catch (NSException *exception) {
////        [self showExceptionViewControllerForClass:[self description]
////                                      functionName:[NSString stringWithFormat:@"%s",__FUNCTION__]
////                                         exception:exception];
////    }
////    @finally {
////        [self.menuView removeFromSuperview];
////        self.menuView = nil;
//////        [Utils saveObjToDefaults:[NSNumber numberWithBool:NO] name:@"ynPortraitOnly"];
////    }
//}
//
//#pragma mark - @protocol AdvanceSearchProtocol
//
//-(void)advanceSearchUpdated
//{
//    //child to implement
//    //    [self hideAdvanceFilter:nil];
//}
//
//#pragma mark - Navigation bar protocols
//-(void)onFirstButtonAction:(id)sender
//{
//    [TestFlight passCheckpoint:@"First / Map navigation button pressed on the navigation bar"];
////    for (UIViewController *controller in [self.navigationController viewControllers])
////    {
////        NSLogInfo(@"%@", [[controller class] description]);
////        if ([controller isKindOfClass:[HomeUIViewController class]])
////        {
////            [self.navigationController popToViewController:controller
////                                                  animated:NO];
////            BOOL ynRefreshMap = [[Utils loadObjFromDefaultsByName:@"refresh map"] boolValue];
////            if (ynRefreshMap) {
////                HomeUIViewController *homeVc = (HomeUIViewController*)controller;
////                [homeVc.mapView fetchFavoriteSpots];
////                
////                [Utils saveObjToDefaults:[NSNumber numberWithBool:NO] name:@"refresh map"];
////            }
////            return;
////        }
////    }
////    
////    UIViewController<HomeProtocol> *homeVc = [HomeUIViewController create];
////    [homeVc fetchFavoriteSpots];
////    [Utils fadeToViewController:self.navigationController to:homeVc];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)onSecondButtonAction:(id)sender
//{
//    [TestFlight passCheckpoint:@"Second / Back navigation button pressed on the navigation bar"];
//    [self.navigationController popViewControllerAnimated:NO];
//}
//
//#pragma mark - Tone Methods
//-(void)loadHalfTone{
//    if (!self.labHalfTone) {
//        self.labHalfTone = [[UILabel alloc] init];
//        
//        self.labHalfTone.alpha = 0.5;
//        self.labHalfTone.userInteractionEnabled = NO;
//        
//        [self.view addSubview:self.labHalfTone];
//    }
//    [self.view bringSubviewToFront:self.labHalfTone];
//    
//    self.labHalfTone.frame = self.view.bounds;
//    self.labHalfTone.backgroundColor = [UIColor blackColor];
//}
//-(void)showHalfTone:(id)sender{
//    //    if (ynShowingViewModeOpen) {
//    //        ynShowingViewModeOpen = NO;
//    //        [self loadViewModeButtons];
//    //    }
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:CONST_ANIMATION_DURATION];
//    
//    float alpha = .5;
//    //if ([self isCalloutOpen]) alpha = .25;
//    self.labHalfTone.alpha = alpha;
//    
//    [UIView commitAnimations];
//    
//}
//-(void)hideHalfTone:(id)sender{
//    // exit if any callout is open
//    //    if ([self isCalloutOpen]) {
//    //        return;
//    //    }
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:CONST_ANIMATION_DURATION];
//    
//    self.labHalfTone.alpha = 0;
//    
//    [UIView commitAnimations];
//}
//
//#pragma mark - edit my places
//-(void)getAddressFromLocation:(id)sender
//{
//    NSMutableDictionary *activityParameter      =   [[NSMutableDictionary alloc] init];
//    [activityParameter setObject:[UIColor whiteColor]
//                          forKey:CONST_PARAMETER_ACTIVITY_COLOR];
//
//    [self showActivityIndicator:[UIColor whiteColor]
//                     isTextBlack:NO
//                    activityText:@""
//                showCancelButton:NO
//                activityDelegate:self];
//
//    if ([sender isKindOfClass:[CLLocation class]])
//    {
//        dispatch_queue_t    findLocation    =   dispatch_queue_create("getAddressFromLocation", NULL);
//        dispatch_async(findLocation, ^{
//            LocationManager *placeLocationManager =   [LocationManager sharedInstance];
//            [placeLocationManager setDelegate:self];
//            
//            CLLocation  *refLocation    =   (CLLocation*)sender;
//            if ([Utils isLocationValid:refLocation])
//            {
//                [placeLocationManager getAddressFromLocation:refLocation];
//            }
//            else
//            {
//                [self showAddEditView:nil];
//                //show add edit fav view
//            }
//        });
////        dispatch_release(findLocation);
//
//    }
//
//    else
//    {
//        if ([LocationManager.sharedInstance isLocationServicesAllowed])
//        {
//            dispatch_queue_t    findLocation    =   dispatch_queue_create("getAddressFromLocation", NULL);
//            dispatch_async(findLocation, ^{
//                LocationManager *placeLocationManager =   [LocationManager sharedInstance];
//                [placeLocationManager setDelegate:self];
//                //search
//                if ([Utils isLastKnownUserLocationAvailableinNSUserDefault])
//                {
//                    CLLocation  *savedLocation   =   [Utils getSavedCLLocation];
//
//                    [placeLocationManager getAddressFromLocation:savedLocation];
//                }
//                else
//                {
//                    [self showAddEditView:nil];
//                }
//            });
////            dispatch_release(findLocation);
//
//        }
//        else
//        {
//            [self showAddEditView:nil];
//        }
//    }
//
//}
//
//#pragma mark -
//-(void)onGetAddressFromLocation:(CLPlacemark*)placemark
//{
//
//    [[LocationManager sharedInstance] clearSharedInstance];
//
//    if (placemark)
//    {
//        NSMutableString *addressText    =   [[NSMutableString alloc] initWithString:@""];
//
//        if ([placemark subThoroughfare])
//        {
//            [addressText appendString:[placemark subThoroughfare]];
//        }
//
//        if ([placemark thoroughfare])
//        {
//            if ([addressText length]>0)
//            {
//                [addressText appendString:CONST_SYMBOL_WHITESPACE]; //amre MBL 1349
//            }
//            [addressText appendString:[placemark thoroughfare]];
//        }
//
//        if ([placemark locality])
//        {
//            if ([addressText length]>0)
//            {
//                [addressText appendString:CONST_SYMBOL_WHITESPACE];
//            }
//            [addressText appendString:[placemark locality]];
//        }
//
//        if ([placemark administrativeArea])
//        {
//            if ([addressText length]>0)
//            {
//                [addressText appendString:CONST_SYMBOL_WHITESPACE];
//            }
//            [addressText appendString:[placemark administrativeArea]];
//        }
//
//        NSLogInfo(@"%@", addressText);
//
//        [self showAddEditViewWithAddress:addressText spotLocation:placemark.location];
//    }
//    else
//    {
//        [self showAddEditView:nil];
//    }
//
//    [self hideActivityIndicator];
//}
//
//-(void)showAddEditView:(CLPlacemark*)placemark
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[LocationManager sharedInstance] clearSharedInstance];
//
//        if (placemark)
//        {
//
//            NSString *addressTxt = [NSString stringWithFormat:@"%@ %@,%@ %@",
//                                    [placemark subThoroughfare],[placemark thoroughfare],
//                                    [placemark locality], [placemark administrativeArea]];
//            [UIAlertView showWithMessage:addressTxt];
//
//            [self showAddEditView];
////            self.addEditPlaces.txtBoxfavoriteAddress.text    =  addressTxt;
//            //show add edit view with address
//        }
//        else
//        {
//            [self showAddEditView];
//            //else show add edit view
//        }
//        
//        [self hideActivityIndicator];
//        
//    });
//}
//
////-(void)showAddEditViewWithAddress:(NSString *)spotAddress
////                     spotLocation:(CLLocation*)spotLocation
////{
////    if (!spotAddress)
////    {
////        [self getAddressFromLocation:spotLocation];
////    }
////    else
////    {
////        //show add edit with spot location
//////        [self showAddEditView];
//////        self.addEditPlaces.txtBoxfavoriteAddress.text    =  spotAddress;
//////        self.addEditPlaces.placeLocation                =   spotLocation;
////    }
////}
//
////-(void)showAddEditViewWithAddress:(NSString *)spotAddress
////{
////    [self showAddEditView];
////    self.addEditPlaces.txtBoxfavoriteAddress.text    =  spotAddress;
////}
//
////-(void)showAddEditView
////{
////    AddFavoriteVC   *favVc  =   [AddFavoriteVC instantiateFromStoryboard];
////    favVc.senderViewController  =   self;
////    [self presentViewController:favVc
////                       animated:YES
////                     completion:nil];
////}
//
////-(void)closeAddEditView
////{
////    [self performAdditionalActivityOnClosingAddPlace];
//////    [self hideActivityIndicator];
//////    [self.addEditPlaces removeFromSuperview];
//////    self.addEditPlaces  =   nil;
////}
//
////-(void)performAdditionalActivityOnClosingAddPlace
////{
////
////}
//
////-(void)showAddDriverTipView
////{
////    if (self.addDriverTipView == nil)
////    {
////        self.addDriverTipView                  =   [[AddDriverTipView alloc] initWithFrame:CGRectZero];
////        self.addDriverTipView.viewTitle        =   STR_ADD_DRIVER_TIP;
////        self.addDriverTipView.leftIconImage    =   nil;
////        self.addDriverTipView.deviceId          =   [NSNumber numberWithInteger:1984];
////    }
////    [self.addDriverTipView setCpViewDelegate:self];
////    [self.addDriverTipView setFrame:self.view.bounds];
////    [self.addDriverTipView arrange];
////    [self.view addSubview:self.addDriverTipView];
////    
////    if (!self.addDriverTipView) {
////        self.addDriverTipView   =   [AddDriverTipVCViewController instantiateFromStoryboard];
//////        self.addDriverTipView.deviceId          =   [NSNumber numberWithInteger:1984];
////    }
////    self.addDriverTipView.
////    
////}
//#pragma mark - SCrollable Filter panel
//-(void)initializeScrollableFilterListView
//{
//    [self initializeScrollableFilterListView:YES];
//}
//
//-(void)initializeScrollableFilterListView:(BOOL)addNub
//{
////    if (self.scrollableAdvanceFilterView)
////    {
////        [self.scrollableAdvanceFilterView removeFromSuperview];
////	}
////    self.scrollableAdvanceFilterView = [ScrollableAdvanceFilterView sharedInstance];
////    if(addNub)
////        [self.scrollableAdvanceFilterView addNub];
////    
////    [self.scrollableAdvanceFilterView setCpViewDelegate:self];
////    self.scrollableAdvanceFilterView.isFilterPanelVisibleWithFilters    =   [NSNumber numberWithBool:NO];
////    [self.scrollableAdvanceFilterView toggleDrawerImage];
////    NSLogInfo(@"initializeScrollableFilterListView");
////    
////    CGRect filterViewRect   =   CGRectMake(0 - CONST_FILTER_PANEL_WIDHT,CONST_CUSTOM_NAVIGATION_BAR_HEIGHT, [Utils getYScroll] + [self.scrollableAdvanceFilterView getFilterPanelWidth], viewHeight - CONST_CUSTOM_NAVIGATION_BAR_HEIGHT);
////    [self.scrollableAdvanceFilterView setFrame:filterViewRect];
////    
////    [self.scrollableAdvanceFilterView arrange];
////    [self.view addSubview:self.scrollableAdvanceFilterView];
//}
//
//-(void)showScrollableFilterListView:(id)sender
//{
////    if (!self.scrollableAdvanceFilterView.isFilterPanelVisibleWithFilters.boolValue)
////    {
////        self.scrollableAdvanceFilterView.isFilterPanelVisibleWithFilters =   [NSNumber numberWithBool:YES];
////        NSLogInfo(@"showScrollableFilterListView:");
////        [self.scrollableAdvanceFilterView toggleDrawerImage];
////        CGRect filterViewRect   =   CGRectMake(0, CONST_CUSTOM_NAVIGATION_BAR_HEIGHT, [self.scrollableAdvanceFilterView getFilterPanelWidth], viewHeight - CONST_CUSTOM_NAVIGATION_BAR_HEIGHT);
////
////        [UIView animateWithDuration:CONST_ANIMATION_DURATION animations:^{
////            [self.scrollableAdvanceFilterView setFrame:filterViewRect];
////            [self.view bringSubviewToFront:self.scrollableAdvanceFilterView];
////        }
////                         completion:^ (BOOL finished) {
////                         }];
////    }
//}
//
//-(void)hideScrollableFilterListView:(id)sender
//{
////    if (self.scrollableAdvanceFilterView.isFilterPanelVisibleWithFilters.boolValue)
////    {
////        self.scrollableAdvanceFilterView.isFilterPanelVisibleWithFilters =   [NSNumber numberWithBool:NO];
////        [self.scrollableAdvanceFilterView toggleDrawerImage];
////        NSLogInfo(@"hideScrollableFilterListView:");
////        CGRect filterViewRect   =   CGRectMake(0 - CONST_FILTER_PANEL_WIDHT, CONST_CUSTOM_NAVIGATION_BAR_HEIGHT, [self.scrollableAdvanceFilterView getFilterPanelWidth], viewHeight - CONST_CUSTOM_NAVIGATION_BAR_HEIGHT);
////
////        [UIView animateWithDuration:CONST_ANIMATION_DURATION animations:^{
////
////            [self.scrollableAdvanceFilterView setFrame:filterViewRect];
////        }
////                         completion:^ (BOOL finished) {
////                         }];
////    }
//}
//
//
//#pragma mark - Get Direction
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation
//              destinationTitle:(NSString *)destinationTitle
//{
//    @try {
//        CLLocationCoordinate2D          currentLocation =   [Utils getSavedCLLocationCoordinate2D];
//        if ([Utils isLocationCoordinateValid:currentLocation])
//        {
//            if (self.navigateToActionSheet) {
//                [self.navigateToActionSheet dismiss:YES];
//                self.navigateToActionSheet = nil;
//            }
//            
//            NSMutableArray  *buttonArray    =   [NSMutableArray new];
//            BlockButton *navigateViaApple    =   [BlockButton label:NSLocalizedString(@"Apple Maps", nil)
//                                                             action:^{
//                                                                 
//                                                                 Class mapItemClass = [MKMapItem class];
//                                                                 if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
//                                                                 {
//                                                                     // Create an MKMapItem to pass to the Maps app
//                                                                     MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:destinationLocation.coordinate
//                                                                                                                    addressDictionary:nil];
//                                                                     MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//                                                                     [mapItem setName:destinationTitle];
//                                                                     
//                                                                     // Set the directions mode to "Walking"
//                                                                     // Can use MKLaunchOptionsDirectionsModeDriving instead
//                                                                     NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
//                                                                     // Get the "Current User Location" MKMapItem
//                                                                     MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
//                                                                     // Pass the current location and destination map items to the Maps app
//                                                                     // Set the direction mode in the launchOptions dictionary
//                                                                     [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
//                                                                                    launchOptions:launchOptions];
//                                                                 }
//                                                                 else{
//                                                                     MKPlacemark *placemarkThere = [[MKPlacemark alloc] initWithCoordinate:destinationLocation.coordinate addressDictionary:nil];
//                                                                     MKMapItem *there = [[MKMapItem alloc] initWithPlacemark:placemarkThere];
//                                                                     
//                                                                     //    [there setName:title];
//                                                                     // Set the directions mode to "Walking"
//                                                                     // Can use MKLaunchOptionsDirectionsModeDriving instead
//                                                                     NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
//                                                                     // Get the "Current User Location" MKMapItem
//                                                                     MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
//                                                                     // Pass the current location and destination map items to the Maps app
//                                                                     // Set the direction mode in the launchOptions dictionary
//                                                                     [MKMapItem openMapsWithItems:@[currentLocationMapItem, there]
//                                                                                    launchOptions:launchOptions];
//                                                                 }
//                                                                 
//                                                             }];
//            [buttonArray addObject:navigateViaApple];
//            
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:CONST_GOOGLE_APP_URL]])
//            {
//                BlockButton *navigateViaGoogle    =   [BlockButton label:NSLocalizedString(@"Google Maps", nil)
//                                                                  action:^{
//                                                                      CLLocationCoordinate2D          currentLoc =   [Utils getSavedCLLocationCoordinate2D];
//                                                                      NSString *urlStr = [NSString stringWithFormat:@"%@??saddr=%g,%g&daddr=%g,%g", CONST_GOOGLE_APP_URL, currentLoc.latitude, currentLoc.longitude, destinationLocation.coordinate.latitude, destinationLocation.coordinate.longitude];
//                                                                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];                                                            }];
//                [buttonArray addObject:navigateViaGoogle];
//            }
//            
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:CONST_WAZE_APP_URL]])
//            {
//                BlockButton *navigateViaWaze    =   [BlockButton label:NSLocalizedString(@"Waze", nil)
//                                                                action:^{
//                                                                    //Waze is installed. Launch Waze and start navigation
//                                                                    NSString *urlStr = [NSString stringWithFormat:@"%@?ll=%f,%f&navigate=yes", CONST_WAZE_APP_URL, destinationLocation.coordinate.latitude, destinationLocation.coordinate.longitude];
//                                                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//                                                                }];
//                [buttonArray addObject:navigateViaWaze];
//            }
//            
//            self.navigateToActionSheet  =   [UIActionSheet createWithTitle:@""
//                                                              cancelButton:[BlockButton label:NSLocalizedString(@"Cancel", nil) action:^{
//                [self.navigateToActionSheet dismiss:YES];
//            }]
//                                                                   buttons:buttonArray];
//            
////            UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
//            UIView  *view   =   [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
//            [self.navigateToActionSheet showInView:view];
//            
////            if ([window.subviews containsObject:self.view]) {
////                [self.navigateToActionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
////            } else {
////                [self.navigateToActionSheet showInView:[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject]];
////            }
//            
////            [self.navigateToActionSheet showInView:self.view];
//        }
//        else{
//            [UIAlertView showWithMessage:STR_ALERT_SEARCH_LOCATION_NOT_FOUND];
//        }
///*
//        if ([LocationManager.sharedInstance isLocationServicesAllowed])
//        {
//            CLLocationCoordinate2D          currentLocation =   [Utils getSavedCLLocationCoordinate2D];
//            [Utils saveObjToDefaults:[NSNumber numberWithDouble:destinationLocation.coordinate.latitude] name:STR_NAVIGATE_LAT];
//            [Utils saveObjToDefaults:[NSNumber numberWithDouble:destinationLocation.coordinate.longitude] name:STR_NAVIGATE_LON];
//
//            [Utils saveObjToDefaults:destinationTitle name:STR_NAVIGATE_TITLE];
//
//            NavigateViewController *navigateVc = [[NavigateViewController alloc] init];
//            NSLogInfo(@"source - %f , %f... \n Destination - %f %f",currentLocation.latitude,currentLocation.longitude,destinationLocation.coordinate.latitude,destinationLocation.coordinate.longitude);
//            [self navigationController].modalPresentationStyle = UIModalPresentationCurrentContext;
//            [[self navigationController] presentViewController:navigateVc animated:NO completion:nil];
//            return;
//
//            
//
//
//            //APPLE MAPS
//            ActivityGetDirectionViaAppleMaps    *appleMaps             =   [[ActivityGetDirectionViaAppleMaps alloc]init];
//            appleMaps.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
//            appleMaps.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
//            appleMaps.destinationTitle          =   destinationTitle;
//
//            appleMaps.sourceLatitude        =   [NSNumber numberWithFloat:currentLocation.latitude];
//            appleMaps.sourceLongitude       =   [NSNumber numberWithFloat:currentLocation.longitude];
//            appleMaps.sourceTitle           =   STR_CURRENT_LOCATION;
//
//            //GOOGLE MAPS
//            ActivityGetDirectionViaGoogleMaps   *googleMaps     =   [[ActivityGetDirectionViaGoogleMaps alloc] init];
//            googleMaps.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
//            googleMaps.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
//
//            googleMaps.sourceLatitude        =   [NSNumber numberWithFloat:currentLocation.latitude];
//            googleMaps.sourceLongitude       =   [NSNumber numberWithFloat:currentLocation.longitude];
//            googleMaps.sourceTitle           =   STR_CURRENT_LOCATION;
//
//            //Waze
//            ActivityGetDirectionViaWaze         *waze           =   [[ActivityGetDirectionViaWaze alloc] init];
//            waze.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
//            waze.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
//            waze.sourceLatitude         =   [NSNumber numberWithFloat:currentLocation.latitude];
//            waze.sourceLongitude        =   [NSNumber numberWithFloat:currentLocation.longitude];
//            waze.sourceTitle            =   STR_CURRENT_LOCATION;
//
//
//
//            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlemaps://"]]) {
//                googleMaps = nil;
//            }
//            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]]) {
//                waze = nil;
//            }
//
//            UIActivityViewController   *activityVC =    [[UIActivityViewController alloc] initWithActivityItems:nil
//                                                                                          applicationActivities:[NSArray arrayWithObjects:appleMaps,googleMaps,waze,nil]];
//
//            activityVC.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll];
//            
//            activityVC.completionHandler = ^(NSString *activityType, BOOL completed)
//            {
//                NSLogInfo(@" activityType: %@", activityType);
//                NSLogInfo(@" completed: %i", completed);
//            };
//            
//            [self presentViewController:activityVC animated:YES completion:nil];
// */
//    }
//    @catch (NSException *exception) {
//        [self showExceptionViewControllerForClass:[self description]
//                                     functionName:[NSString stringWithFormat:@"%s",__FUNCTION__]
//                                        exception:exception];
//    }
//}
//
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation
//{
//    [self showGetDirectionOptions:destinationLocation
//                 destinationTitle:nil];
//}
//
//-(void)showGetDirectionOptions:(CLLocation*)destinationLocation
//            destinationAddress:(NSDictionary *)destinationAddress
//{
//
//    [self showGetDirectionOptions:destinationLocation
//                 destinationTitle:destinationAddress[@"name"]];
////    [Utils printKeyValuesForDictionary:destinationAddress];
////    dispatch_async(dispatch_get_main_queue(),
////                   ^{
////                       @try {
////                           if ([LocationManager.sharedInstance isLocationServicesAllowed])
////                           {
////                               CLLocationCoordinate2D          currentLocation =   [Utils getSavedCLLocationCoordinate2D];
////                               [Utils saveObjToDefaults:[NSNumber numberWithDouble:destinationLocation.coordinate.latitude] name:STR_NAVIGATE_LAT];
////                               [Utils saveObjToDefaults:[NSNumber numberWithDouble:destinationLocation.coordinate.longitude] name:STR_NAVIGATE_LON];
////
////                               [Utils saveObjToDefaults:destinationAddress name:STR_NAVIGATE_ADDRESS];
////                               NSString    *destinationTitle   =   destinationAddress[@"name"];
////                               NavigateViewController *navigateVc = [[NavigateViewController alloc] init];
////
////                               NSLogInfo(@"title = %@ \nsource - %f , %f... \n Destination - %f %f",destinationTitle, currentLocation.latitude,currentLocation.longitude,destinationLocation.coordinate.latitude,destinationLocation.coordinate.longitude);
////                               
////                               [self navigationController].modalPresentationStyle = UIModalPresentationCurrentContext;
////                               [[self navigationController] presentViewController:navigateVc animated:NO completion:nil];
////                               return;
////
////                               NSLogInfo(@"source - %f , %f... \n Destination - %f %f",currentLocation.latitude,currentLocation.longitude,destinationLocation.coordinate.latitude,destinationLocation.coordinate.longitude);
////
////
////                               //APPLE MAPS
////                               ActivityGetDirectionViaAppleMaps    *appleMaps             =   [[ActivityGetDirectionViaAppleMaps alloc]init];
////                               appleMaps.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
////                               appleMaps.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
////                               appleMaps.destinationTitle          =   destinationTitle;
////
////                               appleMaps.sourceLatitude        =   [NSNumber numberWithFloat:currentLocation.latitude];
////                               appleMaps.sourceLongitude       =   [NSNumber numberWithFloat:currentLocation.longitude];
////                               appleMaps.sourceTitle           =   STR_CURRENT_LOCATION;
////
////                               //GOOGLE MAPS
////                               ActivityGetDirectionViaGoogleMaps   *googleMaps     =   [[ActivityGetDirectionViaGoogleMaps alloc] init];
////                               googleMaps.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
////                               googleMaps.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
////
////                               googleMaps.sourceLatitude        =   [NSNumber numberWithFloat:currentLocation.latitude];
////                               googleMaps.sourceLongitude       =   [NSNumber numberWithFloat:currentLocation.longitude];
////                               googleMaps.sourceTitle           =   STR_CURRENT_LOCATION;
////
////                               //Waze
////                               ActivityGetDirectionViaWaze         *waze           =   [[ActivityGetDirectionViaWaze alloc] init];
////                               waze.destinationLatitude     =       [NSNumber numberWithDouble:destinationLocation.coordinate.latitude];
////                               waze.destinationLongitude    =       [NSNumber numberWithDouble:destinationLocation.coordinate.longitude];
////                               waze.sourceLatitude         =   [NSNumber numberWithFloat:currentLocation.latitude];
////                               waze.sourceLongitude        =   [NSNumber numberWithFloat:currentLocation.longitude];
////                               waze.sourceTitle            =   STR_CURRENT_LOCATION;
////
////
////
////                               if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlemaps://"]]) {
////                                   googleMaps = nil;
////                               }
////                               if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]]) {
////                                   waze = nil;
////                               }
////
////                               UIActivityViewController   *activityVC =    [[UIActivityViewController alloc] initWithActivityItems:nil
////                                                                                                             applicationActivities:[NSArray arrayWithObjects:appleMaps,googleMaps,waze,nil]];
////
////                               activityVC.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeSaveToCameraRoll];
////
////                               activityVC.completionHandler = ^(NSString *activityType, BOOL completed)
////                               {
////                                   NSLogInfo(@" activityType: %@", activityType);
////                                   NSLogInfo(@" completed: %i", completed);
////                               };
////
////                               [self presentViewController:activityVC animated:YES completion:nil];
////                           }
////                       }
////                       @catch (NSException *exception) {
////                           [self showExceptionViewControllerForClass:[self description]
////                                                         functionName:[NSString stringWithFormat:@"%s",__FUNCTION__]
////                                                            exception:exception];
////                       }
////                   });
//    
//}
//
//#pragma mark - setBackgroundImageForEntireView
//-(void)setBackgroundImageForEntireView:(NSString *)bgImgName
//{
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:bgImgName] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
//}
//
//#pragma mark - Map callback to show station detail
//-(void)showDetailsForStationAnnotation:(id)selectedAnnotation
//{
//
//}
//
//#pragma mark - Animated Push Pop of viewControllers
//-(void)pushViewController:(id)viewController
//{
//    [Utils fadeToViewController:self.navigationController to:viewController];
//}
//
//-(void)popViewController:(id)viewController
//{
//    [Utils fadeToViewControllerPop:self.navigationController to:viewController];
//}
//
//#pragma mark - Report Station Action Sheet
//
//
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//{
//    [controller dismissViewControllerAnimated:YES
//                                   completion:nil];
//    controller  = nil;
//}
//
//#pragma mark - Share
//
//#pragma mark - button action methods
//-(void)gotoPreviousScreen:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:NO];
//}
//
//#pragma mark - gotoViewControllerWithClassName: sender:
//-(void)gotoViewControllerWithClassName:(NSString *)destinationController
//{    
//    //if not found
//    Class viewControllerClass = NSClassFromString(destinationController);
//    UIViewController *loadedVC = (UIViewController*) [[viewControllerClass alloc] init];
//    [Utils fadeToViewController:self.navigationController to:loadedVC];
//}
//
//-(void)checkAndPopOrPushToViewController:(NSString *)destinationViewController
//{
//    for (UIViewController *vController in [self.navigationController viewControllers])
//    {
//        if ([NSStringFromClass([vController class]) isEqualToString:destinationViewController])
//        {
//            NSLogInfo(@"YES found the class already allocated");
//            [Utils fadeToViewControllerPop:self.navigationController to:vController];
//            return;
//        }
//    }
//    
//    //if not found
//    Class viewControllerClass = NSClassFromString(destinationViewController);
//    UIViewController *loadedVC = (UIViewController*) [[viewControllerClass alloc] init];
//    [Utils fadeToViewController:self.navigationController to:loadedVC];
//}
//-(void)gotoViewControllerWithClassName:(NSString *)destinationController sender:(id)sender
//{
//    [self setMenuAnchorImage:sender];
//
//    [self gotoViewControllerWithClassName:destinationController];
//}
//
//
//#pragma mark - Register for keyboard show hide events
//
//- (void)deregisterForKeyboardNotifications
//{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [center removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
//}
//
//-(void)registerForKeyboardNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(keyboardWillShow:)
//                                                 name: UIKeyboardWillShowNotification object:nil];
//   
//    //    [[NSNotificationCenter defaultCenter] addObserver: self
//    //                                             selector: @selector(keyboardDidShow:)
//    //                                                 name: UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(keyboardWillDisappear:)
//                                                 name: UIKeyboardWillHideNotification object:nil];
//
//}
//
//- (NSTimeInterval) keyboardAnimationDurationForNotification:(NSNotification*)notification
//{
//    NSDictionary * info = [notification userInfo];
//    NSValue* value = [info objectForKey: UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval duration = 0;
//    [value getValue: &duration];
//    
//    return duration;
//}
//
//#pragma mark - In App Prompt
//-(void)checkForinAppPrompt:(NSArray*)promptCategory
//{
////    self.promptCategory =   category;
//    
//    [self showActivityIndicator:[UIColor whiteColor]
//                    isTextBlack:YES
//                   activityText:@""
//               showCancelButton:NO
//               activityDelegate:nil];
//    
//    //DELETE SELECTED CARD
//    /*
//     Service Name: get_profile_reminder_info
//     Header: "coulomb_sess=token" [required]["Cookie"]
//     ================================================================================
//     Request: https://mobile-dp50.ev-chargepoint.com/backend.php/mobileapi?
//     {
//     "get_profile_reminder_info":{
//     },
//     "user_id":152
//     }
//     
//     Response:
//     {
//     "get_profile_reminder_info"{
//     "status":true,
//     "user_type":”FREE / CHARGING / FCS / FULL”,
//     "cc_detail":{
//     “on_file”: false,
//     “is_disable”:false,
//     "currency_symbol":"$",
//     "initial_deposit":"25.00"
//     },
//     "profile_info":{
//     “is_complete”:true,
//     ”is_disabled”:false
//     },
//     “evatar”:{
//     “is_available”:true,
//     “url”:”https:\/\/dev_driverportal.ev- chargepoint.com\/coulomb_data\/public\/evatar\/12.png"
//     }
//     }
//     }
//     
//     */
//    NSMutableDictionary *jsonParameter  =   [NSMutableDictionary dictionaryWithObject:[[NSDictionary alloc] init]
//                                                                               forKey:CONST_SERVER_CHECK_FOR_INAPPP_ROMPTS];
//    
//    typeof (self) __weak weakSelf = self;
//    
//    [UserSpecificTaskManager post:jsonParameter
//                          success:^(NTJSON *json){
//                              NSDictionary    *dictValues   =   [[json dictionary] objectForKey:CONST_SERVER_CHECK_FOR_INAPPP_ROMPTS];
//                              if (dictValues && [dictValues[@"status"] integerValue] == 0)
//                              {
//                                  //display alert for error
//                                  dispatch_async_main(^{
//                                      [weakSelf hideActivityIndicator];
//                                  });
//                              }
//                              else if (dictValues && [dictValues[@"status"] integerValue] == 1)
//                              {
//                                  NSDictionary  *dictFinInfo    =   dictValues[CONST_SERVER_CC_DETAIL];
//                                  NSDictionary  *dictEvatarInfo =   dictValues[CONST_SERVER_EVATAR_DETAIL];
//                                  NSDictionary  *dictProfileInfo =   dictValues[CONST_SERVER_PROFILE_INFO];
//                                  NSDictionary  *dictUserNotification   =   dictValues[@"user_notifications"];
//                                  
//                                  dispatch_async_main(^{
//                                      [weakSelf hideActivityIndicator];
//
//                                      for (NSNumber *promptNumber in promptCategory)
//                                      {
//                                          BOOL  isPromptShown   =   NO;
//                                          
//                                          switch (promptNumber.integerValue) {
//                                              case FilterPanelFirstTime:  //1
//                                              {
//                                                  [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictValues];
//                                                  isPromptShown =   YES;
//                                              }
//                                                  break;
//                                                  
//                                              case OnBootNoCCFile:    //2
//                                              {
//                                                  if (dictFinInfo && ![dictFinInfo[CONST_SERVER_ON_FILE] boolValue] && ![dictFinInfo[CONST_SERVER_IS_PROMPT_DISABLED] boolValue])
//                                                  {
//                                                      //show cc prompt
//                                                      [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictFinInfo];
//                                                      isPromptShown =   YES;
//                                                  }
//                                              }
//                                                  break;
//                                                  
//                                              case NoCCTryToOrderCard:    //4
//                                              case AddDTNoCCOnFile:   //6
//                                              case AddDTNoCCNoEvatar: //8
//                                              case AddConnectionFirstTime:    //5
//                                              {
//                                                  if (dictFinInfo && ![dictFinInfo[CONST_SERVER_ON_FILE] boolValue])
//                                                  {
//                                                      //show cc prompt
//                                                      [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictFinInfo];
//                                                      isPromptShown =   YES;
//                                                  }
//                                              }
//                                                  break;
//                                                  
//                                              case CompleteYourProfile:   //3
//                                              {
//                                                  if(dictProfileInfo && ![dictProfileInfo[CONST_SERVER_IS_COMPLETE] boolValue] && ![dictProfileInfo[CONST_SERVER_IS_PROMPT_DISABLED] boolValue])
//                                                  {
//                                                      //sho evatar prompt
//                                                      [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictProfileInfo];
//                                                      isPromptShown =   YES;
//                                                  }
//                                              }
//                                                  break;
//                                                  
//                                              case AddDTCCOnFileNoEvatar: //7
//                                              {
//                                                  if(dictEvatarInfo && ![dictEvatarInfo[CONST_SERVER_IS_AVAIALBLE] boolValue] && ![dictEvatarInfo[CONST_SERVER_IS_PROMPT_DISABLED] boolValue])
//                                                  {
//                                                      //sho evatar prompt
//                                                      [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictEvatarInfo];
//                                                      isPromptShown =   YES;
//                                                  }
//                                              }
//                                                  break;
//                                                  
//                                              case UserNotification: //9
//                                              {
//                                                  if(dictUserNotification && ![dictUserNotification[@"is_complete"] boolValue] && ![dictEvatarInfo[@"is_disabled"] boolValue])
//                                                  {
//                                                      //sho evatar prompt
//                                                      [weakSelf showPromptWithCategoryKey:promptNumber.integerValue handlerDelegate:self dataDictionary:dictUserNotification];
//                                                      isPromptShown =   YES;
//                                                  }
//                                              }
//                                                  break;
//                                              default:
//                                                  break;
//                                          }
//                                          
//                                          if (isPromptShown)
//                                          {
//                                              return ;
//                                          }
//                                      }
//                                  });
//                              }
//                          }
//                          failure:^(NSError *error){
//                              dispatch_async_main(^{
//                                  NSLogError(@"%@",[error localizedDescription]);
//                                  [weakSelf hideActivityIndicator];
//                              });
//                          }];
//}
//
//-(void)showPromptWithCategoryKey:(InAppMessageCategory)inAppCategory
//                 handlerDelegate:(id)handlerDelegate
//                  dataDictionary:(NSDictionary*)infoDict
//{
//    switch (inAppCategory) {
//        case FilterPanelFirstTime:  //1
//        {
//            SelectEvPromptViewController    *controller =   [SelectEvPromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//            
//        }
//            break;
//            
//        case OnBootNoCCFile:    //2
//        {
//            NoCCOnFilePromptViewController    *controller =   [NoCCOnFilePromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            controller.infoDict =   infoDict;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case CompleteYourProfile:   //3
//        {
//            IncompleteProfilePromptViewController    *controller =   [IncompleteProfilePromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case NoCCTryToOrderCard:    //4
//        {
//            OrderCardNoCCPromptViewController    *controller =   [OrderCardNoCCPromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case AddConnectionFirstTime:    //5
//        {
//            AddConnectionPromptViewController    *controller =   [AddConnectionPromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case AddDTNoCCOnFile:   //6
//        {
//            AddTipsNoCCOnFilePromptViewController    *controller =   [AddTipsNoCCOnFilePromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case AddDTCCOnFileNoEvatar: //7
//        {
//            AddTipsNoEvatarPromptViewController    *controller =   [AddTipsNoEvatarPromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            controller.infoDict =   infoDict;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case AddDTNoCCNoEvatar: //8
//        {
//            AddTipsNoCCOnFilePromptViewController    *controller =   [AddTipsNoCCOnFilePromptViewController instantiateFromStoryboard];
//            controller.senderViewController =   handlerDelegate;
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//            
//        case UserNotification: //9
//        {
////            AddTipsNoCCOnFilePromptViewController    *controller =   [AddTipsNoCCOnFilePromptViewController instantiateFromStoryboard];
////            controller.senderViewController =   handlerDelegate;
////            [self presentViewController:controller animated:YES completion:nil];
//        }
//            break;
//        default:
//            break;
//    }
//}
//
//-(void)showConnectionFailureMessage:(NSError*)error
//{
//    
////    NSDictionary    *errorDict  =   [error userInfo];
////    
////    NSMutableString *strError   =   [[NSMutableString alloc] init];
////    if([errorDict respondsToSelector:@selector(allKeys)])
////    {
////        for (NSString *key in [errorDict allKeys])
////        {
////            if ([errorDict objectForKey:key])
////            {
////                [strError appendFormat:@"\n%@ - %@", key,[errorDict objectForKey:key]];
////            }
////        }
////    }
////    if ([Utils validateString:[error localizedDescription]].length > 0)
////    {
////        [strError appendFormat:@"\nlocalizedDescription - %@",[error localizedDescription]];
////    }
////    
////    if ([Utils validateString:[error localizedFailureReason]].length > 0)
////    {
////        [strError appendFormat:@"\nlocalizedFailureReason - %@",[error localizedFailureReason]];
////    }
////    
////    NSArray *arr    =   [error localizedRecoveryOptions];
////    
////    for (int index=0; index<[arr count]; index++)
////    {
////        if ([Utils validateString:[arr objectAtIndex:index]].length > 0)
////        {
////            [strError appendFormat:@"\n %@",[Utils validateString:[arr objectAtIndex:index]]];
////        }
////    }
////    
////    if ([Utils validateString:[error localizedRecoverySuggestion]].length > 0)
////    {
////        [strError appendFormat:@"\nlocalizedRecoverySuggestion - %@",[error localizedRecoverySuggestion]];
////    }
////    
////    [strError appendFormat:@"Error code - %ld",(long)[error code]];
////    [strError appendFormat:@"Error Domain - %@",[error domain]];
////    
////    NSLog(@"\n\n\n\n Error - %@ \n\n\n\n",strError);
//    
//    //    [self showAlertWithTitle:[error localizedDescription] message:strError delegate:nil];
////    NSLog(@"\n \n Error occured - %@",strError);
//    if([error code] != NSURLErrorCancelled || [error code] != NSURLErrorCannotFindHost || [error code] != NSURLErrorCannotConnectToHost)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kErrorInServiceResponse
//                                                            object:nil];
//        
//        NSString    *errorMsg   =   STR_ALERT_CANNOT_CONNECT_TO_HOST;
//        if ([error code] == -1009)
//        {
//            errorMsg    =   STR_ALERT_NETWORK_CONNECTION_REQUIRED;
//        }
//        
//        if (!av) {
//            av=  [[UIAlertView alloc] initWithTitle:@""
//                                            message:errorMsg
//                                       cancelButton:[BlockButton label:STR_BUTTON_TITLE_OK action:^{
//                av = nil;
//            }]
//                                       otherButtons:nil, nil];
//            [av show];
//        }
//    }
//    
//
//    [self hideActivityIndicator];
////    [Utils showAlertWithTitle:STR_ALERT_TITLE_CHARGEPOINT_ALERT message:errorMsg delegate:nil];
//}

-(void)showActivityIndicator
{
    NSLogInfo(@"");
    [self showActivityIndicator:[UIColor whiteColor]
                    isTextBlack:YES
                   activityText:NSLocalizedString(@"Resuming...", nil)
               showCancelButton:NO
               activityDelegate:nil];
}
@end
