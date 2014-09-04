//
//  NSURLRequest+Extras.m
//  ChargePoint
//
//  Created by Navi Singh on 5/6/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import "NSURLRequest+Extras.h"
#import "TTTURLRequestFormatter.h"

@implementation NSURLRequest (Extras)

-(NSString *)curl
{
    __block NSMutableString *displayString = [NSMutableString stringWithFormat:@"curl -X %@", self.HTTPMethod];
    
    //    if([self.filesToBePosted count] == 0 && [self.dataToBePosted count] == 0) {
    [[self allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop)
     {
         [displayString appendFormat:@" -H \'%@: %@\'", key, val];
     }];
    //    }
    
    [displayString appendFormat:@" \'%@\'", self.URL.absoluteString];
    
    if ([self.HTTPMethod isEqualToString:@"POST"] ||
        [self.HTTPMethod isEqualToString:@"PUT"] ||
        [self.HTTPMethod isEqualToString:@"PATCH"]) {
        NSString *params = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
        [displayString appendFormat:@"-d \"%@\" ",params];
    }
    
    return displayString;
}

//change for production - to be uncommented in production
#if !PROD_URL
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host{
    return YES;
}

+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString *)host{
    [NSURLRequest allowsAnyHTTPSCertificateForHost:host];
}
#endif

-(NSString *)curlDecoded
{
    NSString *curlStr = [TTTURLRequestFormatter cURLCommandFromURLRequest:self];
    NSString *decodedCurlStr;
    {
        NSRange range = [curlStr rangeOfString:@"http" options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            NSString *subStr = [curlStr substringFromIndex:range.location];
            decodedCurlStr = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)subStr, CFSTR(""), kCFStringEncodingUTF8);
        }
    }
    return decodedCurlStr;
}
//- (id)debugQuickLookObject
//{
//    return [self curlDecoded];
//}
@end

@implementation NSURL (curl)

-(NSString *)curl
{
	NSURLRequest *request = [NSURLRequest requestWithURL:self];
    return request.curl;
}

@end

