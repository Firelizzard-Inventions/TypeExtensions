//
//  NSObject+abstractProtocolConformer.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/20/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject+abstractProtocolConformer.h"

#import "NSObject+abstractClass.h"
#import "NSObject+supersequentImplementation.h"
#import "NSObject+methodDescriptionForSelectorInProtocol.h"

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
@implementation NSObject (abstractProtocolConformer)

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
	unsigned int count = 0;
	Protocol ** protocols = class_copyProtocolList([self class], &count);
	for (unsigned int i = 0; i < count; i++)
		if (!isNullMethodDescription([[self class] methodDescriptionForSelector:aSelector inProtocol:protocols[i]]))
			@throw [[self class] _subclassImplementationExceptionFromMethod:aSelector isClassMethod:NO];
	__supersInvoke();
}

@end
