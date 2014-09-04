//
//  ACDeallocHandler.h
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//  Because we cannot add dealloc to a category.

#import <Foundation/Foundation.h>

@interface NSObject (deallocBlock)

- (void)addDeallocBlock:(void (^)(void))theBlock;

@end