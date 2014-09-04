//
//  NSNumber+Extras.m
//
//  Created by Manish Kumar - Imported on 3/29/14.
//
//

#import "NSNumber+Extras.h"

@implementation NSNumber (Extras)

- (NSString *)stringWithBoolValue
{
    NSMutableString *str = [@"" mutableCopy];
    int n = 1;
    for(NSInteger numberCopy = self.integerValue; numberCopy > 0; numberCopy >>= 1, n++)
    {
        // Prepend "0" or "1", depending on the bit
        [str insertString:((numberCopy & 1) ? @"1" : @"0") atIndex:0];
        if (!(n % 4)) {
            [str insertString:@" " atIndex:0];
        }
    }
    return str;
}

@end
