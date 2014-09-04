//
//  NSObject+Swizzle.h
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//  http://blog.carbonfive.com/2013/02/20/monkey-patching-ios-with-objective-c-categories-part-iii-swizzling/
/*
 * Use swizzling to preserve the original method behavior 
   instead of simply overriding to avoid side-effects.
 * Swizzling is simply the exchange of the identifiers 
   of two methods so they point to each other’s implementations.
 * After swizzling you invoke the original method’s implementation
   but calling the new implementations identifier.
 * Swizzle in the +load method of your category.
 
// Here is a sample of how this category is to be used.
@implementation UIViewController (mySwizzle)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewWillAppear:)
                 withSelector:@selector(myViewWillAppear:)];
    });
}
@end
*/

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

//Always swizzle on the class level load.
//and wrap it up in a dispatch_once
//see usage example below
+ (void)swizzleSelector:(SEL)originalSelector
           withSelector:(SEL)newSelector;

//+ (BOOL)addSelector:(SEL)newSelector;

+ (BOOL)addSelector:(SEL)selector imp:(IMP)staticVoidIMPVoidmethod;
+ (BOOL)addSelector:(SEL)selector imp:(IMP)staticIMPmethod type:(const char *)type;

+ (BOOL)isLandscape;
- (BOOL)isLandscape;
+ (BOOL)isPortrait;
- (BOOL)isPortrait;
+ (BOOL)isIOS6;
- (BOOL)isIOS6;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end


