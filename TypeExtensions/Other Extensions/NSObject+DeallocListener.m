//
//  NSObject+DeallocListener.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject+DeallocListener.h"

#import "NSObject+associatedObject.h"
#import "NSString+random.h"

#import <objc/runtime.h>
#import <objc/message.h>

#define kDeallocListenerAssociatedClassKey			"__DeallocListener__AssociatedClass__"
#define kDeallocListenerOriginalClassKey			"__DeallocListener__OriginalClass__"
#define kDeallocListenerArrayKey					"com.firelizzard.TypeExtensions.DeallocListener.listeners"
#define kDeallocListenerSubclassFailureExceptionKey	@"com.firelizzard.TypeExtensions.DeallocListener.exceptions.subclassFailure"

#define MAX_RETAIN_COUNT	0x7fffffffffffffff

#pragma mark -

@interface NSObject (DeallocListenerPrivate)

- (void)_revert;

@end

#pragma mark -

void DeallocNotifier_addDeallocListener(id self, SEL _cmd, id<DeallocListener> listener) {
	NSMutableArray * arr = objc_getAssociatedObject(self, kDeallocListenerArrayKey);
	
	if (!arr) {
		arr = [NSMutableArray array];
		objc_setAssociatedObject(self, kDeallocListenerArrayKey, arr, OBJC_ASSOCIATION_RETAIN);
	}
	
	[arr addObject:listener];
}

void DeallocNotifier_removeDeallocListener(id self, SEL _cmd, id<DeallocListener> listener) {
	NSMutableArray * arr = objc_getAssociatedObject(self, kDeallocListenerArrayKey);
	
	if (!arr)
		return;
	
	[arr removeObject:listener];
}

void DeallocNotifier_dealloc(id self, SEL _cmd) {
	if ([self respondsToSelector:@selector(invalidate)])
		[self invalidate];
	
	for (id<DeallocListener> listener in objc_getAssociatedObject(self, kDeallocListenerArrayKey))
		[listener objectDidDeallocate:self];
	
	objc_setAssociatedObject(self, kDeallocListenerArrayKey, nil, OBJC_ASSOCIATION_RETAIN);
	
	[self _revert];
	[self dealloc];
}

Class DeallocNotifier_class(id self, SEL _cmd) {
	Class realClass = object_getClass(self);
	Class superClass = class_getSuperclass(realClass);
	
	object_setClass(self, superClass);
	Class class = [self class];
	object_setClass(self, realClass);
	return class;
}

#pragma mark -

id associatedObject_associatedObjectForKey(Class self, SEL _cmd, const char * key) {
	return objc_getAssociatedObject(objc_getAssociatedObject(self, kDeallocListenerOriginalClassKey), key);
}

