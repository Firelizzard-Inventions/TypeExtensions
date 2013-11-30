//
//  NSDictionaryEntry.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/9/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSDictionaryEntrySetEntry.h"

@implementation NSDictionaryEntrySetEntry

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ = %@", self.key, self.object];
}

- (BOOL)isEqual:(id)object
{
	if (!object)
		return NO;
	
	if (object == self)
		return YES;
	
	if (![object isKindOfClass:self.class])
		return NO;
	
	NSDictionaryEntrySetEntry * other = (NSDictionaryEntrySetEntry *)object;
	
	if (self.key) {
		if (![self.key isEqual:other.key])
			return NO;
	} else if (other.key)
		return NO;
	
	if (self.object) {
		if (![self.object isEqual:other.object])
			return NO;
	} else if (other.object)
		return NO;
	
	return YES;
}

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
