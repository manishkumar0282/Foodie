//
//  NSDictionary+Types.h
//
// Created by Kevin O'Neill on 11/11/11.
// Copyright (c) 2011 __MyCompanyName__. All rights reserved.
// https://github.com/kevinoneill/Useful-Bits/blob/master/UsefulBits/Foundation/NSDictionary%2BTypes.h

#import <Foundation/Foundation.h>

@interface NSDictionary (Types)

- (NSString *)stringForKey:(id)key;
- (NSString *)stringForKey:(id)key default:(NSString *)defaultValue;

- (NSNumber *)numberForKey:(id)key default:(NSNumber *)defaultValue;
- (NSNumber *)numberForKey:(id)key;

- (NSArray *)arrayForKey:(id)key default:(NSArray *)defaultValue;
- (NSArray *)arrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key default:(NSDictionary *)defaultValue;
- (NSDictionary *)dictionaryForKey:(id)key;

//Useful functions for dealing with json values.
//large ints are returned as strings
//small ints are returned as numbers
//This allows us to avoid testing for return type.
- (NSNumber *)numberWithUnsignedLongLongForKey:(id)key;
- (NSNumber *)numberWithUnsignedLongLongForKey:(id)key default:(NSNumber *)defaultValue;

- (NSNumber *)numberWithIntegerForKey:(id)key;
- (NSNumber *)numberWithIntegerForKey:(id)key default:(NSNumber *)defaultValue;

- (NSNumber *)numberWithUnsignedIntegerForKey:(id)key;
- (NSNumber *)numberWithUnsignedIntegerForKey:(id)key default:(NSNumber *)defaultValue;

@end