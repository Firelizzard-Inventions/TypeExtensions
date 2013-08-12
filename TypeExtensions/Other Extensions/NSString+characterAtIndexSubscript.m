//
//  NSString+characterAtIndexSubscript.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 7/26/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSString+characterAtIndexSubscript.h"

@implementation NSString (characterAtIndexSubscript)

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
	return @([self characterAtIndex:idx]);
}

@end
