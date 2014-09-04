//
//  NSObject+AssociatedObject.h
//
//  Created by Manish Kumar - Imported on 2/13/14.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)

- (void)setObjectAssociatedWithInstance:(NSDictionary *)obj;
- (NSDictionary *)objectAssociatedWithInstance;

//You need to implement this method in your class
- (const void *)staticClassIdentifier;
//{
//  Your implmentation could look like this:
//  static char ASSOCIATED_OBJECT_IDENTIFIER;
//  return &ASSOCIATED_OBJECT_IDENTIFIER;
//}

//You probably want to do this in the dealloc method of your class as well.
//if the underlying implementation implements dealloc, you have two choices
//1.  make sure that you call [self setObjectAssociatedWithInstance:nil] at
//    the appropriate point in your code.
//2.  swizzle dealloc and ensure that this happens.
//- (void) dealloc
//{
//    [self setObjectAssociatedWithInstance:nil];
//}


//========================================
//alternate implementation using retain.  object deallocated on dealloc
- (id)associatedObject;
- (void)setAssociatedObject:(id)obj;
- (void)setAssociatedObject:(id)obj forKey:(id)key policy:(uintptr_t)policy;

@end
