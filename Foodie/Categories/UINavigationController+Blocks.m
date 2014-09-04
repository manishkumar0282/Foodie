//
//  UINavigationController+Blocks.m
//
//  Created by Manish Kumar - Imported on 2/13/14.
//

#import "UINavigationController+Blocks.h"
#import <objc/runtime.h>


@interface UINavigationController ()<UINavigationControllerDelegate>
@end

@implementation UINavigationController (Blocks)

- (const void *)staticClassIdentifier
{
    static char ASSOCIATED_OBJECT_IDENTIFIER;
    return &ASSOCIATED_OBJECT_IDENTIFIER;
}

- (void) dealloc
{
    [self setObjectAssociatedWithInstance:nil];
}
/*
- (NSMutableDictionary *)objectAssociatedWithClass
{
    //first get the associated object for this class.
    NSMutableDictionary *objectAssociatedWithClass;
    {
        NSDictionary *obj =  objc_getAssociatedObject(self.class, self.staticClassIdentifier);
        if (obj)
            objectAssociatedWithClass = [obj mutableCopy];
        else
            objectAssociatedWithClass = [NSMutableDictionary dictionary];
    }
    return objectAssociatedWithClass;
}

- (void)setObjectAssociatedWithInstance:(NSDictionary *)obj
{
    if (self.staticClassIdentifier == nil) {
        if (obj == nil)
            return;
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"You must implement \"-staticClassIdentifier\" in class %@", NSStringFromClass(self.class)]
                                     userInfo:nil];
    }

    //first get the associated object for this class.
    NSMutableDictionary *objectAssociatedWithClass = [self objectAssociatedWithClass];
    if (obj)
        [objectAssociatedWithClass setObject:obj forKey:[NSValue valueWithNonretainedObject:self]];
    else
        [objectAssociatedWithClass removeObjectForKey:[NSValue valueWithNonretainedObject:self]];

    objc_setAssociatedObject(self.class, self.staticClassIdentifier, objectAssociatedWithClass, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)objectAssociatedWithInstance
{
    //first get the associated object for this class.
    NSMutableDictionary *objectAssociatedWithClass = [self objectAssociatedWithClass];
    NSDictionary *obj = [objectAssociatedWithClass objectForKey:[NSValue valueWithNonretainedObject:self]];
    return obj;
}
*/


static NSString *kCompletion = @"completion";
static NSString *kDelegate = @"delegate";

- (void)saveCompletionHandler:(void (^)())completion
{
    if (completion){
        if (self.delegate)
            [self setObjectAssociatedWithInstance:@{kCompletion: completion, kDelegate : self.delegate}];
        else
            [self setObjectAssociatedWithInstance:@{kCompletion: completion}];

        //we want to grab the delegate callbacks
        self.delegate = self;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion
{
    [self saveCompletionHandler:completion];

    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void (^)())completion
{
    [self saveCompletionHandler:completion];

    return [self popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)())completion
{
    [self saveCompletionHandler:completion];

    return [self popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)())completion
{
    [self saveCompletionHandler:completion];

    return [self popToRootViewControllerAnimated:animated];
}

//========================================================================================
#pragma mark Forward all of the delegates.
// (all of this comes into play only if we passed in a completion handler).
//========================================================================================
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    if ([delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
        [delegate navigationController:navigationController didShowViewController:viewController animated:animated];

    /////////////////////////////////////////////////
    //This call is the reason for the whole exercise!
    /////////////////////////////////////////////////
    void (^completion)() = objectAssociatedWithInstance[kCompletion];
    if (completion)
        completion();
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    //simply forward the notification.
    if ([delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
        [delegate navigationController:navigationController willShowViewController:viewController animated:animated];
}

- (NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0)
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    if ([delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)])
        return [delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    return UIInterfaceOrientationMaskAll; //TBD: not sure about the default value
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0)
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    if ([delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)])
        return [delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    return UIInterfaceOrientationPortrait; //TBD: not sure about the default value
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    if ([delegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)])
        return [delegate navigationController:navigationController interactionControllerForAnimationController:animationController];
    return nil; //TBD: not sure about the default value.
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    NSDictionary *objectAssociatedWithInstance = [self.class objectAssociatedWithInstance];
    id<UINavigationControllerDelegate> delegate = objectAssociatedWithInstance[kDelegate];

    if ([delegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)])
        return [delegate navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    return nil; //TBD: not sure about the default value.
}


@end
