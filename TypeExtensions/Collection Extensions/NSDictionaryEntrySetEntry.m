//
//  NSDictionaryEntry.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/9/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSDictionaryEntrySetEntry.h"

@implementation NSDictionaryEntrySetEntry

#pragma mark - Lifecycle Methods

- (id)initWithKey:(NSObject *)key forDictionary:(NSDictionary *)dictionary
{
	if (self = [super init]) {
		_key = [key retain];
		_object = [dictionary[key] retain];
	}
	return self;
}

- (void)dealloc
{
	[_key release];
	[_object release];
	[super dealloc];
}

#pragma mark - Class Methods

+ (NSDictionaryEntrySetEntry *)dictionaryEntryWithKey:(NSObject *)key forDictionary:(NSDictionary *)dictionary
{
	NSDictionaryEntrySetEntry * entry = [NSDictionaryEntrySetEntry alloc];
	[entry initWithKey:key forDictionary:dictionary];
	return [entry autorelease];
}

@end
