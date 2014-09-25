//
//  HotelListVC+TopBar.m
//  Foodie
//
//  Created by Manish Kumar on 9/8/14.
//  Copyright (c) 2014 Manish Kumar. All rights reserved.
//

#import "HotelListVC+TopBar.h"
//#import "SearchPanelVC.h"
#import "ChooseSpotVC.h"
#import "LeftFilterPanel.h"

@implementation HotelListVC (TopBar)
-(void)topBarViewDidLoad
{
//    UILongPressGestureRecognizer* lpgr = [[UILongPressGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(handleLongPressOnSearchButton:)];
//    lpgr.minimumPressDuration = 1.0f; //user needs to press for 1 seconds
//    lpgr.delegate = self;
//    [self.searchButton addGestureRecognizer:lpgr];
}
-(void)topBarViewDidAppear:(BOOL)animated
{

}
-(void)topBarViewDidDisappear:(BOOL)animated
{

}

- (IBAction)didTouchFilterButton:(id)sender {
    NSLogUser(@"");
//    LeftFilterPanel *leftPanel  =   [LeftFilterPanel instantiateFromStoryboard];

//    if ([self.slidingPanel isKindOfClass:LeftPanel.class]) {
//        [self.filterButton setSelected:NO];
//
//        [self.slidingPanel slideOutToLeft:^(BOOL done){
//            if ([self.slidingPanel canPerformAction:@selector(saveFilterValuesOnHidingFilterView) withSender:nil]) {
//                [self.slidingPanel performSelector:@selector(saveFilterValuesOnHidingFilterView) withObject:nil];
//            }
//            self.SlidingPanel = nil;
//        }];
//        return;
//    }

//    LeftPanel *panel = [LeftPanel createPanel];
//    [self setSlidingPanel:panel];
//    [self.btnFilter setSelected:YES];
    self.btnFilter.selected =   !self.btnFilter.selected;

    NSString    *strMessage =   @"show filter";
    if (!self.btnFilter.selected) {
strMessage =   @"hide filter";
    }

    [UIAlertView showWithMessage:strMessage];
//    CGPoint adjust = [self.btnFilter convertPoint:self.btnFilter.frame.origin toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
//
//    CGFloat top = self.btnFilter.bottom + adjust.y;
//    leftPanel.view.top = top;
//
//    CGSize bounds = [UIApplication sharedApplication].keyWindow.rootViewController.view.frame.size;
//    CGFloat bottom = self.isLandscape ? bounds.width : bounds.height;
//
//    [leftPanel.view adjustBottomTo:bottom];
//    [leftPanel slideInFromLeft:nil];
}

- (IBAction)didTouchSearchButton:(id)sender {
    NSLogUser(@"");
//    self.view.top = -self.view.frame.size.height;
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         self.view.top = 20;
//                     }
//                     completion:nil];
//    SearchPanel *panel = [SearchPanel createPanel];
//    [self setSlidingPanel:panel];
//
//    [panel slideInFromTop:nil];
}
@end
