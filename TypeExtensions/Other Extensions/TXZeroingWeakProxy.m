//
//  TXZeroingWeakProxy.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 1/4/14.
//  Copyright (c) 2014 Lens Flare. All rights reserved.
//

#import "TXZeroingWeakProxy.h"

@implementation TXZeroingWeakProxy

+ (instancetype)proxyWithReference:(NSObject *)object
{
	return [[[self alloc] initWithReference:object] autorelease];
}

@end
