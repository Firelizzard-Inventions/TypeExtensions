//
//  NSString+numberValue.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSString+numberValue.h"

@implementation NSString (numberValue)

- (NSNumber *)numberValue
{
	static NSNumberFormatter * formatter = nil;
	if (formatter == nil) {
		formatter = [NSNumberFormatter new];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	}
	
	return [formatter numberFromString:self];
}

@end
