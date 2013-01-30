//
//  NSObject+invocationForSelector.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/25/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSObject+invocationForSelector.h"

@implementation NSObject (invocationForSelector)

- (NSInvocation *)invocationForSelector:(SEL)selector
{
	NSMethodSignature * signature = [self methodSignatureForSelector:selector];
	NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
	
	invocation.target = self;
	invocation.selector = selector;
	
	return invocation;
}

@end
