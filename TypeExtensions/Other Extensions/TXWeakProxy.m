//
//  TXZeroingWeakProxy.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 1/21/14.
//  Copyright (c) 2014 Lens Flare. All rights reserved.
//

#import "TXWeakProxy.h"

@implementation TXWeakProxy

+ (instancetype)proxyWithTarget:(NSObject *)target
{
	return [[self alloc] initWithTarget:target];
}

- (id)initWithTarget:(NSObject *)target
{
//	if (!(self = [super init]))
//		return nil;
	
	_target = target;
	_targetClass = target.class;
	
	return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
	return [self.targetClass methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	[invocation invokeWithTarget:self.target];
}

@end
