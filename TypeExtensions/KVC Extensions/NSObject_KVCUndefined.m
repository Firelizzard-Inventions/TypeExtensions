//
//  NSObject_KVCUndefined.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/5/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject_KVCUndefined.h"

@implementation NSObject_KVCUndefined {
	NSMutableDictionary * undefined;
	NSLock * _internal_set, * _internal_get;
}

- (id)init
{
	if (self = [super init]) {
		undefined = @{}.mutableCopy;
		_internal_set = [NSLock new];
		_internal_get = [NSLock new];
		_tryLowerCase = false;
	}
	return self;
}

- (void)dealloc
{
	[_internal_set unlock];
	[_internal_get unlock];
	
	[undefined release];
	[_internal_set release];
	[_internal_get release];
	[super dealloc];
}

- (NSArray *)redefinedKeys
{
	return undefined.allKeys;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	if (_tryLowerCase && [_internal_set tryLock]) {
		[self setValue:value forKey:[key lowercaseString]];
		[_internal_set unlock];
	} else {
		undefined[key] = value ? value : [NSNull null];
	}
}

- (id)valueForUndefinedKey:(NSString *)key
{
	if (_tryLowerCase && [_internal_get tryLock]) {
		return [self valueForKey:[key lowercaseString]];
		[_internal_get unlock];
	} else {
		return [undefined valueForKey:key];
	}
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
	if (self.observeLowerCase)
		keyPath = keyPath.lowercaseString;
	[super addObserver:observer forKeyPath:keyPath options:options context:context];
}

@end
