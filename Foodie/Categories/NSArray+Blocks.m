//
//  NSArray+Extras.m
//
//  Created by Navi Singh on 3/29/14.
//

#import "NSArray+Blocks.h"

@implementation NSArray (Extras)

- (NSArray *)select:(BOOL (^)(id obj))block
{
    if (block) {
        NSIndexSet * filteredIndexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return block(obj);
        }];
        return [self objectsAtIndexes:filteredIndexes];
    }
    return nil;
}

- (NSArray *)reject:(BOOL (^)(id obj))block {
    if (block) {
        return [self select:^BOOL(id obj) {
            return !block(obj);
        }];
    }
    return nil;
}

- (NSArray *)map:(id (^)(id obj))block {
	NSParameterAssert(block != nil);
    
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
	[self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		id value = block(obj);
		if (!value)
			value = [NSNull null];
        
		[result addObject:value];
	}];
    
	return result;
}

- (void) each:(void(^)(id)) block
{
    if (block) {
        [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj);
        }];
    }
}

- (id)match:(BOOL (^)(id obj))block {
    if(block){
        NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return block(obj);
        }];
        
        if (index == NSNotFound)
            return nil;
        
        return [self objectAtIndex:index];
    }
    return nil;
}


- (BOOL)any:(BOOL (^)(id obj))block {
    return [self match: block] != nil;
}

- (BOOL)none:(BOOL (^)(id obj))block {
    return [self match: block] == nil;
}

- (BOOL)all:(BOOL (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (!block(obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    
    return result;
}

- (NSString *)json
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self  options:NSJSONWritingPrettyPrinted error: &error];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (error) {
        return self.description;
    }
    return json;
}


@end
