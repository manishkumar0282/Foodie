//
//  NSMutableArray+Stack.m
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (void) push:(id)entry
{
    if (entry == nil)
        entry = [NSNull null];
    [self addObject:entry];
}

- (instancetype) pop
{
    if ([self count] == 0) {
        DDLogError(@"Inconsistent use of stack.  Why are you popping an empty stack?");
        return nil;
    }
    unsigned long pos = [self  count]-1;
    id entry = [self objectAtIndex:pos];
    [self removeObjectAtIndex:pos];
    return entry;
}

- (instancetype) pop_bottom
{
    if ([self count] == 0) {
        DDLogError(@"Inconsistent use of stack.  Why are you popping an empty stack?");
        return nil;
    }
    int pos = 0;
    id entry = [self objectAtIndex:pos];
    [self removeObjectAtIndex:pos];
    return entry;
}

- (instancetype) top
{
    if ([self count] == 0)
        return nil;
    return [self objectAtIndex:[self  count]-1];
}

- (instancetype) bottom
{
    if ([self count] == 0)
        return nil;
    return [self objectAtIndex:0];
}

- (void) clear
{
    [self removeAllObjects];
}

- (int) size
{
    return (int)[self count];
}

- (BOOL) isEmpty
{
    return [self count] == 0;
}

- (void) forEachFIFO:(void(^)(id)) block
{
    if (block) {
        for (id entry in self) {
            block(entry);
        }
    }
}

- (void) forEachLIFO:(void(^)(id)) block
{
    if (block) {
        for (id entry in [self reverseObjectEnumerator]) {
            block(entry);
        }
    }
}

@end
