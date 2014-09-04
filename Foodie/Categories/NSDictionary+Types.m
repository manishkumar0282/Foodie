//
// NSDictionary+Types.m
// UsefulBits
//
// Created by Kevin O'Neill on 11/11/11.
// Copyright (c) 2011 __MyCompanyName__. All rights reserved.
// https://github.com/kevinoneill/Useful-Bits/blob/master/UsefulBits/Foundation/NSDictionary%2BTypes.m

#import "NSDictionary+Types.h"

@implementation NSDictionary (Types)

- (id)objectForKey:(id)key ofType:(Class)type default:(id)defaultValue;
{
    id value = [self objectForKey:key];
    
    return [value isKindOfClass:type] ? value : defaultValue;
}

- (NSString *)stringForKey:(id)key default:(NSString *)defaultValue;
{
    return [self objectForKey:key ofType:[NSString class] default:defaultValue];
}

- (NSString *)stringForKey:(id)key;
{
    return [self stringForKey:key default:nil];
}

- (NSNumber *)numberForKey:(id)key default:(NSNumber *)defaultValue;
{
    return [self objectForKey:key ofType:[NSNumber class] default:defaultValue];
}

- (NSNumber *)numberForKey:(id)key;
{
    return [self numberForKey:key default:nil];
}

- (NSArray *)arrayForKey:(id)key default:(NSArray *)defaultValue;
{
    return [self objectForKey:key ofType:[NSArray class] default:defaultValue];
}

- (NSArray *)arrayForKey:(id)key;
{
    return [self arrayForKey:key default:nil];
}

- (NSDictionary *)dictionaryForKey:(id)key default:(NSDictionary *)defaultValue;
{
    return [self objectForKey:key ofType:[NSDictionary class] default:defaultValue];
}

- (NSDictionary *)dictionaryForKey:(id)key;
{
    return [self dictionaryForKey:key default:nil];
}

- (NSNumber *)numberWithUnsignedLongLongForKey:(id)key default:(NSNumber *)defaultValue
{
    id value = [self objectForKey:key];
    unsigned long long ullValue = 0;
    if ([value isKindOfClass:[NSNumber class]]) {
        ullValue = [(NSNumber *)value unsignedLongLongValue];
    }
    else if([value isKindOfClass:[NSString class]]){
        ullValue = [(NSString *)value unsignedLongLongValue];
    }
    else{
        return defaultValue;
    }
    NSNumber *number = [NSNumber numberWithUnsignedLongLong:ullValue];
    return number;
}

- (NSNumber *)numberWithUnsignedLongLongForKey:(id)key
{
    return [self numberWithUnsignedLongLongForKey:key default:nil];
}

- (NSNumber *)numberWithIntegerForKey:(id)key default:(NSNumber *)defaultValue
{
    id value = [self objectForKey:key];
    NSInteger lValue = 0;
    if ([value isKindOfClass:[NSNumber class]]) {
        lValue = [(NSNumber *)value integerValue];
    }
    else if([value isKindOfClass:[NSString class]]){
        lValue = [(NSString *)value integerValue];
    }
    else{
        return defaultValue;
    }
    NSNumber *number = [NSNumber numberWithInteger:lValue];
    return number;
}

- (NSNumber *)numberWithIntegerForKey:(id)key
{
    return [self numberWithIntegerForKey:key default:nil];
}

- (NSNumber *)numberWithUnsignedIntegerForKey:(id)key default:(NSNumber *)defaultValue
{
    id value = [self objectForKey:key];
    NSUInteger lValue = 0;
    if ([value isKindOfClass:[NSNumber class]]) {
        lValue = [(NSNumber *)value unsignedIntegerValue];
    }
    else if([value isKindOfClass:[NSString class]]){
        lValue = [(NSString *)value unsignedIntegerValue];
    }
    else{
        return defaultValue;
    }
    NSNumber *number = [NSNumber numberWithUnsignedInteger:lValue];
    return number;
}

- (NSNumber *)numberWithUnsignedIntegerForKey:(id)key
{
    return [self numberWithUnsignedIntegerForKey:key default:nil];
}

@end