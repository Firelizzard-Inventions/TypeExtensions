//
//  NSArray_NonRetaining_Zeroing.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSMutableArray_NonRetaining_Zeroing.h"

@implementation NSMutableArray_NonRetaining_Zeroing {
	NSMutableArray * _backing;
}

- (id)initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
	if (!(self = [super init]))
		return nil;
	
	id entries[cnt];
	for (int i = 0; i < cnt; i++)
		entries[i] = [NSValue valueWithNonretainedObject:objects[i]];
	_backing = [[NSMutableArray alloc] initWithObjects:entries count:cnt];
	
	return self;
}

- (void)dealloc
{
	[_backing release];
	
	[super dealloc];
}

- (id)wrapAndStartNotification:(id)object
{
	if (![object isKindOfClass:NSObject.class])
		return nil;
	
	[(NSObject *)object addDeallocListener:self];
	return [self wrap:object];
}

- (id)wrap:(id)object
{
	return [NSValue valueWithNonretainedObject:object];
}

- (id)unwrap:(id)object
{
	if (![object isKindOfClass:NSValue.class])
		return nil;
	
	return ((NSValue *)object).nonretainedObjectValue;
}

- (void)objectDidDeallocate:(id)obj
{
	[_backing removeObject:[self wrap:obj]];
}

- (NSUInteger)count
{
	return _backing.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
	return [self unwrap:[_backing objectAtIndex:index]];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
	[_backing insertObject:[self wrapAndStartNotification:anObject] atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
	[_backing removeObjectAtIndex:index];
}

- (void)addObject:(id)anObject
{
	[_backing addObject:[self wrapAndStartNotification:anObject]];
}

- (void)removeLastObject
{
	[self removeObjectAtIndex:self.count - 1];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
	[_backing replaceObjectAtIndex:index withObject:[self wrapAndStartNotification:anObject]];
}

@end
