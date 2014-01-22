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
	Class class = self.class;
	
	do {
		unsigned int count = 0, i;
		Protocol * __unsafe_unretained * list = class_copyProtocolList(class, &count);
		
		for (i = 0; i < count; i++)
			if (!isNullMethodDescription([class methodDescriptionForSelector:aSelector inProtocol:list[i]]))
				goto throw;
		
		free(list);
	} while ((class = class.superclass));
	
	__supersInvoke(aSelector);
	
throw:
	@throw [[self class] _subclassImplementationExceptionFromMethod:aSelector isClassMethod:NO];
}

@end
