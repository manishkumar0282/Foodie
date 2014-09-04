//
//  UIViewController+Blocks.h
//
//  Created by Navi Singh on 6/17/13.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Blocks)

- (void)onViewDidLoad:(VoidBlock)block;

- (void)onViewDidAppear:(VoidBlock)block;
- (void)onNextViewDidAppear:(VoidBlock)block;

- (void)onViewDidDisappear:(VoidBlock)block;
- (void)onNextViewDidDisappear:(VoidBlock)block;

@end