void associatedObject_setAssociatedObject_forKey(Class self, SEL _cmd, id obj, const char * key) {
	objc_setAssociatedObject(objc_getAssociatedObject(self, kDeallocListenerOriginalClassKey), key, obj, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark -

void KVOBug_addObserver_forKeyPath_options_context(id self, SEL _cmd, NSObject * observer, NSString * keyPath, NSKeyValueObservingOptions options, void * context) {
	Class realClass = object_getClass(self);
	Class superClass = class_getSuperclass(realClass);
	
	object_setClass(self, superClass);
	[self addObserver:observer forKeyPath:keyPath options:options context:context];
	object_setClass(self, realClass);
}

void KVOBug_removeObserver_forKeyPath_context(id self, SEL _cmd, NSObject * observer, NSString * keyPath, void * context) {
	Class realClass = object_getClass(self);
	Class superClass = class_getSuperclass(realClass);
	
	object_setClass(self, superClass);
	[self removeObserver:observer forKeyPath:keyPath context:context];
	object_setClass(self, realClass);
}

void KVOBug_setValue_forKey(id self, SEL _cmd, id object, NSString * key) {
	Class realClass = object_getClass(self);
	Class superClass = class_getSuperclass(realClass);
	
	object_setClass(self, superClass);
	[self setValue:object forKey:key];
	object_setClass(self, realClass);
}

#pragma mark -

@implementation NSObject (DeallocListener)

- (void)addDeallocListener:(id<DeallocListener>)listener {
	Class original = objc_getAssociatedObject(self.class, kDeallocListenerOriginalClassKey);
	if (original || [self conformsToProtocol:@protocol(DeallocNotifier)])
		goto _addListener;
	
	if ([self isMemberOfClass:NSObject.class])
		goto _classException;
	
	if ([self isKindOfClass:NSString.class])
		goto _classException;
	
	if ([self isKindOfClass:NSNumber.class])
		goto _classException;
	
	if (self.retainCount == @(0).retainCount || self.retainCount == @"".retainCount)
		goto _classException;
	
	[self addObserver:self forKeyPath:@"self" options:0 context:nil];
	
	original = object_getClass(self);
	Class proxyClass = [(NSObject *)original associatedObjectForKey:kDeallocListenerAssociatedClassKey];
	
	if (!proxyClass) {
		NSString * newName = [NSString stringWithFormat:@"DeallocNotifying_%@", original];
		proxyClass = objc_allocateClassPair(original, [newName cStringUsingEncoding:NSASCIIStringEncoding], 0);
		Class proxyClassClass = object_getClass(proxyClass);
		
		objc_registerClassPair(proxyClass);
		
		class_addProtocol(proxyClass, @protocol(DeallocNotifier));
		
		class_addMethod(proxyClass,      @selector(addDeallocListener:),                     (IMP)&DeallocNotifier_addDeallocListener,            "v@:@@");
		class_addMethod(proxyClass,      @selector(removeDeallocListener:),                  (IMP)&DeallocNotifier_removeDeallocListener,         "v@:@");
		class_addMethod(proxyClass,      @selector(dealloc),                                 (IMP)&DeallocNotifier_dealloc,                       "v@:");
		class_addMethod(proxyClass,      @selector(class),                                   (IMP)&DeallocNotifier_class,                         "@@:");
		
		class_addMethod(proxyClassClass, @selector(associatedObjectForKey:),                 (IMP)&associatedObject_associatedObjectForKey,       "@@:*");
		class_addMethod(proxyClassClass, @selector(setAssociatedObject:forKey:),             (IMP)&associatedObject_setAssociatedObject_forKey,   "v@:@*");
		
		class_addMethod(proxyClass,      @selector(addObserver:forKeyPath:options:context:), (IMP)&KVOBug_addObserver_forKeyPath_options_context, "v@:@@i*");
		class_addMethod(proxyClass,      @selector(removeObserver:forKeyPath:context:),      (IMP)&KVOBug_removeObserver_forKeyPath_context,      "v@:@@*");
		class_addMethod(proxyClass,      @selector(setValue:forKey:),                        (IMP)&KVOBug_setValue_forKey,                        "v@:@@");
		
		objc_setAssociatedObject(proxyClass, kDeallocListenerOriginalClassKey, original, OBJC_ASSOCIATION_RETAIN);
		objc_setAssociatedObject(original, kDeallocListenerAssociatedClassKey, proxyClass, OBJC_ASSOCIATION_RETAIN);
	}
	
	object_setClass(self, proxyClass);
	
_addListener:
	[self addDeallocListener:listener];
	return;
	
_classException:
	@throw [NSException exceptionWithName:kDeallocListenerSubclassFailureExceptionKey reason:[NSString stringWithFormat:@"%@ cannot be converted to a DeallocNotifier", self] userInfo:0];
}

- (void)removeDeallocListener:(id<DeallocListener>)listener
{
	// nothing to do
}

@end

@implementation NSObject (DeallocListenerPrivate)

- (void)_revert
{
	Class original = objc_getAssociatedObject(object_getClass(self), kDeallocListenerOriginalClassKey);
	if (original)
		object_setClass(self, original);
	
	[self removeObserver:self forKeyPath:@"self" context:nil];
}

@end
