//
//  NSString+firstLetterCaseString.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/22/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSString+firstLetterCaseString.h"

@implementation NSString (firstLetterCaseString)

- (NSString *)firstLetterUppercaseString
{
	NSString * first = [self substringToIndex:1];
	NSString * rest = [self substringFromIndex:1];
	return [first.uppercaseString stringByAppendingString:rest];
}

- (NSString *)firstLetterLowercaseString
{
	NSString * first = [self substringToIndex:1];
	NSString * rest = [self substringFromIndex:1];
	return [first.lowercaseString stringByAppendingString:rest];
}

@end
