//
//  NSObject+zeroingWeakReferenceProxy.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/25/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject+zeroingWeakReferenceProxy.h"

#import "NSObject+associatedObject.h"
#import "NSObject+DeallocListener.h"

#import <objc/runtime.h>


@interface __NSObject_zeroingWeakReferenceProxy : NSProxy <DeallocListener, NSCopying>

+ (__NSObject_zeroingWeakReferenceProxy *)proxyWithReference:(NSObject *)object;
- (id)initWithReference:(NSObject *)object;

@property (readonly) NSObject<DeallocNotifier> * ref;
@property (readonly) Class refClass;

@end


@implementation __NSObject_zeroingWeakReferenceProxy

+ (__NSObject_zeroingWeakReferenceProxy *)proxyWithReference:(id)object
{
	return [[[self alloc] initWithReference:object] autorelease];
}

- (id)initWithReference:(NSObject *)object
{
//	if (!(self = [super init]))
//		return nil;
	
	if (![object isKindOfClass:NSObject.class])
		return nil;
	
	_ref = object.startDeallocationNofitication;
	_refClass = object_getClass(object);
	
	[self.ref addDeallocListener:self];
	
	return self;
}

- (void)dealloc
{
	[self.ref removeDeallocListener:self];
	
	[super dealloc];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
	return [(self.ref ? self.ref : self.refClass) methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	[invocation invokeWithTarget:self.ref];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	return [(self.ref ? self.ref : self.refClass) respondsToSelector:aSelector];
}

- (id)copyWithZone:(NSZone *)zone
{
	return [[[self class] allocWithZone:zone] initWithReference:self.ref];
}

- (void)objectDidDeallocate:(id)obj
{
	if (obj == self.ref)
		_ref = nil;
}

@end



@implementation NSObject (zeroingWeakReferenceProxy)

- (id<NSObject>)zeroingWeakReferenceProxy
{
	return [__NSObject_zeroingWeakReferenceProxy proxyWithReference:self];
}

@end
