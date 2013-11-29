//
//  LFBinarySearchTreeDictionary.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/18/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSDictionary_BinarySearchTree.h"

@interface NSDictionary_BinarySearchTree ()

@property (readonly) NSUInteger hash;
@property (readonly) id key, object;
@property (readonly) NSDictionary_BinarySearchTree * left, * right;

+ (NSUInteger)objectForHash:(id<NSObject>)object;

- (id)objectForHash:(NSUInteger)hash;

- (NSUInteger)_buildSortedObjects:(id [])objects forKeys:(id [])keys count:(NSUInteger)count;

@end

@implementation NSDictionary_BinarySearchTree

+ (NSUInteger)objectForHash:(id<NSObject>)object
{
	if (!object)
		return 0;
	
	return [object hash] * 3 + [[object class] hash] * 5;
}

- (instancetype)initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)count
{
	if (!(self = [super init]))
		return nil;
	
	if (count == 0) {
		[self release];
		return nil;
	}
	
	NSUInteger mid = count / 2;
	NSUInteger lcount = 0, rcount = 0;
	id<NSCopying> lkeys[count], rkeys[count];
	id lobjects[count], robjects[count];
	
	_count = count;
	_hash = [NSDictionary_BinarySearchTree objectForHash:(id<NSObject>)keys[mid]];
	_key = [keys[mid] copyWithZone:[self zone]];
	_object = [objects[mid] retain];
	
	for (int i = 0; i < count; i++)
		if ([NSDictionary_BinarySearchTree objectForHash:(id<NSObject>)keys[i]] < _hash) {
			lkeys[lcount] = keys[i];
			lobjects[lcount] = objects[i];
			lcount++;
		} else {
			rkeys[rcount] = keys[i];
			robjects[rcount] = objects[i];
			rcount++;
		}
	
	_left = [[NSDictionary_BinarySearchTree alloc] initWithObjects:lobjects forKeys:lkeys count:lcount];
	_right = [[NSDictionary_BinarySearchTree alloc] initWithObjects:robjects forKeys:rkeys count:rcount];
	
	return self;
}

- (id)objectForKey:(id)aKey
{
	return [self objectForHash:[NSDictionary_BinarySearchTree objectForHash:aKey]];
}

- (id)objectForHash:(NSUInteger)hash
{
	if (!hash)
		return nil;
	
	if (hash == self.hash)
		return self.object;
	else if (hash < self.hash)
		return [self.left objectForHash:hash];
	else
		return [self.right objectForHash:hash];
}

- (NSEnumerator *)keyEnumerator
{
	return nil;
}

- (id)balancedCopy
{
	id keys[self.count], objects[self.count];
	
	[self _buildSortedObjects:objects forKeys:keys count:self.count];
	
	return [[NSDictionary_BinarySearchTree alloc] initWithObjects:objects forKeys:keys count:self.count];
}

- (NSUInteger)_buildSortedObjects:(id [])objects forKeys:(id [])keys count:(NSUInteger)count
{
	NSUInteger sorted;
	
	sorted = [self.left _buildSortedObjects:objects forKeys:keys count:count];
	
	if (sorted >= count)
		goto _return;
	
	keys[sorted] = _key;
	objects[sorted] = _object;
	sorted++;
	
	sorted += [self.right _buildSortedObjects:objects forKeys:keys count:count];
	
_return:
	return sorted;
}

- (void)dealloc
{
	[_key release];
	[_object release];
	
	[_left release];
	[_right release];
	
	[super dealloc];
}

@end
