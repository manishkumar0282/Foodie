//
//  NSMutableArray+Stack.h
//
//  Created by Navi Singh on 3/29/14.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (void) push:(id)entry; //add an entry to the stack.
- (instancetype) pop; //return the last pushed entry, and pop the stack.LIFO
- (instancetype) top; //return the last pushed entry. Does not change the stack.LIFO
- (instancetype) pop_bottom; //return the first pushed entry, and pop the first pushed entry FIFO.
- (instancetype) bottom; //return the first pushed entry. does not change the stack.
- (void) clear;   //erase the stack.
- (int) size;     //number of items in the stack.
- (BOOL) isEmpty; //whether the stack is empty.

- (void) forEachFIFO:(void(^)(id)) block; //iterate over entries in the stack.
- (void) forEachLIFO:(void(^)(id)) block; //iterate over entries in the stack.

@end
