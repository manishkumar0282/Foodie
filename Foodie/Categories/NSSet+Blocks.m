//
//  NSSet+Blocks.m
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//

#import "NSSet+Blocks.h"

@implementation NSSet (Blocks)

//return the set of all objects where the block returns YES
- (NSSet *)select:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);
    
    return [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        return (block(obj));
    }];
}

//return a set of all objects where the block returns NO
- (NSSet *)reject:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);
    
    return [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        return (!block(obj));
    }];
}

- (NSSet *)map:(id (^)(id obj))block {
	NSParameterAssert(block != nil);
    
	NSMutableSet *result = [[NSMutableSet alloc] initWithCapacity:self.count];
    
	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		id value = block(obj);
        if (value)
            [result addObject:value];
//        else //Do we really want to add a nul to the set?
//            [result addObject:[NSNull null]];
	}];
    
	return result;
}

- (NSSet *)minus:(NSSet *)set
{
    NSMutableSet *mutableSet = [self mutableCopy];
    [mutableSet minusSet:set];
    return mutableSet;
}

- (NSSet *)intersect:(NSSet *)set
{
    NSMutableSet *mutableSet = [self mutableCopy];
    [mutableSet intersectSet:set];
    return mutableSet;
}

- (NSSet *)union:(NSSet *)set
{
    NSMutableSet *mutableSet = [self mutableCopy];
    [mutableSet unionSet:set];
    return mutableSet;
}

// match: is functionally identical to select:,
//        but will stop and return on the first match.
- (id)match:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);
    
    return [[self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        if (block(obj)) {
            *stop = YES;
            return YES;
        }
        return NO;
    }] anyObject];
}

//iterate over each entry using the block
- (void)each:(void(^)(id)) block
{
	NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj);
    }];
}

//return YES, if any object in array has block return YES
- (BOOL)any:(BOOL (^)(id obj))block
{
	return [self match: block] != nil;
}

//return YES if no object in array has block return YES
- (BOOL)none:(BOOL (^)(id obj))block
{
	return [self match: block] == nil;
}

//return YES if all objects in array have block return YES
- (BOOL)all:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if (!block(obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    
    return result;}

@end
