//
//  NSMutableDictionary_NonRetaining_Zeroing.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSMutableDictionary_NonRetaining_Zeroing.h"

#import "NSObject+DeallocListener.h"


@interface NSMutableDictionary_NonRetaining_Zeroing ()

- (void)objectDidDeallocateForKey:(id)key;

@end


@interface __NSMutableDictionary_NonRetaining_Zeroing__Listener : NSObject <DeallocListener, NSCopying>

@property (readonly) NSMutableDictionary_NonRetaining_Zeroing * dictionary;
@property (readonly) id<NSObject> key;
@property (readonly) id<DeallocNotifier> obj;

+ (__NSMutableDictionary_NonRetaining_Zeroing__Listener *)listenerWithDictionary:(NSMutableDictionary_NonRetaining_Zeroing *)dict forObject:(id)obj withKey:(id<NSObject>)key;
- (id)initWithDictionary:(NSMutableDictionary_NonRetaining_Zeroing *)dict forObject:(id)obj withKey:(id<NSObject>)key;

@end


@implementation __NSMutableDictionary_NonRetaining_Zeroing__Listener

+ (__NSMutableDictionary_NonRetaining_Zeroing__Listener *)listenerWithDictionary:(NSMutableDictionary_NonRetaining_Zeroing *)dict forObject:(id)obj withKey:(id<NSObject>)key
{
	return [[[self alloc] initWithDictionary:dict forObject:obj withKey:key] autorelease];
}

- (id)initWithDictionary:(NSMutableDictionary_NonRetaining_Zeroing *)dict forObject:(id)obj withKey:(id<NSObject>)key
{
	if (!(self = [super init]))
		return nil;
	
	if (![obj isKindOfClass:NSObject.class])
		return nil;
	
	_dictionary = dict.retain;
	_obj = obj;
	_key = key.retain;
	
	[self.obj addDeallocListener:self];
	
	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	[NSException raise:@"Unsupported functionality" format:@"This object should not be copied"];
	return nil;
}

- (void)dealloc
{
//	[(NSObject *)_obj stopDeallocationNotification];
	[_obj removeDeallocListener:self];
	[_dictionary release];
	[_key release];
	
	[super dealloc];
}

- (void)objectDidDeallocate:(id)obj
{
	_obj = nil;
	[self.dictionary objectDidDeallocateForKey:self.key];
}

@end


@implementation NSMutableDictionary_NonRetaining_Zeroing {
	NSMutableDictionary * _backing;
}

- (id)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
	if (!(self = [super init]))
		return nil;
	
	id entries[cnt];
	for (int i = 0; i < cnt; i++)
		entries[i] = [__NSMutableDictionary_NonRetaining_Zeroing__Listener listenerWithDictionary:self forObject:objects[i] withKey:(id<NSObject>)keys[i]];
	
	_backing = [[NSMutableDictionary alloc] initWithObjects:entries forKeys:keys count:cnt];
	
	return self;
}

- (void)dealloc
{
	[_backing release];
	
	[super dealloc];
}

- (id)wrap:(id)object key:(id<NSObject>)key
{
	return [__NSMutableDictionary_NonRetaining_Zeroing__Listener listenerWithDictionary:self forObject:object withKey:key];
}

- (id)unwrap:(id)object
{
	if (![object isKindOfClass:__NSMutableDictionary_NonRetaining_Zeroing__Listener.class])
		return nil;
	
	return ((__NSMutableDictionary_NonRetaining_Zeroing__Listener *)object).obj;
}

- (void)objectDidDeallocateForKey:(id)key
{
	[_backing removeObjectForKey:key];
}

- (NSUInteger)count
{
	return _backing.count;
}

- (id)objectForKey:(id)aKey
{
	return [self unwrap:[_backing objectForKey:aKey]];
}

- (NSEnumerator *)keyEnumerator
{
	return _backing.keyEnumerator;
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
	[_backing setObject:[self wrap:anObject key:(id<NSObject>)aKey] forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
	[_backing removeObjectForKey:aKey];
}

@end
