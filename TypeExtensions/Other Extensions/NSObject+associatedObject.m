//
//  NSObject+associatedObjectForSelector.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/22/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject+associatedObject.h"

#import <objc/runtime.h>

@implementation NSObject (associatedObject)

- (id)associatedObjectForKey:(const char *)key
{
	return objc_getAssociatedObject(self, key);
}

- (void)setAssociatedObject:(id)obj forKey:(const char *)key
{
	objc_setAssociatedObject(self, key, obj, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObjectForSelector:(SEL)aSelector
{
	return [self associatedObjectForKey:sel_getName(aSelector)];
}

- (void)setAssociatedObject:(id)obj forSelector:(SEL)aSelector
{
	[self setAssociatedObject:obj forKey:sel_getName(aSelector)];
}

- (id)associatedObjectForClass:(Class)aClass
{
	return [self associatedObjectForKey:class_getName(aClass)];
}

- (id)associatedObjectForClass
{
	return [self associatedObjectForClass:[self class]];
}

- (void)setAssociatedObject:(id)obj forClass:(Class)aClass
{
	[self setAssociatedObject:obj forKey:class_getName(aClass)];
}

- (void)setAssociatedObjectForClass:(id)obj
{
	[self setAssociatedObject:obj forClass:[self class]];
}

@end
