//
//  NSMapTable+objectForKeyedSubscript.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 1/2/14.
//  Copyright (c) 2014 Lens Flare. All rights reserved.
//

#import "NSMapTable+objectForKeyedSubscript.h"

@implementation NSMapTable (objectForKeyedSubscript)

- (id)objectForKeyedSubscript:(id)key
{
	return [self objectForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id)key
{
	[self setObject:object forKey:key];
}

@end
