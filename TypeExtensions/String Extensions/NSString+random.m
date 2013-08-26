//
//  NSString+randomString.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSString+random.h"

#import "NSString+characterAtIndexSubscript.h"

@implementation NSString (random)

- (NSString *)stringWithNumberOfRandomCharactersFromString:(NSUInteger)count
{
	const char * str = [self cStringUsingEncoding:NSUTF8StringEncoding];
	char buf[count + 1];
	for (int i = 0; i < count; i++)
		buf[i] = str[arc4random_uniform((u_int32_t)self.length)];
	buf[count] = '\0';
	
	return [NSString stringWithCString:(const char *)buf encoding:NSUTF8StringEncoding];
}

@end
