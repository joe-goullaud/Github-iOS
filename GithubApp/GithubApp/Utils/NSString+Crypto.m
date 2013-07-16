//
//  NSString+MD5.m
//  BzzAgent
//
//  Created by Joe Goullaud on 6/27/11.
//  Copyright 2011 Raizlabs. All rights reserved.
//

#import "NSString+Crypto.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (NSString_Crypto)

- (NSString*)md5
{
    return [self md5Lowercase:NO];
}

- (NSString*)md5Lowercase:(BOOL)lowercase
{
    const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	NSString* md5Str = [NSString stringWithFormat:
                        @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                        result[0], result[1], result[2], result[3], 
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    if (lowercase)
    {
        return [md5Str lowercaseString];
    }
    
    return md5Str;
}

@end
