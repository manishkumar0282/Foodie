//
//  UINavigationController+Blocks.h
//
//  Created by Manish Kumar - Imported on 2/13/14.
//

#import <UIKit/UIKit.h>
#import "NSObject+AssociatedObject.h"

@interface UINavigationController (Blocks)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void (^)())completion;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)())completion;

@end
