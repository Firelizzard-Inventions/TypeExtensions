//
//  NSObject_ProtocolConformer.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/20/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject_ProtocolConformer.h"

#import "NSObject+methodDescriptionForSelectorInProtocol.h"
#import <objc/runtime.h>

@implementation NSObject_ProtocolConformer

- (id)init
{
	return nil;
}

- (id)initWithProtocol:(Protocol *)protocol
{
	if (!(self = [super init]))
		return nil;
	
	_protocol = protocol;
	
	return self;
}

- (struct objc_method_description)methodDescriptionForSelector:(SEL)aSelector
{
    return [[self class] methodDescriptionForSelector:aSelector inProtocol:self.protocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	if ([super respondsToSelector:aSelector]) return YES;
    struct objc_method_description description = [self methodDescriptionForSelector:aSelector];
    return !(isNullMethodDescription(description));
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *superResult = [super methodSignatureForSelector:aSelector];
    if (superResult) return superResult;
    struct objc_method_description description = [self methodDescriptionForSelector:aSelector];
    return [NSMethodSignature signatureWithObjCTypes:description.types];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:nil];
}

@end
