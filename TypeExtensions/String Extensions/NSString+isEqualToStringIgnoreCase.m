//
//  NSString+isEqualToStringIgnoreCase.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/22/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSString+isEqualToStringIgnoreCase.h"

@implementation NSString (isEqualToStringIgnoreCase)

- (BOOL)isEqualToStringIgnoreCase:(NSString *)aString
{
	return [self isEqualToString:aString ignoreCase:YES];
}

- (BOOL)isEqualToString:(NSString *)aString ignoreCase:(BOOL)i
{
	if (i)
		return [self.lowercaseString isEqualToString:aString.lowercaseString];
	else
		return [self isEqualToString:aString];
}

@end
