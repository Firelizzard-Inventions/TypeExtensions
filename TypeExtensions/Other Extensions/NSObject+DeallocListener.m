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

#define kDeallocListenerAssociatedClassKey		"__DeallocListener__AssociatedClass__"
#define kDeallocListenerOriginalClassKey		"__DeallocListener__OriginalClass__"
#define kDeallocListenerClassNameCharSetString	@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

#define _super &((struct objc_super){self, [self superclass]})

void proxy_addDeallocListener(id self, SEL _cmd, id<DeallocListener, NSCopying> listener) {
	NSMutableArray * arr = objc_getAssociatedObject(self, class_getName([self class]));
	if (!arr)
		objc_setAssociatedObject(self, class_getName([self class]), arr = [NSMutableArray array], OBJC_ASSOCIATION_RETAIN);
	
	[arr addObject:listener];
}

void proxy_removeDeallocListener(id self, SEL _cmd, id<DeallocListener> listener) {
	[objc_getAssociatedObject(self, class_getName([self class])) removeObject:listener];
}

NSString * proxy_className(id self, SEL _cmd) {
	return NSStringFromClass(objc_getAssociatedObject([self class], kDeallocListenerOriginalClassKey));
}

void proxy_dealloc(id self, SEL _cmd) {
	if ([self respondsToSelector:@selector(invalidate)])
		[self invalidate];
	
	for (id<DeallocListener> listener in objc_getAssociatedObject(self, class_getName([self class])))
		[listener objectDidDeallocate:self];
	
//	[(NSObject *)self stopDeallocationNotification];
	
	// [super dealloc]
	objc_msgSendSuper(_super, _cmd);
}

id proxy_associatedObjectForKey(id self, SEL _cmd, const char * key) {
	return objc_msgSendSuper(_super, _cmd, key);
}

void proxy_setAssociatedObject_forKey(id self, SEL _cmd, id obj, const char * key) {
	objc_msgSendSuper(_super, _cmd, obj, key);
}

id proxyClass_associatedObjectForKey(Class self, SEL _cmd, const char * key) {
	return objc_getAssociatedObject([self superclass], key);
}

void proxyClass_setAssociatedObject_forKey(Class self, SEL _cmd, id obj, const char * key) {
	objc_setAssociatedObject([self superclass], key, obj, OBJC_ASSOCIATION_RETAIN);
}

@implementation NSObject (DeallocListener)

- (Class)realClass
{
	Class class = self.class;
	Class original = objc_getAssociatedObject(class, kDeallocListenerOriginalClassKey);
	
	if (original)
		return original;
	else
		return class;
}

- (id<DeallocNotifier>)startDeallocationNofitication
{
	Class original = objc_getAssociatedObject(self.class, kDeallocListenerOriginalClassKey);
	if (original || [self conformsToProtocol:@protocol(DeallocNotifier)])
		return (id<DeallocNotifier>)self;
	
	original = self.class;
	Class proxyClass = [(NSObject *)original associatedObjectForKey:kDeallocListenerAssociatedClassKey];
	
	if (!proxyClass) {
		NSString * newName = [NSString stringWithFormat:@"DeallocNotifying_%@", original];
		proxyClass = objc_allocateClassPair(original, [newName cStringUsingEncoding:NSASCIIStringEncoding], 0);
		objc_setAssociatedObject(proxyClass, kDeallocListenerOriginalClassKey, original, OBJC_ASSOCIATION_RETAIN);
		
		class_addProtocol(proxyClass, @protocol(DeallocNotifier));
		
		class_addMethod(proxyClass, @selector(addDeallocListener:), (IMP)&proxy_addDeallocListener, "v@:@@");
		class_addMethod(proxyClass, @selector(removeDeallocListener:), (IMP)&proxy_removeDeallocListener, "v@:@");
		class_addMethod(proxyClass, @selector(className), (IMP)&proxy_className, "@@:");
		class_addMethod(proxyClass, @selector(dealloc), (IMP)&proxy_dealloc, "v@:");
		class_addMethod(proxyClass, @selector(associatedObjectForKey:), (IMP)&proxy_associatedObjectForKey, "@@:*");
		class_addMethod(proxyClass, @selector(setAssociatedObject:forKey:), (IMP)&proxy_setAssociatedObject_forKey, "v@:@*");
		
		objc_registerClassPair(proxyClass);
		
		Class proxyClassClass = object_getClass(proxyClass);
		class_addMethod(proxyClassClass, @selector(className), (IMP)&proxy_className, "@@:");
		class_addMethod(proxyClassClass, @selector(associatedObjectForKey:), (IMP)&proxyClass_associatedObjectForKey, "@@:*");
		class_addMethod(proxyClassClass, @selector(setAssociatedObject:forKey:), (IMP)&proxyClass_setAssociatedObject_forKey, "v@:@*");
		
		objc_setAssociatedObject(original, kDeallocListenerAssociatedClassKey, proxyClass, OBJC_ASSOCIATION_RETAIN);
	}
	
	object_setClass(self, proxyClass);
	return (id<DeallocNotifier>)self;
}

- (void)stopDeallocationNotification
{
	Class original = objc_getAssociatedObject(self.class, kDeallocListenerOriginalClassKey);
	if (original && original == self.superclass && [self conformsToProtocol:@protocol(DeallocNotifier)])
		object_setClass(self, original);
}

@end
