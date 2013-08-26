//
//  NSString+characterAtIndexSubscript.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 7/26/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSString+characterAtIndexSubscript.h"

@implementation NSString (characterAtIndexSubscript)

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)idx
{
	return @([self characterAtIndex:idx]);
}

@end
