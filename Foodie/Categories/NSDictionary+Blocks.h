//
//  NSDictionary+Blocks.h
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
// Based on:
// https://github.com/zwaldowski/BlocksKit/blob/master/BlocksKit/NSArray%2BBlocksKit.h

#import <Foundation/Foundation.h>

@interface NSDictionary (Blocks)

//return an array of all objects where the block returns YES
- (NSDictionary *)select:(BOOL (^)(id key, id obj))block;

//return an array of all objects where the block returns NO
- (NSDictionary *)reject:(BOOL (^)(id key, id obj))block;

- (NSDictionary *)minus:(NSDictionary *)set;

//changes the values of the dictionary using the block.
- (NSDictionary *)map:(id (^)(id key, id value))block;

// match: is functionally identical to select:,
//        but will stop and return on the first match.
- (id)match:(BOOL (^)(id key, id obj))block;

//iterate over each entry using the block
- (void)each:(void(^)(id key, id obj)) block;

//return YES, if any object in array has block return YES
- (BOOL)any:(BOOL (^)(id key, id obj))block;

//return YES if no object in array has block return YES
- (BOOL)none:(BOOL (^)(id key, id obj))block;

//return YES if all objects in array have block return YES
- (BOOL)all:(BOOL (^)(id key, id obj))block;

- (NSString *)json;
@end
