//
//  TXBTree.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/5/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "TXBTree.h"

@implementation TXBTree

+ (instancetype)treeWithComparator:(NSComparator)comparator forObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt
{
	return [[[self alloc] initWithComparator:comparator forObjects:objects forKeys:keys count:cnt] autorelease];
}

- (id)initWithComparator:(NSComparator)comparator forObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt
{
	comparator = Block_copy(comparator);
	self = [self initWithParent:nil andComparator:comparator forObjects:objects forKeys:keys count:cnt];
	Block_release(comparator);
	return self;
}

- (id)initWithParent:(TXBTree *)parent andComparator:(NSComparator)comparator forObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt
{
	if (!(self = [super init]))
		return nil;
	
	if (!cnt)
		return nil;
	
	_comparator = [comparator retain];
	_parent = [parent retain];
	_count = cnt;
	
	NSUInteger count = cnt / 2;
	if (count) {
		_left = [[self.class alloc] initWithParent:self andComparator:comparator forObjects:objects forKeys:keys count:count];
		objects += count;
		keys += count;
		cnt -= count;
	}
	
	_object = [objects++[0] retain];
	_key = [keys++[0] retain];
	cnt--;
	
	if (cnt)
		_right = [[self.class alloc] initWithParent:self andComparator:comparator forObjects:objects forKeys:keys count:cnt];
	
	[self.parent addObserver:self forKeyPath:@"comparator" options:NSKeyValueObservingOptionNew context:nil];
	[self.left addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
	[self.right addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([@"comparator" isEqualToString:keyPath]) {
		[self willChangeValueForKey:@"comparator"];
		_comparator = change[NSKeyValueChangeNewKey];
		[self didChangeValueForKey:@"comparator"];
		return;
	}
	
	if ([@"count" isEqualToString:keyPath]) {
		[self willChangeValueForKey:@"count"];
		_count = [change[NSKeyValueChangeNewKey] unsignedIntegerValue] - [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
		[self didChangeValueForKey:@"count"];
		return;
	}
}

@end
