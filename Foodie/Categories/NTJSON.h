
//
//  NTJSON.h
//
//  Created by Manish Kumar - Imported on 10/7/13.
//
//

#import <Foundation/Foundation.h>

@interface NTJSON : NSObject

- (id)initWithArray:(NSArray *)array;
- (id)initWithDictionary:(NSDictionary *)dict;
- (id)objectForKeyedSubscript:(NSString *)key;
- (id)objectAtIndexedSubscript: (NSUInteger)index;
- (NSUInteger)count;

- (void)setObject:(id)obj atIndexedSubscript:(NSInteger)index;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)subscript;

- (id)valueForKeyPath:(NSString *)keyPath;

- (NSMutableDictionary *)dictionary;
- (NSMutableArray *)array;
+ (NTJSON *)dictionary:(NSDictionary *)jsonDict;
+ (NTJSON *)array:(NSArray *)jsonArray;

- (void)addObjectInFrontToArray:(id)object;


//additions from dictionary category
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
