//
//  NSString+isNumber.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSString+isNumber.h"

@implementation NSString (isNumber)

- (BOOL)isInteger
{
	static NSCharacterSet * nonDigits = nil;
	if (nonDigits == nil)
		nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	
	NSRange range = [self rangeOfCharacterFromSet:nonDigits];
	return NSNotFound == range.location;
}

@end
