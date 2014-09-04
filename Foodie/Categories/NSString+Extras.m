//
//  NSString+Extras.m
//
//  Created by Navi Singh on 3/29/14.
//
//

#import "NSString+Extras.h"
#import <CommonCrypto/CommonCryptor.h>

#define Const_EncrytpionKey @"!@#$%^&*"

@implementation NSString (Extras)

+ (NSString *)stringFromCGRect:(CGRect)rect
{
    NSString *desc = [NSString stringWithFormat:@"x:%4.0f y:%4.0f w:%4.0f h:%4.0f"
                      , rect.origin.x
                      , rect.origin.y
                      , rect.size.width
                      , rect.size.height
                      ];
    return desc;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)firstPathComponent
{
    NSRange range = [self rangeOfString:@"/"];
    if(range.location == NSNotFound)
        return self;
    NSString *firstComponent = [self substringToIndex:range.location];
    return firstComponent;
}

- (NSString *)stringByAppendingTrailingSlash
{
    if ([self hasTrailingSlash] == NO) {
        return [self stringByAppendingString:@"/"];
    }
    return self;
}

//- (NSString *)urlEncode
//{
//    NSString *str = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    return str;
//}

- (NSString *) urlEncode{//URLEncodedString_ch {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)urlDecode
{
    NSString *str = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}

- (NSString *)escapeAmpersands {
	return [self stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
}

- (NSString *)keyFromPath
{
    return [[self lastPathComponent] stringByRemovingTrailingSlash];
}

- (BOOL)hasTrailingSlash
{
    return [self hasSuffix:@"/"];
}

- (NSString *)stringByRemovingTrailingSlash
{
    if ([self hasTrailingSlash] != NO) {
        return [self substringToIndex:self.length - 1];
    }
    return self;
}

- (NSInteger)longValue
{
    NSNumber *number = [NSNumber numberWithLong:[self integerValue]];
    return [number longValue];
}

- (NSUInteger)unsignedIntegerValue
{
    NSNumber *number = [NSNumber numberWithLongLong:[self longLongValue]];
    return [number unsignedIntegerValue];
}

- (NSNumber *)numberWithUnsignedIntValue
{
    NSUInteger unum = [self unsignedIntegerValue];
    return [NSNumber numberWithUnsignedInteger:unum];
}

- (unsigned long long)unsignedLongLongValue
{
    NSNumber *number = [NSNumber numberWithLongLong:[self longLongValue]];
    return [number unsignedLongLongValue];
    
}
- (NSNumber *)numberWithUnsignedLongLongValue
{
    unsigned long long unum = [self unsignedLongLongValue];
    return [NSNumber numberWithUnsignedLongLong:unum];
}

- (NSString *)trimPrefix:(NSString *)prefix
{
    if ([self hasPrefix:prefix]) {
        NSString *str = [self substringFromIndex:prefix.length];
        return str;
    }
    return self;
}

- (NSString *)stripCommentsFromJSON
{
    BOOL in_string = NO;
    BOOL in_multiline_comment = NO;
    BOOL in_singleline_comment = NO;
    NSString *tmp;
    NSString *tmp2;
    NSMutableArray *new_str = [@[] mutableCopy];
    int from = 0;
    NSString *lc;
    NSString *rc;
    int lastIndex = 0;
    
    NSRegularExpression *tokenizer = [NSRegularExpression regularExpressionWithPattern:@"\"|(\\/\\*)|(\\*\\/)|(\\/\\/)|\n|\r"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSRegularExpression *magic = [NSRegularExpression regularExpressionWithPattern:@"(\\\\)*$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    NSArray *matches = [tokenizer matchesInString:self
                                          options:0
                                            range:NSMakeRange(0, self.length)];
    if ([matches count] == 0) {
        return self;
    }
    
    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        tmp = [self substringWithRange:range];
        lastIndex = (int)range.location + (int)range.length;
        lc = [self substringWithRange:NSMakeRange(0, lastIndex - (int)range.length)];
        rc = [self substringWithRange:NSMakeRange(lastIndex, self.length - lastIndex)];
        
        if ( !in_multiline_comment && !in_singleline_comment ) {
            tmp2 = [lc substringWithRange:NSMakeRange(from, lc.length - from)];
            if ( !in_string ) {
                NSArray* words = [tmp2 componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                tmp2 = [words componentsJoinedByString:@""];
            }
            [new_str addObject:tmp2];
        }
        from = lastIndex;
        
        if ( [tmp hasPrefix:@"\""] && !in_multiline_comment && !in_singleline_comment) {
            NSArray *_matches = [magic matchesInString:lc
                                               options:0
                                                 range:NSMakeRange(0, lc.length)];
            
            if (_matches.count > 0 ) {
                NSTextCheckingResult *_match = _matches[0];
                NSRange _range = [_match range];
                
                if ( !in_string || _range.length%2 == 0 ) {
                    in_string = !in_string;
                }
            }
            from--;
            rc = [self substringWithRange:NSMakeRange(from, self.length - from)];
        }
        else if ( [tmp hasPrefix:@"/*"] && !in_string && !in_multiline_comment && !in_singleline_comment ) {
            in_multiline_comment = YES;
        }
        else if ( [tmp hasPrefix:@"*/"] && !in_string && in_multiline_comment && !in_singleline_comment ) {
            in_multiline_comment = NO;
        }
        else if ( [tmp hasPrefix:@"//"] && !in_string && !in_multiline_comment && !in_singleline_comment) {
            in_singleline_comment = YES;
        }
        else if ( ([tmp hasPrefix:@"\n"] || [tmp hasPrefix:@"\r"]) && !in_string && !in_multiline_comment && in_singleline_comment) {
            in_singleline_comment = NO;
        }
        else if (!in_multiline_comment && !in_singleline_comment ) {
            NSArray* words = [tmp componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            tmp = [words componentsJoinedByString:@""];
            if (tmp && tmp.length) {
                [new_str addObject:tmp];
            }
        }
        
    }
    [new_str addObject:rc];
    
    return [new_str componentsJoinedByString:@""];
}

- (NSString *)prettifyJSON
{
    NSData *uglyData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *uglyJSON = [NSJSONSerialization JSONObjectWithData:uglyData
                                                             options:kNilOptions
                                                               error:&error];
    if (error == nil && uglyJSON) {
        NSData *prettyData = [NSJSONSerialization dataWithJSONObject:uglyJSON
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
        if (error == nil) {
            NSString *prettyString = [[NSString alloc] initWithData:prettyData encoding:NSUTF8StringEncoding];
            return prettyString;
        }
    }
    DDLogError(@"%4d%s malformed json: %@ %@", __LINE__, __PRETTY_FUNCTION__, self, error.description);
    return self;
}

- (NSString *)minifyJSON
{
    NSData *uglyData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *uglyJSON = [NSJSONSerialization JSONObjectWithData:uglyData
                                                             options:kNilOptions
                                                               error:&error];
    if (error == nil && uglyJSON) {
        NSData *prettyData = [NSJSONSerialization dataWithJSONObject:uglyJSON
                                                             options:0
                                                               error:&error];
        if (error == nil) {
            NSString *prettyString = [[NSString alloc] initWithData:prettyData encoding:NSUTF8StringEncoding];
            return prettyString;
        }
    }
    DDLogError(@"%4d%s malformed json: %@ %@", __LINE__, __PRETTY_FUNCTION__, self, error.description);
    return self;
}

+ (NSString *)textFromNumber:(NSNumber*)number{
    NSNumberFormatter *numberToTextFormatter = [[NSNumberFormatter alloc] init];
    [numberToTextFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    
    NSString *formattedTextFromNumber = [numberToTextFormatter stringFromNumber:number];
    NSLog(@"%@", formattedTextFromNumber);
    return formattedTextFromNumber;
}

+ (NSString*) doCipher:(NSString*)encryptValue {   
    NSString *key = Const_EncrytpionKey;
    //
    NSData  *dataToCipher   =   [encryptValue dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData    *cipheredData  =   [NSString AES128EncryptWithKey:key toCryptData:dataToCipher operation:kCCEncrypt];
    
    
    NSString *result = [cipheredData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    NSLogInfo(@"\"%@\" has been encrypted to \"%@\"",encryptValue ,result);
    return result;
}

+ (NSString*) doDecipher:(NSString*)encryptedValue {
    NSString *key = Const_EncrytpionKey;
    
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encryptedValue options:0];
    
    NSData    *cipheredData  =   [NSString AES128EncryptWithKey:key toCryptData:decodedData operation:kCCDecrypt];
    
    NSString *result = [[NSString alloc] initWithData:cipheredData encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"%@",result);
    return result;
}

+ (NSData *)AES128EncryptWithKey:(NSString *)key toCryptData:(NSData*)data operation:(CCOperation)operation
{
    // ‘key’ should be 16 bytes for AES128
    char keyPtr[kCCKeySizeAES128 + 1]; // room for terminator (unused)
    bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That’s why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc( bufferSize );
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt( operation, kCCAlgorithmAES128, kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted );
    if( cryptStatus == kCCSuccess )
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free( buffer ); //free the buffer
    return nil;
}
@end


