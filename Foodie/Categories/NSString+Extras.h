//
//  NSString+Extras.h
//
//  Created by Navi Singh on 3/29/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extras)

+ (NSString *)stringFromCGRect:(CGRect)rect;
+ (NSString *)textFromNumber:(NSNumber*)number;

- (NSString *)trim;

- (NSString *)firstPathComponent;

- (NSString *)urlEncode;
- (NSString *)urlDecode;

- (NSString *)escapeAmpersands;

- (BOOL)hasTrailingSlash;
- (NSString *)stringByAppendingTrailingSlash;
- (NSString *)stringByRemovingTrailingSlash;
- (NSString *)keyFromPath;

- (NSInteger)longValue;
- (NSUInteger)unsignedIntegerValue;
- (NSNumber *)numberWithUnsignedIntValue;
- (unsigned long long)unsignedLongLongValue;
- (NSNumber *)numberWithUnsignedLongLongValue;

- (NSString *)trimPrefix:(NSString *)prefix;

//https://github.com/getify/JSON.minify
- (NSString *)stripCommentsFromJSON;
- (NSString *)minifyJSON;
- (NSString *)prettifyJSON;

#pragma mark - string encryption
+ (NSString*) doCipher:(NSString*)encryptValue;
+ (NSString*) doDecipher:(NSString*)encryptedValue;
@end


#if KITEWORKS
	#define ACString(key) \
		NSLocalizedStringFromTable(key, @"KWLocalizable", nil)

	#define ACStringWithComment(key, comment) \
		NSLocalizedStringFromTable(key, @"KWLocalizable", comment)
#else
	#define ACString(key) \
		NSLocalizedStringFromTable(key, @"ACLocalizable", nil)

	#define ACStringWithComment(key, comment) \
		NSLocalizedStringFromTable(key, @"ACLocalizable", comment)
#endif
