//
//  NTJSON.m
//
//  Created by Manish Kumar - Imported on 10/7/13.
//
//

#import "NTJSON.h"
#import "NSDictionary+Types.h"

@interface NTJSON ()
@property (nonatomic, strong) NSMutableArray *jsonArray;
@property (nonatomic, strong) NSMutableDictionary *jsonDict;
@end

@implementation NTJSON

-(NSString *)description
{
    if (self.jsonArray) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jsonArray  options:NSJSONWritingPrettyPrinted error: &error];
        NSString* value = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return value;
        return self.jsonArray.description;
    }
    if (self.jsonDict) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jsonDict  options:NSJSONWritingPrettyPrinted error: &error];
        NSString* value = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

        return value;
    }
    return [super description];
}

- (id)debugQuickLookObject
{
    if (self.dictionary) {
        return [self.dictionary json];
    }
    if (self.array) {
        return [self.array json];
    }
    return self.description;
}


- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(dict.classForCoder == NSMutableDictionary.class)
        self.jsonDict = (NSMutableDictionary *)dict;
    else
        self.jsonDict = [dict mutableCopy];
    
    return self;
}

- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    
    if(array.classForCoder == NSMutableArray.class)
        self.jsonArray = (NSMutableArray *)array;
    else
        self.jsonArray = [array mutableCopy];
    
    return self;
}

- (void)setObject:(id)obj atIndexedSubscript:(NSInteger)index
{
    if (self.jsonArray) {
        if ([obj isKindOfClass:NTJSON.class]) {
            NTJSON *json = obj;
            if (json.dictionary)
                [self.jsonArray setObject:json.dictionary atIndexedSubscript:index];
            else if(json.array)
                [self.jsonArray setObject:json.array atIndexedSubscript:index];
        }
        else
            [self.jsonArray setObject:obj atIndexedSubscript:index];
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if (self.jsonDict && key) {
        if ([obj isKindOfClass:NTJSON.class]) {
            NTJSON *json = obj;
            if (json.dictionary)
                [self.jsonDict setObject:json.dictionary forKeyedSubscript:key];
            else if(json.array)
                [self.jsonDict setObject:json.array forKeyedSubscript:key];
        }
        else
            [self.jsonDict setObject:obj forKeyedSubscript:key];
    }
}

- (id)objectForKeyedSubscript:(NSString *)key
{
    if (key == nil)
        return nil;
    id obj = [self.jsonDict valueForKeyPath:key];
    if ([obj isKindOfClass:NSNull.class]) {
        return nil;
    }
    if (obj == nil) {
        return nil;
    }
    return [self object:obj];
}

- (id)objectAtIndexedSubscript: (NSUInteger)index
{
    if (index >= self.jsonArray.count) {
        return nil;
    }
    id obj = self.jsonArray[index];
    if ([obj isKindOfClass:NSNull.class]) {
        return nil;
    }    
    if (obj == nil) {
        return nil;
    }
    return [self object:obj];
}

- (id)object:(id)obj
{
    if ([obj isKindOfClass:NSDictionary.class]) {
        return [NTJSON dictionary:obj];
    }
    if ([obj isKindOfClass:NSArray.class]) {
        return [NTJSON array:obj];
    }
    if ([obj isKindOfClass:NSNull.class]) {
        return nil;
    }
    if (obj == nil) {
        return nil;
    }
    
    return obj;
}

- (NSUInteger)count
{
    if(self.jsonArray)
        return self.jsonArray.count;
    if(self.jsonDict)
        return self.jsonDict.count;
    return 0;
}

//======
- (id)valueForKeyPath:(NSString *)keyPath
{
    id obj = [self.dictionary valueForKeyPath:keyPath];
    
    if ([obj isKindOfClass:NSDictionary.class]) {
        return [NTJSON dictionary:obj];
    }
    if ([obj isKindOfClass:NSArray.class]) {
        return [NTJSON array:obj];
    }
    if ([obj isKindOfClass:NSNull.class]) {
        return nil;
    }
    if (obj == nil) {
        return nil;
    }
    
    return obj;
}

- (id)objectForKey:(id)keyPath ofType:(Class)type default:(id)defaultValue;
{
    id value = [self.dictionary valueForKeyPath:keyPath];
    
    return [value isKindOfClass:type] ? value : defaultValue;
}

- (NSString *)stringForKey:(id)key default:(NSString *)defaultValue;
{
    return [self objectForKey:key ofType:[NSString class] default:defaultValue];
}

- (NSString *)stringForKey:(id)key;
{
    return [self.dictionary stringForKey:key default:nil];
}

- (NSNumber *)numberForKey:(id)key default:(NSNumber *)defaultValue;
{
    return [self objectForKey:key ofType:[NSNumber class] default:defaultValue];
}

- (NSNumber *)numberForKey:(id)key;
{
    return [self.dictionary numberForKey:key default:nil];
}

- (NSArray *)arrayForKey:(id)key default:(NSArray *)defaultValue;
{
    return [self objectForKey:key ofType:[NSArray class] default:defaultValue];
}

- (NSArray *)arrayForKey:(id)key;
{
    return [self.dictionary arrayForKey:key default:nil];
}

- (NSDictionary *)dictionaryForKey:(id)key default:(NSDictionary *)defaultValue;
{
    return [self objectForKey:key ofType:[NSDictionary class] default:defaultValue];
}

- (NSDictionary *)dictionaryForKey:(id)key;
{
    return [self.dictionary dictionaryForKey:key default:nil];
}

- (NSNumber *)numberWithUnsignedLongLongForKey:(id)key default:(NSNumber *)defaultValue
{
    id value = [self objectForKeyedSubscript:key];
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
    id value = [self objectForKeyedSubscript:key];
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
    id value = [self objectForKeyedSubscript:key];
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

//======
- (NSMutableDictionary *)dictionary
{
    return self.jsonDict;
}

- (NSMutableArray *)array
{
    return self.jsonArray;
}

+ (NTJSON *)dictionary:(NSDictionary *)jsonDict
{
    NTJSON *json = [[NTJSON alloc] initWithDictionary:jsonDict];
    return json;
}

+ (NTJSON *)array:(NSArray *)jsonArray
{
    NTJSON *json = [[NTJSON alloc] initWithArray:jsonArray];
    return json;
}

- (void)addObjectInFrontToArray:(id)obj
{
    [self.jsonArray insertObject:obj atIndex:0];
}


@end
