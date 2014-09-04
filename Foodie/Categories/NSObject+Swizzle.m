//
//  NSObject+Swizzle.m
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)swizzleSelector:(SEL)originalSelector
           withSelector:(SEL)newSelector
{
    //References to the methods the selectors point to (represented by the Method data type) are then retrieved.
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    //We first attempt to add the implementation of the new method under the selector of the original method. We do this in case the original method doesn’t truly exist, which is sometimes a possibility
    BOOL methodAdded = class_addMethod([self class],
                                       originalSelector,
                                       method_getImplementation(newMethod),
                                       method_getTypeEncoding(newMethod));
    
    if (methodAdded) {
        //If the method was added successfully we need SOMETHING under the selector of the new method, so we simply replace it with the original method’s (empty) implementation.
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        //If we failed to add the method, the original method already exists, so we can simply exchange their implementations
        method_exchangeImplementations(originalMethod, newMethod);
    }
    
    //Any calls to the original method will now be directed to the new implementation while the original implementation can be invoked under the name of the new method!
}

//+ (BOOL)addSelector:(SEL)newSelector
//{
//    Method newMethod = class_getInstanceMethod(self, newSelector);
//    BOOL methodAdded = class_addMethod([self class],
//                                       newSelector,
//                                       method_getImplementation(newMethod),
//                                       method_getTypeEncoding(newMethod));
//    return methodAdded;
//}

+ (BOOL)addSelector:(SEL)selector imp:(IMP)staticIMPmethod
{
    const char *retType = @encode(void);
    const char *methodType = [[NSString stringWithFormat:@"%s@:", retType] UTF8String];
       
    // now add our method
    BOOL methodAdded = class_addMethod([self class],
                                       selector,
                                       (IMP)staticIMPmethod,
                                       methodType);
    return methodAdded;
}

+ (BOOL)addSelector:(SEL)selector imp:(IMP)staticIMPmethod type:(const char *)type
{
    BOOL methodAdded = class_addMethod([self class],
                                       selector,
                                       (IMP)staticIMPmethod,
                                       type);
    return methodAdded;
}

+(BOOL) isLandscape
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return YES;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        default:
            return NO;
    }
}
- (BOOL)isLandscape
{
    return [self.class isLandscape];
}
+ (BOOL)isPortrait
{
    return ![self.class isLandscape];
}
- (BOOL)isPortrait
{
    return ![self.class isLandscape];
}

+ (BOOL)isIOS6 {
	if (UIDevice.currentDevice.systemVersion.floatValue < 7.0f)
		return YES;
	return NO;
}
- (BOOL)isIOS6 {
    return [self.class isIOS6];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}


@end