//
//  NSDictionary+entrySet.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/9/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSDictionary+entrySet.h"

#import "NSDictionaryEntrySetEntry.h"

@implementation NSDictionary (entrySet)

- (NSSet *)entrySet
{
	NSMutableSet * entrySet = [NSMutableSet setWithCapacity:self.count];
	
	for (NSObject * key in self) {
		[entrySet addObject:[NSDictionaryEntrySetEntry dictionaryEntryWithKey:key forDictionary:self]];
	}
	
	NSSet * ret = [NSSet setWithSet:entrySet];
	
	return ret;
}

@end
