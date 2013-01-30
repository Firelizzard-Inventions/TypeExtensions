//
//  NSArray+orNull.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSArray+orNull.h"

@implementation NSArray (orNull)

- (id)objectAtIndexOrNil:(NSUInteger)index
{
	if (index < [self count]) {
		return [self objectAtIndex:index];
	} else {
		return nil;
	}
}

@end
