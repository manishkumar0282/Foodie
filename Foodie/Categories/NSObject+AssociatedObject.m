//
//  NSObject+AssociatedObject.m
//
//  Created by Navi Singh on 2/13/14.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

- (const void *)staticClassIdentifier
{
//  You need to implement this method in the derived class as shown below.
//  static char ASSOCIATED_OBJECT_IDENTIFIER;
//  return &ASSOCIATED_OBJECT_IDENTIFIER;

    return nil;
}

//You probably want to do this in the dealloc method of your class as well.
//- (void) dealloc
//{
//    [self setObjectAssociatedWithInstance:nil];
//}

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

//Alternate implementation.
//do we even need the objectAssociatedWithClass?
- (void)setAssociatedObject:(id)obj
{
    [self setAssociatedObject:obj forKey:self policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}
- (void)setAssociatedObject:(id)obj forKey:(id)key policy:(objc_AssociationPolicy) policy
{
    id prevObj =  objc_getAssociatedObject(self, (__bridge void *)self);

    if (prevObj && obj == nil)
        objc_setAssociatedObject(self, (__bridge void *)key, nil, policy);
    else
        objc_setAssociatedObject(self, (__bridge void *)key, obj, policy);
}

- (id)associatedObject
{
    return [self associatedObject_forKey:self];
}
- (id)associatedObject_forKey:(id)key
{
    id obj =  objc_getAssociatedObject(self, (__bridge void *)key);
    return obj;
}

@end
