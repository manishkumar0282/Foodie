//
//  NSDictionary+Blocks.m
//
//  Created by Navi Singh on 3/29/14.
//
//

#import "NSDictionary+Blocks.h"

@implementation NSDictionary (Blocks)

//return an array of all objects where the block returns YES
- (NSDictionary *)select:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);
    
    NSArray *keys = [[self keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^(id key, id obj, BOOL *stop) {
        return block(key, obj);
    }] allObjects];
    
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

//return an array of all objects where the block returns NO
- (NSDictionary *)reject:(BOOL (^)(id key, id obj))block
{
	return [self select:^BOOL(id key, id obj) {
        return !block(key, obj);
    }];
}

- (NSDictionary *)minus:(NSDictionary *)dict
{
	NSMutableDictionary *result = [self mutableCopy];
    for (id key in [dict allKeys]) {
        [result removeObjectForKey:key];
    }
    return result;
}

- (NSDictionary *)map:(id (^)(id key, id value))block
{
	NSParameterAssert(block != nil);
    
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
	[self each:^(id key, id value) {
		id newValue = block(key, value);
		if (newValue)
            [result setObject:newValue forKey:key];
        else
            [result setObject:[NSNull null] forKey:key];
	}];
    
	return result;
}
// match: is functionally identical to select:,
//        but will stop and return on the first match.
- (id)match:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);
    
    id matchingKey = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        if (block(key, obj)) {
            *stop = YES;
            return YES;
        }
        return NO;
    }] anyObject];
    
    return [self objectForKey:matchingKey];
}

//iterate over each entry using the block
- (void)each:(void(^)(id key, id obj)) block
{
	NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

//return YES, if any object in array has block return YES
- (BOOL)any:(BOOL (^)(id key, id obj))block
{
	return [self match: block] != nil;
}

//return YES if no object in array has block return YES
- (BOOL)none:(BOOL (^)(id key, id obj))block
{
	return [self match: block] == nil;
}

//return YES if all objects in array have block return YES
- (BOOL)all:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (!block(key, obj)) {
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
