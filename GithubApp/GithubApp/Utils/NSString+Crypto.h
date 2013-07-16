//
//  NSString+MD5.h
//  BzzAgent
//
//  Created by Joe Goullaud on 6/27/11.
//  Copyright 2011 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Crypto)

- (NSString*)md5;
- (NSString*)md5Lowercase:(BOOL)lowercase;

@end
