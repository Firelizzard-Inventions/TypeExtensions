//
//  NSDictionary+entrySet.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/9/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSDictionary+entrySet.h"

@interface __NSDictionaryEntry : NSObject <NSDictionaryEntry>

@property (readonly) id<NSObject> key, object;

+ (instancetype)dictionaryEntryWithKey:(id<NSObject>)key forDictionary:(NSDictionary *)dictionary;

@end

@implementation NSDictionary (entrySet)

- (NSSet *)entrySet
{
	NSMutableSet * entrySet = [NSMutableSet setWithCapacity:self.count];
	
	for (id<NSObject> key in self) {
		[entrySet addObject:[__NSDictionaryEntry dictionaryEntryWithKey:key forDictionary:self]];
	}
	
	NSSet * ret = [NSSet setWithSet:entrySet];
	
	return ret;
}

@end

@implementation __NSDictionaryEntry

+ (instancetype)dictionaryEntryWithKey:(id<NSObject>)key forDictionary:(NSDictionary *)dictionary
{
	return [[self alloc] initWithKey:key forDictionary:dictionary];
}

- (id)initWithKey:(id<NSObject>)key forDictionary:(NSDictionary *)dictionary
{
	if (self = [super init]) {
		_key = key;
		_object = dictionary[key];
	}
	return self;
}


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
	
	__NSDictionaryEntry * other = (__NSDictionaryEntry *)object;
	
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

@end