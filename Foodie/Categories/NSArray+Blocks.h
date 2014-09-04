//
//  NSArray+Extras.h
//
//  Created by Manish Kumar - Imported on 3/29/14.
// Based on:
// https://github.com/zwaldowski/BlocksKit/blob/master/BlocksKit/NSArray%2BBlocksKit.h

#import <Foundation/Foundation.h>

@interface NSArray (Extras)

//return an array of all objects where the block returns YES
- (NSArray *)select:(BOOL (^)(id obj))block;

//return an array of all objects where the block returns NO
- (NSArray *)reject:(BOOL (^)(id obj))block;

//returns an array of transformed values.
- (NSArray *)map:(id (^)(id obj))block;

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

- (NSString *)json;


@end
