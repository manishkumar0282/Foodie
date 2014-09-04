//
//  NSSet+Blocks.h
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
// Based on:
// https://github.com/zwaldowski/BlocksKit/blob/master/BlocksKit/NSArray%2BBlocksKit.h

#import <Foundation/Foundation.h>

@interface NSSet (Blocks)

//return the set of all objects where the block returns YES
- (NSSet *)select:(BOOL (^)(id obj))block;

//return a set of all objects where the block returns NO
- (NSSet *)reject:(BOOL (^)(id obj))block;

- (NSSet *)map:(id (^)(id obj))block;

- (NSSet *)minus:(NSSet *)set;
- (NSSet *)intersect:(NSSet *)set;
- (NSSet *)union:(NSSet *)set;

// match: is functionally identical to select:,
//        but will stop and return on the first match.
- (id)match:(BOOL (^)(id obj))block;

//iterate over each entry using the block
- (void)each:(void(^)(id)) block;

//return YES, if any object in array has block return YES
- (BOOL)any:(BOOL (^)(id obj))block;

//return YES if no object in array has block return YES
- (BOOL)none:(BOOL (^)(id obj))block;

//return YES if all objects in array have block return YES
- (BOOL)all:(BOOL (^)(id obj))block;

@end
