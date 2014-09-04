//
//  NSURLRequest+Extras.h
//  ChargePoint
//
//  Created by Manish Kumar - Imported on 5/6/14.
//  Copyright (c) 2014 Chargepoint Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Extras)
-(NSString *)curl;

//change for production - to be uncommented in production

#if !PROD_URL
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString *)host;
#endif

-(NSString *)curlDecoded;
@end

@interface NSURL (curl)
-(NSString *)curl;
@end
